//
//  GTSecondController.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/17.
//

#import "GTSecondController.h"
#import "GTThread.h"
#import "GTSecondController.h"


@interface GTSecondController ()

@property (nonatomic, strong) GTThread *augusThread;
@property (nonatomic, assign) BOOL isStoped;

@end

@implementation GTSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 初始化相关参数
    self.title = @"Second";
    self.view.backgroundColor = UIColor.whiteColor;
    self.isStoped = NO;
    
    
    [self testControllableThead];
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
}


@end
