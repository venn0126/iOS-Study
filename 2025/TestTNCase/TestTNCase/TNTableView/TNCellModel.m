//
//  TNCellModel.m
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import "TNCellModel.h"

@implementation TNCellModel{
    NSString *_cachedUniqueKey; // 添加私有实例变量
}

- (instancetype)init {
    if (self = [super init]) {
        self.cellHeight = -1; // 未计算标记
    }
    return self;
}

- (CGFloat)calculateHeightWithContainerWidth:(CGFloat)width {
    // 子类实现
    return 0;
}

- (TNCellModel *(^)(NSString *))setIdentifier {
    return ^TNCellModel *(NSString *identifier) {
        self.identifier = identifier;
        return self;
    };
}

- (TNCellModel *(^)(NSInteger))setModelType {
    return ^TNCellModel *(NSInteger modelType) {
        self.modelType = modelType;
        return self;
    };
}

- (BOOL)isContentEqualToModel:(TNCellModel *)model {
    // 默认实现，子类应该重写
    return [self.uniqueKey isEqualToString:model.uniqueKey];
}

- (NSString *)uniqueKey {
    if (!_cachedUniqueKey) {
        _cachedUniqueKey = [NSString stringWithFormat:@"%@_%ld", NSStringFromClass([self class]), (long)self.modelType];
    }
    return _cachedUniqueKey;
}

// 当属性变化时，清除缓存的唯一键
- (void)setModelType:(NSInteger)modelType {
    _modelType = modelType;
    _cachedUniqueKey = nil;
}

@end
