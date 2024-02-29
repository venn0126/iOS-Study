//
//  YFTabBarViewController.h
//  AnimationDemo
//
//  Created by EnforLiu on 15/11/26.
//  Copyright © 2015年 EnforLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFOneViewController.h"
#import "YFTwoViewController.h"
#import "YFThreeViewController.h"
#import "YFFourViewController.h"
@interface YFTabBarViewController : UITabBarController

@property (strong, nonatomic) YFOneViewController   *oncVC;
@property (strong, nonatomic) YFTwoViewController   *twoVC;
@property (strong, nonatomic) YFThreeViewController *threeVC;
@property (strong, nonatomic) YFFourViewController  *fourVC;

@property (strong, nonatomic) UINavigationController *nav1;
@property (strong, nonatomic) UINavigationController *nav2;
@property (strong, nonatomic) UINavigationController *nav3;
@property (strong, nonatomic) UINavigationController *nav4;

@property (strong, nonatomic) UITabBarItem *item1;
@property (strong, nonatomic) UITabBarItem *item2;
@property (strong, nonatomic) UITabBarItem *item3;
@property (strong, nonatomic) UITabBarItem *item4;


@end
