//
//  NWRunLoopMonitor.m
//  MonitoringLagForRunLoop
//
//  Created by Augus on 2021/1/29.
//

#import "NWRunLoopMonitor.h"
#import <execinfo.h>


// minimum
/// 每次计次的最小标准ms
static const NSInteger MXRMonitorRunloopMinOneStandstillMillisecond = 20;

/// 最小的计次次数
static const NSInteger MXRMonitorRunloopMinStandstillCount = 1;


// default
/// 超过多少毫秒为一次卡顿ms
static const NSInteger MXRMonitorRunloopOneStandstillMillisecond = 400;
/// 多少次卡顿纪录为一次有效卡顿
static const NSInteger MXRMonitorRunloopStandstillCount = 5;


@interface NWRunLoopMonitor (){
    /// 运行循环观察者
    CFRunLoopObserverRef _observer;
    /// 信号量
    dispatch_semaphore_t _semaphore;
    /// 运行循环的活动状态
    CFRunLoopActivity _activity;
    
    
}

/// 是否取消当前监控
@property (nonatomic, assign)  BOOL isCancel;
/// 耗时次数的统计
@property (nonatomic, assign)  NSInteger countTime;
/// 后台堆栈的存放数组
@property (nonatomic, strong) NSMutableArray *backtraces;

@end

@implementation NWRunLoopMonitor

+ (instancetype)monitored {
  
    static NWRunLoopMonitor *monitored = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitored = [[NWRunLoopMonitor alloc] init];
        monitored.singleMillisecond = MXRMonitorRunloopOneStandstillMillisecond;
        monitored.standstillCount = MXRMonitorRunloopStandstillCount;
    });
    
    return monitored;
}

#pragma mark - Privacy

// 注册一个observer来监控当前卡顿，回调函数是callbackWhenStandStill
- (void)registerObserver {
    
    // 设置observer的运行环境
    /*
     typedef struct {
         CFIndex    version;
         void *    info;
         const void *(*retain)(const void *info);
         void    (*release)(const void *info);
         CFStringRef    (*copyDescription)(const void *info);
     } CFRunLoopObserverContext;
     */
    CFRunLoopObserverContext context = {0,(__bridge void *)self,NULL,NULL};
    //  create observer
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runloopObserverCallBack,&context);
    // 将新建的observer加入到主线程中
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    // 创建信号
    _semaphore = dispatch_semaphore_create(0);
    
    __weak typeof(self)weakSelf = self;
    // 在子线程监控时长
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        while (YES) {
            // 判断当前监控状态
            if (strongSelf.isCancel) {
                return;
            }
            long dwc = dispatch_semaphore_wait(self->_semaphore, dispatch_time(DISPATCH_TIME_NOW, strongSelf.singleMillisecond * NSEC_PER_MSEC));
            if (dwc != 0) {
                // N次卡顿超过阈值记录位一次卡顿
                if (strongSelf->_activity == kCFRunLoopBeforeSources || strongSelf->_activity == kCFRunLoopAfterWaiting) {
                    // 累计卡顿次数小于标准次数
                    if (++strongSelf.countTime < strongSelf.standstillCount) {
                        NSLog(@"当前卡顿小于阈值（%ld）",(long)strongSelf.countTime);
                        continue;
                    }
                    
                    // printf stack info
                    [strongSelf logStack];
                    [strongSelf printfLogStack];
                    
                    
                    
                    // call back && happen lag
                    if (strongSelf.callbackWhenStandStill) {
                        strongSelf.callbackWhenStandStill();
                    }
                }
            }
            // 重置累计次数
            strongSelf.countTime = 0;
        }
    });
    
    
    
}
/// init monitor and semaphore
static void runloopObserverCallBack(CFRunLoopObserverRef observer,CFRunLoopActivity activity,void *info){
    
    NWRunLoopMonitor *monitor = [NWRunLoopMonitor monitored];
    // record activity
    monitor->_activity = activity;
    // send singal
    dispatch_semaphore_t semaphore = monitor->_semaphore;
    dispatch_semaphore_signal(semaphore);
}

- (void)logStack {
    
    void *callstack[128];
    int frames = backtrace(callstack,128);
    char** strs = backtrace_symbols(callstack, frames);
    _backtraces = [NSMutableArray arrayWithCapacity:frames];
    for (int i = 0; i < frames; i++) {
        [_backtraces addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
}

- (void)printfLogStack {
    
    NSLog(@"=============堆栈==========\n %@ \n",_backtraces);
}

#pragma mark - Setter

- (void)setSingleMillisecond:(int)singleMillisecond {
    
    [self willChangeValueForKey:@"singleMillisecond"];
    _singleMillisecond = singleMillisecond >= MXRMonitorRunloopMinOneStandstillMillisecond ? singleMillisecond : MXRMonitorRunloopMinOneStandstillMillisecond;
    [self didChangeValueForKey:@"singleMillisecond"];
}

- (void)setStandstillCount:(int)standstillCount {
    
    [self willChangeValueForKey:@"standstillCount"];
    _standstillCount = standstillCount >= MXRMonitorRunloopMinStandstillCount ? standstillCount : MXRMonitorRunloopMinStandstillCount;
    [self didChangeValueForKey:@"standstillCount"];
}

#pragma mark - Public

- (void)startMonitor {
    
    self.isCancel = NO;
    [self registerObserver];
    
}

- (void)endMonitor {
    
    self.isCancel = YES;
    if (!_observer) return;
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    CFRelease(_observer);
    _observer = NULL;
    
}
@end
