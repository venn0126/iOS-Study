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
#import "GuanUITool.h"

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
    
    self.backgroundColor = [GuanUITool guan_red:37 green:185 blue:202];
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


#pragma mark - Lazy Load

- (GuanTableViewDataSource *)guanDataSource {
    if(!_guanDataSource) {
        _guanDataSource = [[GuanTableViewDataSource alloc] initWithDataArray:nil];
        __weak typeof(self)weakSelf = self;
        _guanDataSource.reloadDataBlock = ^{
            __strong  typeof(weakSelf)strongSelf = weakSelf;
            // 更新table view
            [strongSelf reloadData];
            
        };
    }
    return _guanDataSource;
}


- (GuanTableViewDelegate *)guanDelegate {
    if(!_guanDelegate) {
        _guanDelegate = [[GuanTableViewDelegate alloc] initWithDataArray:self.guanDataSource.dataArray];
    }
    return _guanDelegate;
}

@end
