//
//  TNRefreshManager.h
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TNRefreshTableViewMgr : NSObject

// 为表格添加下拉刷新功能
+ (void)addPullToRefreshToTableView:(UITableView *)tableView
                    refreshingBlock:(void(^)(void))refreshingBlock;

// 为表格添加上拉加载更多功能
+ (void)addInfiniteScrollingToTableView:(UITableView *)tableView
                       loadingMoreBlock:(void(^)(void))loadingMoreBlock;

// 开始下拉刷新动画
+ (void)beginRefreshingForTableView:(UITableView *)tableView;

// 结束下拉刷新动画
+ (void)endRefreshingForTableView:(UITableView *)tableView;

// 开始上拉加载更多动画
+ (void)beginLoadingMoreForTableView:(UITableView *)tableView;

// 结束上拉加载更多动画
+ (void)endLoadingMoreForTableView:(UITableView *)tableView;

// 设置没有更多数据状态
+ (void)setNoMoreDataForTableView:(UITableView *)tableView;

// 重置上拉加载更多状态
+ (void)resetNoMoreDataForTableView:(UITableView *)tableView;

// 移除KVO观察者
+ (void)removeKVOForTableView:(UITableView *)tableView;

+ (BOOL)isTableViewAnimating:(UITableView *)tableView;

+ (void)setTableView:(UITableView *)tableView isAnimating:(BOOL)animating;





@end

NS_ASSUME_NONNULL_END
