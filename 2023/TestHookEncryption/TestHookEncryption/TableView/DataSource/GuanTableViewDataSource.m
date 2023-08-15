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
#import "GuanSwitch.h"
#import "GuanAlert.h"

#define GuanUserDefaults [NSUserDefaults standardUserDefaults]

#define kGuanRealTimeSwitcherOn @"kGuanRealTimeSwitcherOn"
#define kGuanReservationTimeSwitcherOn @"kGuanReservationTimeSwitcherOn"

#define kGuanRealTimeMinDistance @"kGuanRealTimeMinDistance"
#define kGuanReservationTimeMinDistance @"kGuanReservationTimeMinDistance"


@interface GuanTableViewDataSource ()<GuanBaseTableCellDelegate>



@end

@implementation GuanTableViewDataSource


#pragma mark - Init

- (instancetype)initWithDataArray:(NSArray *)dataArray {
    
    self = [super init];
    if(!self) return nil;
    
    if(!dataArray) {
        dataArray = [self configureData];
    }
    
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
    
    NSString *saveKey;
    if([cell.guanTitleLabel.text containsString:@"实时"]) {
        saveKey = kGuanRealTimeSwitcherOn;
    } else if([cell.guanTitleLabel.text containsString:@"预约"]) {
        saveKey = kGuanReservationTimeSwitcherOn;
    }

    // update data
    [GuanUserDefaults setBool:switcher.on forKey:saveKey];
    // update ui
    NSLog(@"%@ %@",@(__func__),@(__LINE__));
    [self guan_reloadData];
    if(self.reloadDataBlock) {
        self.reloadDataBlock();
    }
    
}


- (void)guanRigthLabelCell:(GuanBaseTableCell *)cell actionForTap:(UITapGestureRecognizer *)tap {
    
    NSString *message;
    NSString *saveKey;
    if([cell.guanTitleLabel.text containsString:@"实时"]) {
        message = @"请输入实时订单的过滤最小距离";
        saveKey = kGuanRealTimeMinDistance;
    } else if([cell.guanTitleLabel.text containsString:@"预约"]) {
        message = @"请输入预约订单的过滤最小距离";
        saveKey = kGuanReservationTimeMinDistance;
    }

    [GuanAlert showAlertWithTitle:message message:@"" confirmTitle:@"确认" cancelTitle:@"取消" preferredStyle:UIAlertControllerStyleAlert confirmHandle:nil cancleHandle:^{
        
    } isNeedOneInputTextField:YES textFieldPlaceHolder:@"请输入距离" textFieldKeyboardType:UIKeyboardTypeNumberPad confirmTextFieldHandle:^(NSString * _Nonnull inputText) {
        if(inputText && inputText.length > 0) {
            [GuanUserDefaults setObject:inputText forKey:saveKey];
        }
        
        [self guan_reloadData];
        if(self.reloadDataBlock) {
            self.reloadDataBlock();
        }
    }];
    
}


- (NSArray *)configureData {
    
    BOOL isRealTimeOn =  [GuanUserDefaults boolForKey:kGuanRealTimeSwitcherOn];
    NSDictionary *cellDict0 = @{@"guanTitleText":@"实时订单开关",@"guanRigthOn":@(isRealTimeOn),@"guanRightText":@0,@"guanCellId":@"GuanRightSwitcherTableCell"};
    GuanCellModel *cellModel0 = [GuanCellModel yy_modelWithDictionary:cellDict0];
    
    GuanCellModel *cellModel2;
    if(isRealTimeOn) {
        NSString *realDistance = [GuanUserDefaults objectForKey:kGuanRealTimeMinDistance];
        NSDictionary *cellDict2 = @{@"guanTitleText":@"  输入实时最小距离",@"guanRigthOn":@(isRealTimeOn),@"guanRightText":realDistance ?: @"0",@"guanCellId":@"GuanRightLabelTableCell"};
        cellModel2 = [GuanCellModel yy_modelWithDictionary:cellDict2];
    }
    

    BOOL isReservationTimeOn =  [GuanUserDefaults boolForKey:kGuanReservationTimeSwitcherOn];
    NSDictionary *cellDict1 = @{@"guanTitleText":@"预约订单开关",@"guanRigthOn":@(isReservationTimeOn),@"guanRightText":@0,@"guanCellId":@"GuanRightSwitcherTableCell"};
    GuanCellModel *cellModel1 = [GuanCellModel yy_modelWithDictionary:cellDict1];
    
    
    GuanCellModel *cellModel3;
    if(isReservationTimeOn) {
        NSString *reservationDistance = [GuanUserDefaults objectForKey:kGuanReservationTimeMinDistance];
        NSDictionary *cellDict3 = @{@"guanTitleText":@"  输入预约最小距离",@"guanRigthOn":@(isReservationTimeOn),@"guanRightText":reservationDistance ?: @"0",@"guanCellId":@"GuanRightLabelTableCell"};
        cellModel3 = [GuanCellModel yy_modelWithDictionary:cellDict3];
    }


    // guanRowData
    NSMutableArray *cellArray0 = [NSMutableArray array];
    NSMutableArray *cellArray1 = [NSMutableArray array];

    [cellArray0 addObject:cellModel0];
    if(cellModel2) {
        [cellArray0 addObject:cellModel2];
    }
    
    [cellArray1 addObject:cellModel1];
    if(cellModel3) {
        [cellArray1 addObject:cellModel3];
    }

    NSDictionary *sectionDict0 = @{@"guanRowData":cellArray0,@"guanSectionTitle":@"实时订单"};
    GuanSectionModel *sectionModel0 = [GuanSectionModel yy_modelWithDictionary:sectionDict0];
    NSDictionary *sectionDict1 = @{@"guanRowData":cellArray1,@"guanSectionTitle":@"预约订单"};
    GuanSectionModel *sectionModel1 = [GuanSectionModel yy_modelWithDictionary:sectionDict1];

    NSArray *sectionArray = @[sectionModel0, sectionModel1];
    
    return sectionArray;
}


#pragma mark - Public Methods

- (void)guan_reloadData {
    
    self.dataArray = [self configureData];
    
}


@end
