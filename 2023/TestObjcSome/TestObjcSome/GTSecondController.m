//
//  GTSecondController.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/17.
//

#import "GTSecondController.h"
#import "GTThread.h"
#import "GTSecondController.h"
#import "GTPerson.h"
#import "NSObject+SNSafeKVO.h"
#import "GTAugusView.h"
#import "SNCalcuateView.h"


@interface GTSecondController ()

@property (nonatomic, strong) GTThread *augusThread;
@property (nonatomic, assign) BOOL isStoped;
@property (nonatomic, strong) GTPerson *augusPerson;
@property (nonatomic, strong) GTAugusView *augusView;



@end

@implementation GTSecondController

/// 状态栏高度
CGFloat SNStatusBarHeight(void) {
    static CGFloat statusBarHeight;
    if (statusBarHeight <= 0) {
        if (@available(iOS 13.0, *)) {
            UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
            statusBarHeight = statusBarManager.statusBarFrame.size.height;
        } else {
            statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        }
    }
    
    return statusBarHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 初始化相关参数
    self.title = @"计算器";
    self.view.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:185/255.0 blue:193/255.0 alpha:1];
    self.isStoped = NO;
    
    
//    [self testControllableThead];
    
//    [self testSafeKVO];
    
    SNCalcuateView *calcuateView = [[SNCalcuateView alloc] initWithFrame:CGRectMake(0, SNStatusBarHeight()+44, self.view.frame.size.width, 0)];
    [self.view addSubview:calcuateView];
}


- (void)testSafeKVO {
    
    
    // 添加和删除顺序不匹配 ✅
    /*
     Terminating app due to uncaught exception 'NSRangeException', reason: 'Cannot remove an observer <GTSecondController 0x10121ac60> for the key path "name" from <GTPerson 0x280d72fc0> because it is not registered as an observer.
     */
//    self.augusPerson = [[GTPerson alloc] init];
    
//    [self.augusPerson addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//    [person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:(__bridge void *)@(1)];
//
//    [person removeObserver:self forKeyPath:@"name"];
//    [person removeObserver:self forKeyPath:@"name" context:(__bridge void *)@(1)];
    
    // fix
//    [person augus_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//    [person augus_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:(__bridge void *)@(1)];
//
//    [person augus_removeObserver:self forKeyPath:@"name"];
//    [person augus_removeObserver:self forKeyPath:@"name" context:(__bridge void *)@(1)];
    
    
    // 多次删除同一个 ✅
    /*
     Terminating app due to uncaught exception 'NSRangeException', reason: 'Cannot remove an observer <GTSecondController 0x102b23160> for the key path "name" from <GTPerson 0x2830670e0> because it is not registered as an observer.
     */
//    [person removeObserver:self forKeyPath:@"name"];
//    [person removeObserver:self forKeyPath:@"name"];
    
    // 删除不存在的 ✅
//    [person removeObserver:self forKeyPath:@"name2"];
    
    
    /*
     Terminating app due to uncaught exception 'NSRangeException', reason: 'Cannot remove an observer <(null) 0x0> for the key path "name" from <GTPerson 0x280f2d3e0> because it is not registered as an observer.
     */
    // 监听者先于被监听者 释放，并且释放前没有清空 KVO ✅
    self.augusPerson = [[GTPerson alloc] init];
    self.augusView = [[GTAugusView alloc] init];
//    [self.augusPerson addObserver:self.augusView forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//    [self.augusPerson augus_addObserver:self.augusView forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//    self.augusPerson.name = @"augusView";
//    self.augusPerson = nil;
    
    
    // TODO: 被监听者先于监听者释放，并且在释放前没有清空 KVO
//    [self.augusPerson addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//    self.augusPerson = nil;
    
    [self.augusPerson addObserver:self.augusView forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    self.augusPerson.name = @"augusView";
    self.augusPerson = nil;
    

    // 没有实现observeValueForKeyPath方法 ✅
    /*
     Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: '<GTSecondController: 0x113f37ec0>: An -observeValueForKeyPath:ofObject:change:context: message was received but not handled.
     Key path: name
     Observed object: <GTPerson: 0x283ab1340>
     Change: {
         kind = 1;
         new = 11111;
     }
     Context: 0x0'
     
     */
//    [self.augusPerson addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//    self.augusPerson.name = @"11111";
    
    
    // 没有移除KVO
//    [self.augusPerson addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//    self.augusPerson.name = @"222";
    

    
    
    // 多线程添加和删除测试 ✅
    /*
     Terminating app due to uncaught exception 'NSRangeException', reason: 'Cannot remove an observer <GTSecondController 0x105424d50> for the key path "test" from <GTPerson 0x2817c2900> because it is not registered as an observer.
     */
    //    self.augusPerson = [[GTPerson alloc] init];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//
//        for (int i = 0; i < 100000; i++) {
////            [self.augusPerson addObserver:self forKeyPath:@"test" options:NSKeyValueObservingOptionNew context:nil];
//            [self.augusPerson augus_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//            NSLog(@"add observer %d",i);
//        }
//
//    });
//
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        for (int i = 0; i < 100000; i++) {
////            [self.augusPerson removeObserver:self forKeyPath:@"test"];
//            [self.augusPerson augus_removeObserver:self forKeyPath:@"name"];
//            NSLog(@"remove observer %d",i);
//
//        }
//
//    });


    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if([keyPath isEqualToString:@"name"]) {
        NSLog(@"person name change %@",change);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


/// 测试可控子线程
- (void)testControllableThead {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Stop Thread" forState:UIControlStateNormal];
    button.titleLabel.textColor = UIColor.blackColor;
    button.frame = CGRectMake(100, 200, 100, 50);
    [button sizeToFit];
    [button addTarget:self action:@selector(stopThreadOuter) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = UIColor.greenColor;
    button.layer.cornerRadius = 5.0;
    [self.view addSubview:button];
    
    
    __weak typeof(self)weakSelf = self;
    self.augusThread = [[GTThread alloc] initWithBlock:^{
       
        NSLog(@"---- begin thread ---- %@", [NSThread currentThread]);
        
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        // 这个方法一旦执行，线程会永久存在内存中无法停止，除非进程结束
//        [[NSRunLoop currentRunLoop] run];
        
        while (weakSelf && !weakSelf.isStoped) {
            NSLog(@"augus weakself ---%@",weakSelf);
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        NSLog(@"---- end thread --- %@", [NSThread currentThread]);
    }];
    [self.augusThread start];

    
    
}


/// 结束线程生命周期的外部方法
- (void)stopThreadOuter {
    NSLog(@"%s",__func__);
    
    // waitUntilDone:NO，不等待子线程的方法，才执行下面的方法，同时执行
    // waitUntilDone:YES，等待子线程的方法结束，才执行下面的方法
    if(!self.augusThread) return;
    [self performSelector:@selector(stopTheadInner) onThread:self.augusThread withObject:nil waitUntilDone:YES];

}


/// 结束线程生命周期的内部方法
- (void)stopTheadInner {
    
    self.isStoped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    
    NSLog(@"%s %@ %@",__func__,[NSThread currentThread],self.augusThread);
    self.augusThread = nil;
}


/// 用户操作
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if(!self.augusThread) return;
    [self performSelector:@selector(testTheadTask) onThread:self.augusThread withObject:nil waitUntilDone:NO];

}


- (void)testTheadTask {
    NSLog(@"%s-----%@",__func__,[NSThread currentThread]);
}


/// 当前对象的销毁方法
- (void)dealloc {
    
    NSLog(@"%s", __func__);
    [self stopThreadOuter];
    
    
    
    // 监听者先于被监听者 释放，并且释放前没有清空 KVO
//    [self.augusPerson removeObserver:self.augusView forKeyPath:@"name"];
//    [self.augusPerson augus_removeObserver:self.augusView forKeyPath:@"name"];
    
    
    // 被监听者先于监听者释放，并且在释放前没有清空 KVO
    
}


@end
