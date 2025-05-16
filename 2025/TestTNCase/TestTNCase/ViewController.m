//
//  ViewController.m
//  TestTNCase
//
//  Created by Augus Venn on 2025/5/15.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) TNHomeAPIMgr *homeAPIMgr;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) TNHomeListViewModel *viewModel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.greenColor;
    
    [self testHomeAPI];
    
    MengsDelay(3, ^{
       
        [self loadHomeData];
        
    });
    
}

#pragma mark - TestHomeAPI
- (void)testHomeAPI {
    
    [self setupAPIManager];
    
}

- (void)setupAPIManager {
    // 创建API管理器
    self.homeAPIMgr = [[TNHomeAPIMgr alloc] init];
    
    // 配置缓存策略
    self.homeAPIMgr.cachePolicy = TNAPIManagerCachePolicyMemory | TNAPIManagerCachePolicyDisk;
    self.homeAPIMgr.memoryCacheSecond = 60; // 1分钟内存缓存
    self.homeAPIMgr.diskCacheSecond = 300;  // 5分钟磁盘缓存
    
    // 配置重试策略
    self.homeAPIMgr.retryPolicy = TNAPIManagerRetryPolicyOnNetworkError | TNAPIManagerRetryPolicyOnTimeout;
    self.homeAPIMgr.maxRetryCount = 2;
    self.homeAPIMgr.retryInterval = 1.0;
}

- (void)loadHomeData {

    // 发起请求
    [self.homeAPIMgr loadData];
}




#pragma mark - TestTableVie
- (void)testTNTableView {
    
    self.viewModel = [[TNHomeListViewModel alloc] init];
    __weak typeof(self) weakSelf = self;
    self.viewModel.onDataChanged = ^{
        [weakSelf.tableView tn_reloadDataWithModels:weakSelf.viewModel.models preCalculateHeight:YES];
    };
    
    
    // 设置表格视图
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.estimatedRowHeight = 100; // 设置预估高度提高性能
    [self.view addSubview:self.tableView];
    
    // 注册cell
    [self.tableView tn_registerClass:[TNTextCell class] forCellWithIdentifier:@"TNTextCell"];
    [self.tableView tn_registerClass:[TNImageTextCell class] forCellWithIdentifier:@"TNImageTextCell"];
    
    [self.viewModel loadInitialData];
    
}

// 下拉刷新
- (void)pullToRefresh {
    [self.viewModel prependNewData];
}

// 上拉加载更多
- (void)loadMore {
    [self.viewModel appendMoreData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableView.tn_models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TNCellModel *model = self.tableView.tn_models[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.identifier];
    
    if ([cell isKindOfClass:[TNTextCell class]] && [model isKindOfClass:[TNTextCellModel class]]) {
        [(TNTextCell *)cell configureWithModel:(TNTextCellModel *)model];
    } else if ([cell isKindOfClass:[TNImageTextCell class]] && [model isKindOfClass:[TNImageTextCellModel class]]) {
        [(TNImageTextCell *)cell configureWithModel:(TNImageTextCellModel *)model];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TNCellModel *model = self.tableView.tn_models[indexPath.row];
    return model.cellHeight > 0 ? model.cellHeight : UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 示例：更新选中的cell
    TNCellModel *model = self.tableView.tn_models[indexPath.row];
    
    if ([model isKindOfClass:[TNTextCellModel class]]) {
        TNTextCellModel *textModel = (TNTextCellModel *)model;
        [textModel setContent:[NSString stringWithFormat:@"内容已更新: %@", [NSDate date]]];
        [tableView tn_updateModel:textModel atIndexPath:indexPath animated:YES];
    }
}

@end
