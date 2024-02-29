//
//  YFTabBarViewController.m
//  AnimationDemo
//
//  Created by EnforLiu on 15/11/26.
//  Copyright © 2015年 EnforLiu. All rights reserved.
//

#import "YFTabBarViewController.h"

@interface YFTabBarViewController ()

@end

@implementation YFTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.oncVC = [[YFOneViewController alloc]init];
    self.oncVC.title = @"动画";
    
    self.twoVC = [[YFTwoViewController alloc]init];
    self.twoVC.title = @"切换view";
    
    self.threeVC = [[YFThreeViewController alloc]init];
    self.threeVC.title = @"切换Controller";
    
    self.fourVC = [[YFFourViewController alloc]init];
    self.fourVC.title = @"其他";
    
    self.nav1 = [[UINavigationController alloc]initWithRootViewController:self.oncVC];
    self.nav2 = [[UINavigationController alloc]initWithRootViewController:self.twoVC];
    self.nav3 = [[UINavigationController alloc]initWithRootViewController:self.threeVC];
    self.nav4 = [[UINavigationController alloc]initWithRootViewController:self.fourVC];

    self.item1 = [[UITabBarItem alloc]initWithTitle:self.oncVC.title image:[UIImage imageNamed:@"icon1"] selectedImage:[UIImage imageNamed:@"selectIcon1"]];
    self.item2 = [[UITabBarItem alloc]initWithTitle:self.twoVC.title image:[UIImage imageNamed:@"icon2"] selectedImage:[UIImage imageNamed:@"selectIcon2"]];
    self.item3 = [[UITabBarItem alloc]initWithTitle:self.threeVC.title image:[UIImage imageNamed:@"icon3"] selectedImage:[UIImage imageNamed:@"selectIcon3"]];
    self.item4 = [[UITabBarItem alloc]initWithTitle:self.fourVC.title image:[UIImage imageNamed:@"icon4"] selectedImage:[UIImage imageNamed:@"selectIcon4"]];

    self.nav1.tabBarItem = self.item1;
    self.nav2.tabBarItem = self.item2;
    self.nav3.tabBarItem = self.item3;
    self.nav4.tabBarItem = self.item4;
    
    self.tabBar.tintColor = [UIColor colorWithRed:9/255.0 green:187/255.0 blue:7/255.0 alpha:1];
    
    self.viewControllers = @[self.nav1,self.nav2,self.nav3,self.nav4];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
