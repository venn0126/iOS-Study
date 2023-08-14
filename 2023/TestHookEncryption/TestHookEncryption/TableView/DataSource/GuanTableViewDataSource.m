//
//  GuanTableViewDataSource.m
//  TestHookEncryption
//
//  Created by Augus on 2023/8/14.
//

#import "GuanTableViewDataSource.h"
#import "GuanBaseModel.h"
#import "GuanBaseTableCell.h"
#import "GuanRightLabelTableCell.h"
#import "GuanRightSwitcherTableCell.h"

@interface GuanTableViewDataSource ()<GuanBaseTableCellDelegate>

@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation GuanTableViewDataSource


#pragma mark - Init

- (instancetype)initWithDataArray:(NSArray *)dataArray {
    
    self = [super init];
    if(!self) return nil;
    
    _dataArray = dataArray;
    
    return self;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataArray.count ?: 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    GuanSectionModel *sectionModel = _dataArray[section];
    return sectionModel.guanRowData.count ?: 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GuanSectionModel *sectionModel = self.dataArray[indexPath.section];
    GuanCellModel *cellModel = sectionModel.guanRowData[indexPath.row];
    NSString *cellId = cellModel.guanCellId;
    GuanBaseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell) {
        if([cellId isEqualToString:@"GuanRightLabelTableCell"]) {
            cell = [[GuanRightLabelTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        } else if([cellId isEqualToString:@"GuanRightSwitcherTableCell"]) {
            cell = [[GuanRightSwitcherTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        } else {
            cellId = @"GuanBaseTableCell";
            cell = [[GuanBaseTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
    }
    cell.delegate = self;
    [cell configureModel:cellModel];
    return cell;
}



#pragma mark - GuanRightSwitcherTableCell

- (void)guanRigthSwitcherCell:(GuanBaseTableCell *)cell actionForSwitcher:(GuanSwitch *)switcher {
    
    NSLog(@"%@ %@",@(__func__),@(__LINE__));
}


- (void)guanRigthLabelCell:(GuanBaseTableCell *)cell actionForTap:(UITapGestureRecognizer *)tap {
    
    NSLog(@"%@ %@",@(__func__),@(__LINE__));

}


@end
