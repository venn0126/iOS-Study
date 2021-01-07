//
//  I2ViewController.m
//  IGuide
//
//  Created by whatsbug on 12/17/2019.
//  Copyright (c) 2019 whatsbug. All rights reserved.
//

#import "I2ViewController.h"
#import "I2DefaultStyleViewController.h"
#import "I2TomStyleViewController.h"
#import "I2JerryStyleViewController.h"
#import "I2DIYAnimationViewController.h"
#import "I2DIYAnnotationViewController.h"
#import "I2OtherViewController.h"

@interface I2ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation I2ViewController

//MARK: - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = UIColor.whiteColor;
    self.tableView.tableFooterView = UIView.new;
    self.dataArray = @[@"默认样式Apple",
                       @"内置样式Tom",
                       @"内置样式Jerry",
                       @"自定义动画",
                       @"自定义注解视图",
                       @"其他知识点"];
}

//MARK: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.description forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

//MARK: - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *toVC = nil;
    if (indexPath.row == 0) {
        toVC = I2DefaultStyleViewController.new;
    } else if (indexPath.row == 1) {
        toVC = I2TomStyleViewController.new;
    } else if (indexPath.row == 2) {
        toVC = I2JerryStyleViewController.new;
    } else if (indexPath.row == 3) {
        toVC = I2DIYAnimationViewController.new;
    } else if (indexPath.row == 4) {
        toVC = I2DIYAnnotationViewController.new;
    } else if (indexPath.row == 5) {
        toVC = I2OtherViewController.new;
    }
    
    [self.navigationController pushViewController:toVC animated:YES];
}

@end
