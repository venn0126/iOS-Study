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
        
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        // 这个方法一旦执行，线程会永久存在内存中无法停止，除非进程结束
//        [[NSRunLoop currentRunLoop] run];
        
        while (weakSelf && !weakSelf.isSending) {
            NSLog(@"augus weakself ---%@",weakSelf);
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        NSLog(@"---- end thread --- %@", [NSThread currentThread]);
    }];
    [self.augusThread start];

    
    
}


- (void)testTheadTask {
    NSLog(@"testTheadTask-----%@",[NSThread currentThread]);
}


- (void)stopThreadAction {
    NSLog(@"%s",__func__);
    
    // waitUntilDone:NO，不等待子线程的方法，才执行下面的方法，同时执行
    // waitUntilDone:YES，等待子线程的方法结束，才执行下面的方法
    if(!self.augusThread) return;
    [self performSelector:@selector(stopThead) onThread:self.augusThread withObject:nil waitUntilDone:YES];

}


- (void)stopThead {
    
    self.isSending = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    
    NSLog(@"%s %@ %@",__func__,[NSThread currentThread],self.augusThread);
    self.augusThread = nil;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    if(!self.augusThread) return;
    [self performSelector:@selector(testTheadTask) onThread:self.augusThread withObject:nil waitUntilDone:NO];

}


- (void)dealloc {
    
    NSLog(@"%s", __func__);
    [self stopThreadAction];
}


@end
