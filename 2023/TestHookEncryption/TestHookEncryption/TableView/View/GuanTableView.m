//
//  GuanTableView.m
//  TestHookEncryption
//
//  Created by Augus on 2023/8/14.
//

#import "GuanTableView.h"
#import "GuanTableViewDataSource.h"
#import "GuanTableViewDelegate.h"
#import "GuanBaseModel.h"
#import "GuanRightLabelTableCell.h"
#import "GuanRightSwitcherTableCell.h"
#import "GuanTableViewDelegate.h"

@interface GuanTableView ()

@property (nonatomic, strong) GuanTableViewDataSource *guanDataSource;
@property (nonatomic, strong) GuanTableViewDelegate *guanDelegate;



@end

@implementation GuanTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if(!self) return nil;
    
    
    [self initSettings];
    [self registerCellClass];
    [self loadData];
    
    return self;
}


- (void)initSettings {
    
    self.backgroundColor = UIColor.whiteColor;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


- (void)registerCellClass {
    
    [self registerClass:[GuanRightLabelTableCell class] forCellReuseIdentifier:@"GuanRightLabelTableCell"];
    [self registerClass:[GuanRightSwitcherTableCell class] forCellReuseIdentifier:@"GuanRightSwitcherTableCell"];

}

- (void)loadData {
        
    self.dataSource = self.guanDataSource;
    self.delegate = self.guanDelegate;
    
}


- (NSArray *)configureData {
    
    NSDictionary *cellDict0 = @{@"guanTitleText":@"实时订单开关",@"guanRigthOn":@(NO),@"guanRightText":@0,@"guanCellId":@"GuanRightSwitcherTableCell"};
    GuanCellModel *cellModel0 = [GuanCellModel yy_modelWithDictionary:cellDict0];
    
    NSDictionary *cellDict2 = @{@"guanTitleText":@"  请输入实时订单约束距离",@"guanRigthOn":@(NO),@"guanRightText":@20,@"guanCellId":@"GuanRightLabelTableCell"};
    GuanCellModel *cellModel2 = [GuanCellModel yy_modelWithDictionary:cellDict2];

    NSDictionary *cellDict1 = @{@"guanTitleText":@"预约订单开关",@"guanRigthOn":@(YES),@"guanRightText":@0,@"guanCellId":@"GuanRightSwitcherTableCell"};
    GuanCellModel *cellModel1 = [GuanCellModel yy_modelWithDictionary:cellDict1];

    NSDictionary *cellDict3 = @{@"guanTitleText":@"  请输入预约订单约束距离",@"guanRigthOn":@(NO),@"guanRightText":@30,@"guanCellId":@"GuanRightLabelTableCell"};
    GuanCellModel *cellModel3 = [GuanCellModel yy_modelWithDictionary:cellDict3];

    // guanRowData
    NSArray *cellArray0 = @[cellModel0,cellModel2];
    NSArray *cellArray1 = @[cellModel1,cellModel3];

    
    NSDictionary *sectionDict0 = @{@"guanRowData":cellArray0,@"guanSectionTitle":@"实时订单"};
    GuanSectionModel *sectionModel0 = [GuanSectionModel yy_modelWithDictionary:sectionDict0];
    NSDictionary *sectionDict1 = @{@"guanRowData":cellArray1,@"guanSectionTitle":@"预约订单"};
    GuanSectionModel *sectionModel1 = [GuanSectionModel yy_modelWithDictionary:sectionDict1];

    NSArray *sectionArray = @[sectionModel0, sectionModel1];
    
    return sectionArray;
}


#pragma mark - Lazy Load

- (GuanTableViewDataSource *)guanDataSource {
    if(!_guanDataSource) {
        _guanDataSource = [[GuanTableViewDataSource alloc] initWithDataArray:[self configureData]];
    }
    return _guanDataSource;
}


- (GuanTableViewDelegate *)guanDelegate {
    if(!_guanDelegate) {
        _guanDelegate = [[GuanTableViewDelegate alloc] initWithDataArray:[self configureData]];
    }
    return _guanDelegate;
}

@end
