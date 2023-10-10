//
//  MengTableViewDataSource.m
//  TestHookEncryption
//
//  Created by Augus on 2023/10/11.
//

#import "MengTableViewDataSource.h"
#import "GuanBaseModel.h"
#import "GuanBaseTableCell.h"
#import "MengRightLabelTableCell.h"
#import "GuanSwitch.h"
#import "GuanAlert.h"


@interface MengTableViewDataSource ()<GuanBaseTableCellDelegate>

@end


#define GuanUserDefaults [NSUserDefaults standardUserDefaults]

#define kMengGetConfigServer @"kMengGetConfigServer"
#define kMengGetCardNumber @"kMengGetCardNumber"

@implementation MengTableViewDataSource

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
        if([cellId isEqualToString:@"MengRightLabelTableCell"]) {
            cell = [[MengRightLabelTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        } else {
            cellId = @"GuanBaseTableCell";
            cell = [[GuanBaseTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
    }
    cell.delegate = self;
    [cell configureModel:cellModel];
    return cell;
}


- (void)guanRigthLabelCell:(GuanBaseTableCell *)cell actionForTap:(UITapGestureRecognizer *)tap {
    
    NSString *message;
    NSString *saveKey;
    NSString *defaultValue;
    if([cell.guanTitleLabel.text containsString:@"配置服务地址"]) {
        message = @"请输入配置服务地址";
        saveKey = kMengGetConfigServer;
        defaultValue = [GuanUserDefaults objectForKey:saveKey] ?: @"https://06202023.com:10001";
    } else if([cell.guanTitleLabel.text containsString:@"银行卡号码"]) {
        message = @"请输入银行卡号码";
        saveKey = kMengGetCardNumber;
        defaultValue = [GuanUserDefaults objectForKey:saveKey] ?: @"0000000000";
    }
    
    
    [GuanAlert showAlertWithTitle:message message:@"" confirmTitle:@"确认" cancelTitle:@"取消" preferredStyle:UIAlertControllerStyleAlert confirmHandle:nil cancleHandle:^{
        
    } isNeedOneInputTextField:YES textFieldPlaceHolder:defaultValue textFieldKeyboardType:UIKeyboardTypeDefault confirmTextFieldHandle:^(NSString * _Nonnull inputText) {
        if(inputText && inputText.length > 0) {
            
            // URL，空格 tab键 等去除
            if([cell.guanTitleLabel.text containsString:@"配置服务地址"]) {
                inputText = [inputText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }
            
            [GuanUserDefaults setObject:inputText forKey:saveKey];
        }
        
        [self guan_reloadData];
        if(self.reloadDataBlock) {
            self.reloadDataBlock();
        }
    }];
    
}



- (NSArray *)configureData {
    
    
    NSString *cardNumber = [GuanUserDefaults objectForKey:kMengGetCardNumber];
    NSDictionary *cellDict1 = @{@"guanTitleText":@"银行卡号码",@"guanRigthOn":@(YES),@"guanRightText":cardNumber ?: @"0000000000",@"guanCellId":@"MengRightLabelTableCell"};
    GuanCellModel *cellModel1 = [GuanCellModel yy_modelWithDictionary:cellDict1];
    
    NSString *realDistance = [GuanUserDefaults objectForKey:kMengGetConfigServer];
    NSDictionary *cellDict2 = @{@"guanTitleText":@"配置服务地址",@"guanRigthOn":@(YES),@"guanRightText":realDistance ?: @"https://06202023.com:10001",@"guanCellId":@"MengRightLabelTableCell"};
    GuanCellModel *cellModel2 = [GuanCellModel yy_modelWithDictionary:cellDict2];
    
    

    // guanRowData
    NSMutableArray *cellArray0 = [NSMutableArray array];
    [cellArray0 addObject:cellModel1];
    [cellArray0 addObject:cellModel2];
    
    NSDictionary *sectionDict0 = @{@"guanRowData":cellArray0,@"guanSectionTitle":@"全局配置"};
    GuanSectionModel *sectionModel0 = [GuanSectionModel yy_modelWithDictionary:sectionDict0];

    NSArray *sectionArray = @[sectionModel0];
    
    return sectionArray;
}

#pragma mark - Public Methods

- (void)guan_reloadData {
    
    self.dataArray = [self configureData];
    
}


@end
