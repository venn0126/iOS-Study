//
//  TNCellModel.h
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import <Foundation/Foundation.h>
#import "TNTextCalculator.h"

NS_ASSUME_NONNULL_BEGIN
/// 基础 cell 模型
@interface TNCellModel : NSObject

@property (nonatomic, assign) CGFloat cellHeight;     // 缓存的 cell 高度
@property (nonatomic, copy) NSString *identifier;     // cell 复用标识符
@property (nonatomic, assign) NSInteger modelType;    // 模型类型，用于区分不同 cell
@property (nonatomic, strong) NSString *uniqueKey;    // 用于缓存的唯一标识符

/// 计算并缓存高度的核心方法
- (CGFloat)calculateHeightWithContainerWidth:(CGFloat)width;

/// 链式调用支持
- (TNCellModel *(^)(NSString *))setIdentifier;
- (TNCellModel *(^)(NSInteger))setModelType;

/// 内容比较方法（用于差异更新）
- (BOOL)isContentEqualToModel:(TNCellModel *)model;


@end

NS_ASSUME_NONNULL_END
