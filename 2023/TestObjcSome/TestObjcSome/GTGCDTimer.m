//
//  GTGCDTimer.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/27.
//

#import "GTGCDTimer.h"

static NSMutableDictionary *gt_timers;
dispatch_semaphore_t gt_semaphore;

@implementation GTGCDTimer


+ (void)initialize {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gt_timers = [NSMutableDictionary dictionary];
        gt_semaphore = dispatch_semaphore_create(1);
    });
}

+ (NSString *)gt_executeTask:(void (^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async {
    
    
    if(!task || start < 0 || (interval <= 0 && repeats)) return nil;
    
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    
    // 创建一个定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置时间（start是几秒后开始执行，interval时间间隔）
    // leeway ：误差多少，0代表没有误差
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, (int64_t)start * NSEC_PER_SEC), (uint64_t)interval * NSEC_PER_SEC, 0);
    
    
    dispatch_semaphore_wait(gt_semaphore, DISPATCH_TIME_FOREVER);

    // 定时器唯一标识
    NSString *taskName = [NSString stringWithFormat:@"%lu",(unsigned long)gt_timers.count];
    // 为什么无法启动，需要使用一个强引用包住timer对象
    gt_timers[taskName] = timer;
    
    dispatch_semaphore_signal(gt_semaphore);

    
    // 设置回调
    dispatch_source_set_event_handler(timer, ^{
       
        task();
        
        if(!repeats) {
            [self gt_cancelTask:taskName];
        }
        
    });
    
    // 启动定时器
    dispatch_resume(timer);
    
    return taskName;
}


+ (NSString *)gt_executeTask:(id)target selector:(SEL)selector start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async {
    
    if(!target || !selector) return nil;
    
    NSString *taskName = [self gt_executeTask:^{
        if([target respondsToSelector:selector]) {
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:selector];
#pragma clang diagnostic pop
        }
    } start:start interval:interval repeats:repeats async:async];
    
    return taskName;
}


+ (void)gt_cancelTask:(NSString *)name {
    
    
    if(name.length == 0) return;
    
    dispatch_semaphore_wait(gt_semaphore, DISPATCH_TIME_FOREVER);
    
    dispatch_source_t timer = gt_timers[name];
    if(timer) {
        dispatch_source_cancel(timer);
        [gt_timers removeObjectForKey:name];
    }
    
    dispatch_semaphore_signal(gt_semaphore);
}

@end
