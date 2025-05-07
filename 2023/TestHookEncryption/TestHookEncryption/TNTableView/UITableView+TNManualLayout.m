//
//  UITableView+TNManualLayout.m
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import "UITableView+TNManualLayout.h"
#import <objc/runtime.h>
#import "TNHeightManager.h"
#import "TNRefreshTableViewMgr.h"


@implementation UITableView (TNManualLayout)

#pragma mark - 关联属性
- (void)setTn_models:(NSArray<TNCellModel *> *)tn_models {
    objc_setAssociatedObject(self, @selector(tn_models), tn_models, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray<TNCellModel *> *)tn_models {
    return objc_getAssociatedObject(self, @selector(tn_models));
}

#pragma mark - 公共方法
- (void)tn_registerClass:(Class)cellClass forCellWithIdentifier:(NSString *)identifier {
    [self registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (void)tn_reloadDataWithModels:(NSArray<TNCellModel *> *)models preCalculateHeight:(BOOL)preCalculate {
    self.tn_models = [models copy];
    
    if (preCalculate) {
        // 预计算高度
        [[TNHeightManager sharedManager] asyncCalculateHeightForModels:models
                                                   withContainerWidth:CGRectGetWidth(self.frame)
                                                           completion:^{
            // 在主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadData];
            });
        }];
    } else {
        [self reloadData];
    }
}

- (void)tn_updateModel:(TNCellModel *)model atIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    if (indexPath.section >= self.tn_models.count) return;
    
    NSMutableArray *sectionModels = [self.tn_models mutableCopy];
    if ([sectionModels[indexPath.section] isKindOfClass:[NSArray class]]) {
        // 多section情况
        NSMutableArray *rowModels = [sectionModels[indexPath.section] mutableCopy];
        if (indexPath.row < rowModels.count) {
            rowModels[indexPath.row] = model;
            sectionModels[indexPath.section] = rowModels;
            self.tn_models = sectionModels;
        }
    } else {
        // 单section情况
        if (indexPath.row < sectionModels.count) {
            sectionModels[indexPath.row] = model;
            self.tn_models = sectionModels;
        }
    }
    
    // 失效高度缓存
    [[TNHeightManager sharedManager] invalidateHeightForModel:model];
    
    // 异步计算新高度
    [[TNHeightManager sharedManager] asyncCalculateHeightForModel:model
                                              withContainerWidth:CGRectGetWidth(self.frame)
                                                      completion:^(CGFloat height) {
        // 刷新对应行
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animated ? UITableViewRowAnimationAutomatic : UITableViewRowAnimationNone];
    }];
}

- (void)tn_updateModels:(NSArray<TNCellModel *> *)models atIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animated:(BOOL)animated {
    if (models.count != indexPaths.count) return;
    
    // 更新模型
    for (NSInteger i = 0; i < models.count; i++) {
        TNCellModel *model = models[i];
        NSIndexPath *indexPath = indexPaths[i];
        
        if (indexPath.section >= self.tn_models.count) continue;
        
        NSMutableArray *sectionModels = [self.tn_models mutableCopy];
        if ([sectionModels[indexPath.section] isKindOfClass:[NSArray class]]) {
            // 多section情况
            NSMutableArray *rowModels = [sectionModels[indexPath.section] mutableCopy];
            if (indexPath.row < rowModels.count) {
                rowModels[indexPath.row] = model;
                sectionModels[indexPath.section] = rowModels;
            }
        } else {
            // 单section情况
            if (indexPath.row < sectionModels.count) {
                sectionModels[indexPath.row] = model;
            }
        }
        
        self.tn_models = sectionModels;
        
        // 失效高度缓存
        [[TNHeightManager sharedManager] invalidateHeightForModel:model];
    }
    
    // 批量异步计算新高度
    [[TNHeightManager sharedManager] asyncCalculateHeightForModels:models
                                               withContainerWidth:CGRectGetWidth(self.frame)
                                                       completion:^{
        // 刷新对应行
        [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:animated ? UITableViewRowAnimationAutomatic : UITableViewRowAnimationNone];
    }];
}

- (void)tn_setEstimatedRowHeight:(CGFloat)height {
    self.estimatedRowHeight = height;
}


#pragma mark - 刷新和加载更多
- (void)tn_addPullToRefreshWithBlock:(void (^)(void))refreshBlock {
    // 包装刷新回调，确保只执行一次
    __block BOOL isExecuting = NO;
    
    [TNRefreshTableViewMgr addPullToRefreshToTableView:self refreshingBlock:^{
        if (isExecuting) return;
        
        isExecuting = YES;
        
        // 执行用户的刷新回调
        if (refreshBlock) {
            refreshBlock();
        }
        
        // 延迟重置执行标记
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            isExecuting = NO;
        });
    }];
}

- (void)tn_addInfiniteScrollingWithBlock:(void (^)(void))loadMoreBlock {
    [TNRefreshTableViewMgr addInfiniteScrollingToTableView:self loadingMoreBlock:loadMoreBlock];
}

- (void)tn_beginRefreshing {
    [TNRefreshTableViewMgr beginRefreshingForTableView:self];
}

- (void)tn_endRefreshing {
    [TNRefreshTableViewMgr endRefreshingForTableView:self];
}

- (void)tn_beginLoadingMore {
    [TNRefreshTableViewMgr beginLoadingMoreForTableView:self];
}

- (void)tn_endLoadingMore {
    [TNRefreshTableViewMgr endLoadingMoreForTableView:self];
}

- (void)tn_setNoMoreData {
    [TNRefreshTableViewMgr setNoMoreDataForTableView:self];
}

- (void)tn_resetNoMoreData {
    [TNRefreshTableViewMgr resetNoMoreDataForTableView:self];
}

#pragma mark - 数据操作
- (void)tn_appendModels:(NSArray<TNCellModel *> *)models {
    if (!models || models.count == 0) return;
    
    NSMutableArray *allModels = [NSMutableArray arrayWithArray:self.tn_models];
    [allModels addObjectsFromArray:models];
    
    // 异步计算新添加模型的高度
    [[TNHeightManager sharedManager] asyncCalculateHeightForModels:models
                                               withContainerWidth:CGRectGetWidth(self.frame)
                                                       completion:^{
        // 更新数据源
        self.tn_models = allModels;
        
        // 计算插入的indexPaths
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (NSInteger i = allModels.count - models.count; i < allModels.count; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        // 插入行
        [self beginUpdates];
        [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self endUpdates];
    }];
}


- (void)tn_prependModels:(NSArray<TNCellModel *> *)models {
    if (!models || models.count == 0) {
        // 如果没有新数据，只结束刷新状态
        [TNRefreshTableViewMgr endRefreshingForTableView:self];
        
        // 执行一次滚动到顶部的动画
        [self tn_scrollToTopWithAnimation];
        return;
    }
    
    // 获取当前数据
    NSMutableArray *allModels = nil;
    
    // 处理多section情况
    if (self.tn_models.count > 0 && [self.tn_models[0] isKindOfClass:[NSArray class]]) {
        // 多section情况
        allModels = [NSMutableArray arrayWithArray:self.tn_models];
        NSMutableArray *firstSectionModels = [NSMutableArray arrayWithArray:models];
        [firstSectionModels addObjectsFromArray:allModels.firstObject];
        [allModels replaceObjectAtIndex:0 withObject:firstSectionModels];
    } else {
        // 单section情况
        allModels = [NSMutableArray arrayWithArray:models];
        [allModels addObjectsFromArray:self.tn_models ?: @[]];
    }
    
    // 异步计算新添加模型的高度
    [[TNHeightManager sharedManager] asyncCalculateHeightForModels:models
                                               withContainerWidth:CGRectGetWidth(self.frame)
                                                       completion:^{
        // 更新数据源
        self.tn_models = allModels;
        
        // 计算插入的indexPaths
        NSMutableArray *indexPaths = [NSMutableArray array];
        
        if ([allModels[0] isKindOfClass:[NSArray class]]) {
            // 多section情况
            for (NSInteger i = 0; i < models.count; i++) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
        } else {
            // 单section情况
            for (NSInteger i = 0; i < models.count; i++) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
        }
        
        // 插入行
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            // 结束刷新状态
            [TNRefreshTableViewMgr endRefreshingForTableView:self];
            // 执行一次滚动到顶部的动画
            [self tn_scrollToTopWithAnimation];
                
        }];
        
        [self beginUpdates];
        [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self endUpdates];
        
        [CATransaction commit];
    }];
}

// 添加一个统一的滚动到顶部的方法
- (void)tn_scrollToTopWithAnimation {
    // 检查是否正在执行动画
    if ([TNRefreshTableViewMgr isTableViewAnimating:self]) {
        return;
    }
    
    // 标记为正在执行动画
    [TNRefreshTableViewMgr setTableView:self isAnimating:YES];
    
    // 使用 CATransaction 确保动画完成后重置标记
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        // 动画完成后重置标记
        [TNRefreshTableViewMgr setTableView:self isAnimating:NO];
    }];
    
    // 获取表格视图的调整后内边距（考虑导航栏等）
    UIEdgeInsets adjustedInsets = UIEdgeInsetsZero;
    
    // iOS 11及以上使用 adjustedContentInset
    if (@available(iOS 11.0, *)) {
        adjustedInsets = self.adjustedContentInset;
        adjustedInsets.top = 0; // 清除顶部调整，我们只需要保留系统的安全区域调整
    }
    
    // 先重置 contentInset 为系统默认值（通常是导航栏高度等）
    [UIView animateWithDuration:0.2 animations:^{
        self.contentInset = adjustedInsets;
    } completion:^(BOOL finished) {
        // 然后滚动到顶部
        [UIView animateWithDuration:0.2 animations:^{
            [self setContentOffset:CGPointMake(0, -adjustedInsets.top) animated:NO];
        }];
    }];
    
    [CATransaction commit];
}

@end
