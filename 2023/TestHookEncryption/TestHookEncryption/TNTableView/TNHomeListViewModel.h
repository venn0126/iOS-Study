//
//  TNHomeListViewModel.h
//  TestHookEncryption
//
//  Created by Augus on 2025/5/8.
//

#import "TNBaseViewModel.h"
@class TNCellModel;

NS_ASSUME_NONNULL_BEGIN

@interface TNHomeListViewModel : TNBaseViewModel

@property (nonatomic, strong, readonly) NSArray<TNCellModel *> *models;

- (void)loadInitialData;
/// 下拉刷新
- (void)prependNewData;
/// 上拉加载
- (void)appendMoreData;
- (void)updateModel:(TNCellModel *)model atIndex:(NSUInteger)index;


@end

NS_ASSUME_NONNULL_END
