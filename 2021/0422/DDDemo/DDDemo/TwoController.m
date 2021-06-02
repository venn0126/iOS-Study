//
//  TwoController.m
//  DDDemo
//
//  Created by Augus on 2021/5/16.
//

#import "TwoController.h"
#import "ThreeController.h"

@interface TwoController ()

@end

@implementation TwoController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // add observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dd_receiveNofitication:) name:@"DDEventName" object:nil];
}

- (void)dd_receiveNofitication:(NSNotification *)notification {
    
    
   
    NSLog(@"%@ : %@(%@)",@(__PRETTY_FUNCTION__),@(__LINE__),[NSThread currentThread]);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.blueColor;
    self.title = @"Mine";
    
    [self someUI];
}

- (void)someUI {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button setBackgroundColor:UIColor.redColor];
    [button addTarget:self action:@selector(updateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 300, 100, 50);
    [self.view addSubview:button];
    
    
}

- (void)updateButtonAction:(UIButton *)sender {
    
    ThreeController *three = [ThreeController new];
    [self.navigationController pushViewController:three animated:YES];
//    NSLog(@"push to detail");

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
