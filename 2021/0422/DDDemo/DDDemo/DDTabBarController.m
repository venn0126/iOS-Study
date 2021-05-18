//
//  DDTabBarController.m
//  DDDemo
//
//  Created by Augus on 2021/5/16.
//

#import "DDTabBarController.h"
#import "ViewController.h"
#import "TwoController.h"

@interface DDTabBarController ()

@end

@implementation DDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    ViewController *one = [ViewController new];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:one];
    nav1.tabBarItem.image = [UIImage imageNamed:@"home_1"];
    
    TwoController *two = [TwoController new];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:two];
    nav2.tabBarItem.image = [UIImage imageNamed:@"settings_1"];
    

    self.viewControllers = @[nav1,nav2];
    
}

- (void)dd_updateTabBarIcon:(completionHander)completion {
    
    // 获取当前tarbarvc --- tarbaritem
    NSArray *vcArray = self.viewControllers;
    for (int i = 0; i < vcArray.count; i++) {
        UINavigationController *nav = (UINavigationController *)vcArray[i];
        if (i == 0) {
            nav.tabBarItem.image = [UIImage imageNamed:@"home_2"];
        } else {
            nav.tabBarItem.image = [UIImage imageNamed:@"settings_2"];
        }
    }
    
    if (completion) {
        completion();
    }
    
}




//- ()

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
