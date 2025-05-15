//
//  TNRefreshManager.m
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import "TNRefreshTableViewMgr.h"
#import <objc/runtime.h>

// 关联对象的键
static char kPullToRefreshViewKey;
static char kInfiniteScrollingViewKey;
static char kIsObservingKey;

@interface TNPullToRefreshView : UIView

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, copy) void (^refreshingBlock)(void);
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL hasTriggeredRefresh; // 新增标记，记录是否已触发刷新


- (void)beginRefreshing;
- (void)endRefreshing;

@end

@implementation TNPullToRefreshView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置背景色
        self.backgroundColor = [UIColor clearColor];
        
        // 创建活动指示器
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        _activityIndicator.center = CGPointMake(frame.size.width / 2 - 50, frame.size.height / 2);
        _activityIndicator.hidesWhenStopped = YES;
        [self addSubview:_activityIndicator];
        
        // 创建状态标签
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.font = [UIFont systemFontOfSize:14];
        _statusLabel.textColor = [UIColor darkGrayColor];
        _statusLabel.text = @"下拉刷新";
        [self addSubview:_statusLabel];
        
        // 调整标签位置
        _statusLabel.center = CGPointMake(frame.size.width / 2 + 20, frame.size.height / 2);
    }
    return self;
}

- (void)beginRefreshing {

}

- (void)endRefreshing {

}


@end

@interface TNInfiniteScrollingView : UIView

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, copy) void (^loadingMoreBlock)(void);
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL noMoreData;

- (void)beginLoading;
- (void)endLoading;
- (void)setNoMoreData:(BOOL)noMoreData;

@end

@implementation TNInfiniteScrollingView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置背景色
        self.backgroundColor = [UIColor clearColor];
        
        // 创建活动指示器
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        _activityIndicator.center = CGPointMake(frame.size.width / 2 - 50, frame.size.height / 2);
        _activityIndicator.hidesWhenStopped = YES;
        [self addSubview:_activityIndicator];
        
        // 创建状态标签
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.font = [UIFont systemFontOfSize:14];
        _statusLabel.textColor = [UIColor darkGrayColor];
        _statusLabel.text = @"上拉加载更多";
        [self addSubview:_statusLabel];
        
        // 调整标签位置
        _statusLabel.center = CGPointMake(frame.size.width / 2 + 20, frame.size.height / 2);
    }
    return self;
}

- (void)beginLoading {
    if (_isLoading || _noMoreData) return;
    
    _isLoading = YES;
    [_activityIndicator startAnimating];
    _statusLabel.text = @"正在加载...";
    
    if (_loadingMoreBlock) {
        _loadingMoreBlock();
    }
}

- (void)endLoading {
    if (!_isLoading) return;
    
    _isLoading = NO;
    [_activityIndicator stopAnimating];
    
    if (_noMoreData) {
        _statusLabel.text = @"没有更多数据了";
    } else {
        _statusLabel.text = @"上拉加载更多";
    }
}

- (void)setNoMoreData:(BOOL)noMoreData {
    _noMoreData = noMoreData;
    
    if (noMoreData) {
        [_activityIndicator stopAnimating];
        _statusLabel.text = @"没有更多数据了";
    } else {
        _statusLabel.text = @"上拉加载更多";
    }
}


@end

// 添加一个标记字典，记录表格是否正在执行滚动动画
static NSMutableDictionary *tableViewAnimatingDict = nil;

@implementation TNRefreshTableViewMgr

+ (void)initialize {
    if (self == [TNRefreshTableViewMgr class]) {
        tableViewAnimatingDict = [NSMutableDictionary dictionary];
    }
}

// 设置表格的动画状态
+ (void)setTableView:(UITableView *)tableView isAnimating:(BOOL)animating {
    if (!tableViewAnimatingDict) {
        tableViewAnimatingDict = [NSMutableDictionary dictionary];
    }
    NSString *key = [NSString stringWithFormat:@"%p", tableView];
    tableViewAnimatingDict[key] = @(animating);
}

// 获取表格的动画状态
+ (BOOL)isTableViewAnimating:(UITableView *)tableView {
    if (!tableViewAnimatingDict) {
        return NO;
    }
    NSString *key = [NSString stringWithFormat:@"%p", tableView];
    return [tableViewAnimatingDict[key] boolValue];
}

#pragma mark - 开始/结束刷新
// 修改 beginRefreshingForTableView 方法
+ (void)beginRefreshingForTableView:(UITableView *)tableView {
    TNPullToRefreshView *refreshView = objc_getAssociatedObject(tableView, &kPullToRefreshViewKey);
    if (!refreshView || refreshView.isRefreshing) return;
    
    // 标记表格正在执行动画
    [self setTableView:tableView isAnimating:YES];
    
    // 设置刷新状态，但不执行动画
    refreshView.isRefreshing = YES;
    [refreshView.activityIndicator startAnimating];
    refreshView.statusLabel.text = @"正在刷新...";
    
    // 设置 contentInset，但不使用动画
    tableView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
    
    // 执行刷新回调
    if (refreshView.refreshingBlock) {
        refreshView.refreshingBlock();
    }
}

// 修改 endRefreshingForTableView 方法
+ (void)endRefreshingForTableView:(UITableView *)tableView {
    TNPullToRefreshView *refreshView = objc_getAssociatedObject(tableView, &kPullToRefreshViewKey);
    if (!refreshView) return;
    
    // 更新刷新视图状态
    refreshView.isRefreshing = NO;
    [refreshView.activityIndicator stopAnimating];
    refreshView.statusLabel.text = @"下拉刷新";
}

#pragma mark - 下拉刷新
+ (void)addPullToRefreshToTableView:(UITableView *)tableView refreshingBlock:(void (^)(void))refreshingBlock {
    // 移除旧的刷新视图
    TNPullToRefreshView *oldView = objc_getAssociatedObject(tableView, &kPullToRefreshViewKey);
    [oldView removeFromSuperview];
    
    // 创建新的刷新视图，初始位置在可视区域外
    TNPullToRefreshView *refreshView = [[TNPullToRefreshView alloc] initWithFrame:CGRectMake(0, -60, tableView.bounds.size.width, 60)];
    refreshView.refreshingBlock = refreshingBlock;
    [tableView addSubview:refreshView];
    
    // 关联到表格
    objc_setAssociatedObject(tableView, &kPullToRefreshViewKey, refreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 添加KVO监听
    [self setupKVOForTableView:tableView];
}

#pragma mark - 上拉加载更多
+ (void)addInfiniteScrollingToTableView:(UITableView *)tableView loadingMoreBlock:(void (^)(void))loadingMoreBlock {
    // 移除旧的加载更多视图
    TNInfiniteScrollingView *oldView = objc_getAssociatedObject(tableView, &kInfiniteScrollingViewKey);
    [oldView removeFromSuperview];
    
    // 创建新的加载更多视图
    TNInfiniteScrollingView *loadingView = [[TNInfiniteScrollingView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
    loadingView.loadingMoreBlock = loadingMoreBlock;
    
    // 添加到表格底部
    loadingView.frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, 60);
    [tableView addSubview:loadingView];
    
    // 关联到表格
    objc_setAssociatedObject(tableView, &kInfiniteScrollingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 添加KVO监听
    [self setupKVOForTableView:tableView];
}

#pragma mark - KVO设置
+ (void)setupKVOForTableView:(UITableView *)tableView {
    // 检查是否已添加观察者
    NSNumber *isObserving = objc_getAssociatedObject(tableView, &kIsObservingKey);
    if ([isObserving boolValue]) return;
    
    // 添加观察者
//    [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
//    [tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    // 更新观察者状态
    objc_setAssociatedObject(tableView, &kIsObservingKey, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)removeKVOForTableView:(UITableView *)tableView {
    // 检查是否已添加观察者
    NSNumber *isObserving = objc_getAssociatedObject(tableView, &kIsObservingKey);
    if (![isObserving boolValue]) return;
    
    // 移除观察者
    @try {
//        [tableView removeObserver:self forKeyPath:@"contentOffset"];
//        [tableView removeObserver:self forKeyPath:@"contentSize"];
    } @catch (NSException *exception) {
        // 忽略异常
    }
    
    // 更新观察者状态
    objc_setAssociatedObject(tableView, &kIsObservingKey, @NO, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - 开始/结束加载更多
+ (void)beginLoadingMoreForTableView:(UITableView *)tableView {
    TNInfiniteScrollingView *loadingView = objc_getAssociatedObject(tableView, &kInfiniteScrollingViewKey);
    if (!loadingView) return;
    
    [loadingView beginLoading];
}

+ (void)endLoadingMoreForTableView:(UITableView *)tableView {
    TNInfiniteScrollingView *loadingView = objc_getAssociatedObject(tableView, &kInfiniteScrollingViewKey);
    if (!loadingView) return;
    
    [loadingView endLoading];
}

#pragma mark - 设置/重置无更多数据状态
+ (void)setNoMoreDataForTableView:(UITableView *)tableView {
    TNInfiniteScrollingView *loadingView = objc_getAssociatedObject(tableView, &kInfiniteScrollingViewKey);
    if (!loadingView) return;
    
    [loadingView setNoMoreData:YES];
}

+ (void)resetNoMoreDataForTableView:(UITableView *)tableView {
    TNInfiniteScrollingView *loadingView = objc_getAssociatedObject(tableView, &kInfiniteScrollingViewKey);
    if (!loadingView) return;
    
    [loadingView setNoMoreData:NO];
}

#pragma mark - 更新加载更多视图位置
+ (void)updateInfiniteScrollingViewPositionWithTableView:(UITableView *)tableView {
    TNInfiniteScrollingView *loadingView = objc_getAssociatedObject(tableView, &kInfiniteScrollingViewKey);
    if (!loadingView) return;
    
    // 更新加载更多视图的位置
    CGRect frame = loadingView.frame;
    frame.origin.y = MAX(tableView.contentSize.height, tableView.bounds.size.height);
    loadingView.frame = frame;
}

#pragma mark - KVO回调
+ (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (![object isKindOfClass:[UITableView class]]) return;
    
    UITableView *tableView = (UITableView *)object;
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self handlePullToRefreshWithTableView:tableView];
        [self handleInfiniteScrollingWithTableView:tableView];
    } else if ([keyPath isEqualToString:@"contentSize"]) {
        [self updateInfiniteScrollingViewPositionWithTableView:tableView];
    }
}

#pragma mark - 处理下拉刷新
+ (void)handlePullToRefreshWithTableView:(UITableView *)tableView {
    TNPullToRefreshView *refreshView = objc_getAssociatedObject(tableView, &kPullToRefreshViewKey);
    if (!refreshView || refreshView.isRefreshing || refreshView.hasTriggeredRefresh) return;
    
    // 更新刷新视图位置，确保它跟随滚动
    CGRect frame = refreshView.frame;
    frame.origin.y = tableView.contentOffset.y;
    refreshView.frame = frame;
    
    // 更新下拉提示文本
    if (tableView.contentOffset.y < -60) {
        refreshView.statusLabel.text = @"松开立即刷新";
    } else {
        refreshView.statusLabel.text = @"下拉刷新";
    }
    
    // 下拉距离超过阈值且松开手指时触发刷新
    if (tableView.contentOffset.y < -60 && !tableView.isDragging) {
        [self beginRefreshingForTableView:tableView];
    }
}


#pragma mark - 处理上拉加载更多
+ (void)handleInfiniteScrollingWithTableView:(UITableView *)tableView {
    TNInfiniteScrollingView *loadingView = objc_getAssociatedObject(tableView, &kInfiniteScrollingViewKey);
    if (!loadingView || loadingView.isLoading || loadingView.noMoreData) return;
    
    // 当滚动到底部时触发加载更多
    CGFloat bottomOffset = tableView.contentSize.height - tableView.bounds.size.height;
    if (tableView.contentOffset.y > bottomOffset &&
        tableView.contentSize.height > tableView.bounds.size.height &&
        !tableView.isDragging) {
        [self beginLoadingMoreForTableView:tableView];
    }
}

@end
