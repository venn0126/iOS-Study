//
//  YFThreeViewController.h
//  AnimationDemo
//
//  Created by EnforLiu on 15/11/26.
//  Copyright © 2015年 EnforLiu. All rights reserved.
//

#import "YFBaseViewController.h"
#import "YFTwoViewController.h"
@interface YFThreeViewController : YFBaseViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;
@end
