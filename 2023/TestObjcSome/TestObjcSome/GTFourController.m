//
//  GTFourController.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/20.
//

#import "GTFourController.h"
#import "GTControllableCThread.h"
#import "GTProxy.h"
#import "GTProxyTarget.h"

@interface GTFourController ()

@property (nonatomic, strong) GTControllableCThread *augusThread;

@property (nonatomic, strong) NSTimer *augusTimer;
@property (nonatomic, strong) CADisplayLink *augusDisplayLink;

@end

@implementation GTFourController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Four";
    self.view.backgroundColor = UIColor.whiteColor;
//    [self testNotMainThead];
    
    
    self.augusTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:[GTProxyTarget proxyWithTarget:self] selector:@selector(testTimer) userInfo:nil repeats:YES];
    
//    self.augusDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(testLink)];
//    [self.augusDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
   
}


- (void)testTimer {
    
    NSLog(@"%s",__func__);
    
}


- (void)testLink {
    
    NSLog(@"%s",__func__);

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
    
    
    self.augusThread = [[GTControllableCThread alloc] init];

}


- (void)stopThreadAction {
    [self.augusThread gt_cstopThead];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.augusThread gt_cexecuteTask:^{
        NSLog(@"testTask %@",[NSThread currentThread]);
    }];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
//    [self stopThreadAction];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
