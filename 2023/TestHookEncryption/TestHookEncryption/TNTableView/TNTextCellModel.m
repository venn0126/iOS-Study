//
//  TNTextCellModel.m
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import "TNTextCellModel.h"

@implementation TNTextCellModel {
    NSString *_cachedUniqueKey; // 添加私有实例变量存储唯一键
}

- (instancetype)init {
    if (self = [super init]) {
        self.identifier = @"TNTextCell";
        self.modelType = 1;
        self.padding = 15.0;
        self.titleFont = [UIFont boldSystemFontOfSize:16];
        self.contentFont = [UIFont systemFontOfSize:14];
        self.titleColor = [UIColor blackColor];
        self.contentColor = [UIColor darkGrayColor];
    }
    return self;
}

- (CGFloat)calculateHeightWithContainerWidth:(CGFloat)width {
    CGFloat contentWidth = width - self.padding * 2;
    CGFloat height = self.padding;
    
    // 使用共享文本计算器计算标题高度
    if (self.title.length > 0) {
        CGSize titleSize = [[TNTextCalculator sharedCalculator] sizeForText:self.title
                                                                      font:self.titleFont
                                                                  maxWidth:contentWidth];
        height += titleSize.height + 8; // 标题下方间距
    }
    
    // 计算内容高度
    if (self.content.length > 0) {
        CGSize contentSize = [[TNTextCalculator sharedCalculator] sizeForText:self.content
                                                                        font:self.contentFont
                                                                    maxWidth:contentWidth];
        height += contentSize.height;
    }
    
    height += self.padding;
    
    // 缓存高度
    self.cellHeight = height;
    return height;
}


#pragma mark - 内容比较
- (BOOL)isContentEqualToModel:(TNCellModel *)model {
    if (![super isContentEqualToModel:model]) {
        return NO;
    }
    
    TNTextCellModel *textModel = (TNTextCellModel *)model;
    return [self.title isEqualToString:textModel.title] &&
           [self.content isEqualToString:textModel.content] &&
           self.padding == textModel.padding &&
           [self.titleFont isEqual:textModel.titleFont] &&
           [self.contentFont isEqual:textModel.contentFont] &&
           [self.titleColor isEqual:textModel.titleColor] &&
           [self.contentColor isEqual:textModel.contentColor];
}

#pragma mark - 唯一标识
- (NSString *)uniqueKey {
    if (!_cachedUniqueKey) {
        // 使用内容的哈希作为唯一标识的一部分
        _cachedUniqueKey = [NSString stringWithFormat:@"%@_%ld_%lu",
                            NSStringFromClass([self class]),
                            (long)self.modelType,
                            (unsigned long)(self.title.hash ^ self.content.hash)];
    }
    return _cachedUniqueKey;
}

// 当属性变化时，清除缓存的唯一键
- (void)setTitle:(NSString *)title {
    _title = [title copy];
    _cachedUniqueKey = nil; // 清除缓存的唯一键
}

- (void)setContent:(NSString *)content {
    _content = [content copy];
    _cachedUniqueKey = nil; // 清除缓存的唯一键
}


@end
