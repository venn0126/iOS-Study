//
//  YFTwoViewController.h
//  AnimationDemo
//
//  Created by EnforLiu on 15/11/26.
//  Copyright © 2015年 EnforLiu. All rights reserved.
//

#import "YFBaseViewController.h"

@interface YFTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *iconImageView;
@end

@interface YFTwoViewController : YFBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@end
