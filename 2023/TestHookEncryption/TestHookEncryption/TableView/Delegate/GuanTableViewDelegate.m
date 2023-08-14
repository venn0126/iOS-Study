//
//  GuanTableViewDelegate.m
//  TestHookEncryption
//
//  Created by Augus on 2023/8/14.
//

#import "GuanTableViewDelegate.h"
#import "GuanBaseModel.h"


static const CGFloat kGuanTableCellRowHeight = 50.0;


@interface GuanTableViewDelegate ()

@property (nonatomic, strong) NSArray <GuanSectionModel *>*dataArray;


@end

@implementation GuanTableViewDelegate

- (instancetype)initWithDataArray:(NSArray <GuanSectionModel *> *)dataArray {
    
    self = [super init];
    if(!self) return nil;
    
    _dataArray = dataArray;
    
    return self;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kGuanTableCellRowHeight;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(20, 8, 320, 20);
    myLabel.font = [UIFont boldSystemFontOfSize:18];
    myLabel.text = self.dataArray[section].guanSectionTitle ?: @"";

    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:myLabel];

    return headerView;
}


@end
