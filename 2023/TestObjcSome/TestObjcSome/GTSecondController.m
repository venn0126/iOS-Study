//
//  GTSecondController.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/17.
//

#import "GTSecondController.h"
#import "GTThread.h"
#import "GTSecondController.h"



NSInteger currentIndex = 0;


@interface GTSecondController ()


@property (nonatomic, strong) GTThread *augusThread;
@property (nonatomic, strong) NSTimer *gtTimer;
@property (nonatomic, assign) BOOL isSending;

@end

@implementation GTSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"Second";
    self.view.backgroundColor = UIColor.whiteColor;
    self.isSending = NO;
    [self testNotMainThead];
}



- (void)testNotMainThead {
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Stop Thread" forState:UIControlStateNormal];
    button.titleLabel.textColor = UIColor.blackColor;
    button.frame = CGRectMake(100, 200, 100, 50);
    [button sizeToFit];
    [button addTarget:self action:@selector(stopThreadAction) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = UIColor.greenColor;
    button.layer.cornerRadius = 5.0;
    [self.view addSubview:button];
    
    
    __weak typeof(self)weakSelf = self;
    self.augusThread = [[GTThread alloc] initWithBlock:^{
       
        NSLog(@"---- begin thread ---- %@", [NSThread currentThread]);
        
//        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        // 这个方法一旦执行，线程会永久存在内存中无法停止，除非进程结束
//        [[NSRunLoop currentRunLoop] run];
        while (!weakSelf.isSending) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        NSLog(@"---- end thread --- %@", [NSThread currentThread]);
    }];
    [self.augusThread start];

    
    
}

- (void)seupGTTimer {
    
    NSLog(@"seupGTTimer");
    self.gtTimer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        NSLog(@"time done %ld",currentIndex);
//        if(currentIndex > 50) {
//            [self.gtTimer invalidate];
//            self.gtTimer = nil;
//        }
        currentIndex++;
        
    }];
    
    NSLog(@"current thread is %@ add timer",[NSThread currentThread]);
    [[NSRunLoop currentRunLoop] addTimer:_gtTimer forMode:NSDefaultRunLoopMode];
    
}


- (void)stopThreadAction {
    NSLog(@"%s",__func__);
    [self performSelector:@selector(stopThead) onThread:self.augusThread withObject:nil waitUntilDone:NO];

}


- (void)stopTimer {
    
    [self.gtTimer invalidate];
    self.gtTimer = nil;
    
}


- (void)stopThead {
    
    self.isSending = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    [self stopTimer];
    
    NSLog(@"%s %@ %@",__func__,[NSThread currentThread],self.gtTimer);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self performSelector:@selector(seupGTTimer) onThread:self.augusThread withObject:nil waitUntilDone:NO];

}


- (void)dealloc {
    
    NSLog(@"%s", __func__);
//    self.augusThread = nil;
}


@end
