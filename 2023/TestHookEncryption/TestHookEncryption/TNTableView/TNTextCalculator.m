//
//  TNTextCalculator.m
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import "TNTextCalculator.h"

@implementation TNTextCalculator

+ (instancetype)sharedCalculator {
    static TNTextCalculator *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (CGSize)sizeForText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width {
    if (!text || text.length == 0) return CGSizeZero;
    
    NSAttributedString *attributedText = [[NSAttributedString alloc]
                                          initWithString:text
                                          attributes:@{NSFontAttributeName: font}];
    return [self sizeForAttributedText:attributedText maxWidth:width];
}

- (CGSize)sizeForAttributedText:(NSAttributedString *)attributedText maxWidth:(CGFloat)width {
    if (!attributedText || attributedText.length == 0) return CGSizeZero;
    
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                              context:nil];
    
    // 向上取整，避免小数点误差导致截断
    return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
}


@end
