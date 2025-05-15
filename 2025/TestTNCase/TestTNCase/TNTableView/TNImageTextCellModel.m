//
//  TNImageTextCellModel.m
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import "TNImageTextCellModel.h"


@implementation TNImageTextCellModel {
    NSString *_cachedUniqueKey; // 添加私有实例变量存储唯一键
}

- (instancetype)init {
    if (self = [super init]) {
        self.identifier = @"TNImageTextCell";
        self.modelType = 2;
        self.imageSize = CGSizeMake(60, 60);
        self.imageSpacing = 10.0;
        self.imageOnLeft = YES;
    }
    return self;
}

- (CGFloat)calculateHeightWithContainerWidth:(CGFloat)width {
    CGFloat contentWidth = width - self.padding * 2;
    CGFloat textWidth = contentWidth;
    
    // 如果有图片，减去图片宽度和间距
    if (self.image || self.imageUrl.length > 0) {
        textWidth = contentWidth - self.imageSize.width - self.imageSpacing;
    }
    
    CGFloat textHeight = 0;
    
    // 计算标题高度
    if (self.title.length > 0) {
        CGSize titleSize = [[TNTextCalculator sharedCalculator] sizeForText:self.title
                                                                      font:self.titleFont
                                                                  maxWidth:textWidth];
        textHeight += titleSize.height + 8; // 标题下方间距
    }
    
    // 计算内容高度
    if (self.content.length > 0) {
        CGSize contentSize = [[TNTextCalculator sharedCalculator] sizeForText:self.content
                                                                        font:self.contentFont
                                                                    maxWidth:textWidth];
        textHeight += contentSize.height;
    }
    
    // 取文本高度和图片高度的最大值，再加上上下padding
    CGFloat height = MAX(textHeight, self.imageSize.height) + self.padding * 2;
    
    // 缓存高度
    self.cellHeight = height;
    return height;
}


#pragma mark - 内容比较
- (BOOL)isContentEqualToModel:(TNCellModel *)model {
    if (![super isContentEqualToModel:model]) {
        return NO;
    }
    
    TNImageTextCellModel *imageTextModel = (TNImageTextCellModel *)model;
    return CGSizeEqualToSize(self.imageSize, imageTextModel.imageSize) &&
           self.imageSpacing == imageTextModel.imageSpacing &&
           self.imageOnLeft == imageTextModel.imageOnLeft &&
           ((self.image == imageTextModel.image) || [self.imageUrl isEqualToString:imageTextModel.imageUrl]);
}

#pragma mark - 唯一标识 - 修正实现
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



@end
