//
//  MengTableView.m
//  TestHookEncryption
//
//  Created by Augus on 2023/10/11.
//

#import "MengTableView.h"
#import "MengTableViewDataSource.h"
#import "GuanTableViewDelegate.h"
#import "GuanBaseModel.h"
#import "MengRightLabelTableCell.h"
#import "GuanTableViewDelegate.h"
#import "GuanUITool.h"


@interface MengTableView ()

@property (nonatomic, strong) MengTableViewDataSource *guanDataSource;
@property (nonatomic, strong) GuanTableViewDelegate *guanDelegate;

@end

@implementation MengTableView

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
    
    [self registerClass:[MengRightLabelTableCell class] forCellReuseIdentifier:@"MengRightLabelTableCell"];

}

- (void)loadData {
        
    self.dataSource = self.guanDataSource;
    self.delegate = self.guanDelegate;
    
}


#pragma mark - Lazy Load

- (MengTableViewDataSource *)guanDataSource {
    if(!_guanDataSource) {
        _guanDataSource = [[MengTableViewDataSource alloc] initWithDataArray:nil];
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
