//
//  GTThirdController.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/20.
//

#import "GTThirdController.h"
#import "GTControllableThead.h"

@interface GTThirdController ()

@property (nonatomic, strong) GTControllableThead *augusThread;

@end

@implementation GTThirdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Third";
    self.view.backgroundColor = UIColor.whiteColor;
    
    
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
    
    
    self.augusThread = [[GTControllableThead alloc] init];

}


- (void)stopThreadAction {
    [self.augusThread gt_stopThead];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.augusThread gt_executeTask:^{
        NSLog(@"testTask %@",[NSThread currentThread]);
    }];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
    [self stopThreadAction];
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
