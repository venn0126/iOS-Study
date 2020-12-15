//
//  FOSGuideView.m
//  fosFloatView
//
//  Created by Augus on 2020/11/9.
//

#import "FOSGuideView.h"
#import "FosFloatController.h"

@interface FOSGuideView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UILabel *helloLabel;


@end

@implementation FOSGuideView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor greenColor];
                
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
        
    [self addSubview:self.helloLabel];
    [self.helloLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;
    [self.helloLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    
    
    [self addSubview:self.tableView];
    [self.tableView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:30].active = YES;
    
    [self.tableView.topAnchor constraintEqualToAnchor:self.helloLabel.bottomAnchor constant:0].active = YES;
    
    [self.tableView.widthAnchor constraintEqualToConstant:FOS_RATIO_WIDTH(150)].active = YES;
    
    [self.tableView.heightAnchor constraintEqualToConstant:FOS_SCREEN_HEIGHT * 0.5].active = YES;
}


#pragma <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"FosGuideViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellName];
    }
    
    // 对齐
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    // 分割线样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;


//    NSString *temp = [NSString stringWithFormat:@"      %@",self.dataSource[indexPath.row]];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    HKFirstViewController *vc = [[HKFirstViewController alloc] init];
    //    [self.navigationController pushViewController:vc animated:YES];
    //    NSLog(@"index---row%ld",(long)indexPath.row);
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIViewController *toVC = [FosTool fs_convertToController:@"FSZzController"];
    
    if (toVC) {
        
        toVC.title = cell.textLabel.text;
        [[FosTool fs_currentNavigationController] pushViewController:toVC animated:YES];
        
        
    } else {
        FOSLog(@"请先初始化目标控制器");
    }
    
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    // cell 背景样式
    cell.backgroundColor = RGB(45,40,88);

}



#pragma mark - Lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorInset = UIEdgeInsetsZero;
//        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.rowHeight = UITableViewAutomaticDimension;
//        _tableView.
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = RGB(45,40,88);
        // 选中动画
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;


    };
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] initWithObjects:@"我要转账",@"跨境汇款",@"我要买理财",@"我要买基金",@"我要买保险",@"我要买黄金",@"我要购汇",@"惠民贷",@"我要贷款",@"我要查房贷",@"我要充话费",@"扫码支付",@"附近的网点", nil];
    }
    return _dataSource;
}

- (UILabel *)helloLabel {
    if (!_helloLabel) {
        _helloLabel = [[UILabel alloc] init];
        _helloLabel.text = @"上午好,我是智能助理小远!\n有什么可以帮助您?\n\n您可以这样说";
        _helloLabel.numberOfLines = 0;
        _helloLabel.textColor = [UIColor whiteColor];
        _helloLabel.textAlignment = NSTextAlignmentCenter;
        [_helloLabel sizeToFit];
        _helloLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _helloLabel;
}

@end
