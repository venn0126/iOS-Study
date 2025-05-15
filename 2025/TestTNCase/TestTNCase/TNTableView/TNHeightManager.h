//
//  TNHeightManager.h
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import <Foundation/Foundation.h>
#import "TNCellModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TNHeightCacheLevel) {
    TNHeightCacheLevelNone = 0,      // 不缓存
    TNHeightCacheLevelMemory = 1,    // 内存缓存
    TNHeightCacheLevelDisk = 2       // 磁盘缓存
};
/// 高度计算与缓存管理
@interface TNHeightManager : NSObject

// 单例
+ (instancetype)sharedManager;

// 根据模型获取高度（有缓存则取缓存，无缓存则计算并缓存）
- (CGFloat)heightForModel:(TNCellModel *)model
      withContainerWidth:(CGFloat)width;

// 异步计算高度
- (void)asyncCalculateHeightForModel:(TNCellModel *)model
                 withContainerWidth:(CGFloat)width
                         completion:(void(^)(CGFloat height))completion;

// 批量异步计算高度
- (void)asyncCalculateHeightForModels:(NSArray<TNCellModel *> *)models
                  withContainerWidth:(CGFloat)width
                          completion:(void(^)(void))completion;

// 清除指定模型的高度缓存
- (void)invalidateHeightForModel:(TNCellModel *)model;

// 清除所有高度缓存
- (void)invalidateAllHeightCache;

// 设置缓存级别
- (void)setCacheLevel:(TNHeightCacheLevel)level;


@end

NS_ASSUME_NONNULL_END
