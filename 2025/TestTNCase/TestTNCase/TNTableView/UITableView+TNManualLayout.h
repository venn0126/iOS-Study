//
//  UITableView+TNManualLayout.h
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import <UIKit/UIKit.h>
#import "TNCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (TNManualLayout)

/// 关联的数据模型数组
@property (nonatomic, strong) NSArray<TNCellModel *> *tn_models;

/// 注册高度计算器
- (void)tn_registerClass:(Class)cellClass forCellWithIdentifier:(NSString *)identifier;

/// 使用模型数组刷新表格（支持预计算）
- (void)tn_reloadDataWithModels:(NSArray<TNCellModel *> *)models
              preCalculateHeight:(BOOL)preCalculate;

/// 更新单个模型并刷新对应行
- (void)tn_updateModel:(TNCellModel *)model atIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

/// 批量更新模型并刷新对应行
- (void)tn_updateModels:(NSArray<TNCellModel *> *)models
           atIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
              animated:(BOOL)animated;

/// 设置预估高度（提高首次渲染速度）
- (void)tn_setEstimatedRowHeight:(CGFloat)height;

/// 添加下拉刷新
- (void)tn_addPullToRefreshWithBlock:(void(^)(void))refreshBlock;

/// 添加上拉加载更多
- (void)tn_addInfiniteScrollingWithBlock:(void(^)(void))loadMoreBlock;

/// 开始下拉刷新
- (void)tn_beginRefreshing;

/// 结束下拉刷新
- (void)tn_endRefreshing;

/// 开始上拉加载更多
- (void)tn_beginLoadingMore;

/// 结束上拉加载更多
- (void)tn_endLoadingMore;

/// 设置没有更多数据
- (void)tn_setNoMoreData;

/// 重置没有更多数据状态
- (void)tn_resetNoMoreData;

/// 添加新数据到现有数据的末尾
- (void)tn_appendModels:(NSArray<TNCellModel *> *)models;

/// 添加新数据到现有数据的开头
- (void)tn_prependModels:(NSArray<TNCellModel *> *)models;


@end

NS_ASSUME_NONNULL_END
