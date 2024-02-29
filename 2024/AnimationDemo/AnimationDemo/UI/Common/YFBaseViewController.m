//
//  YFBaseViewController.m
//  AnimationDemo
//
//  Created by EnforLiu on 15/11/26.
//  Copyright © 2015年 EnforLiu. All rights reserved.
//

#import "YFBaseViewController.h"

@interface YFBaseViewController ()

@end

@implementation YFBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //导航条颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:200/255 green:200/255 blue:200/255 alpha:1];
    //导航条不透明
    self.navigationController.navigationBar.translucent  = NO;
    //导航条标题属性
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //标签栏不透明
    self.tabBarController.tabBar.translucent = NO;
    
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
