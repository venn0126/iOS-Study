//
//  TNTextCalculator.h
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 文本计算工具
@interface TNTextCalculator : NSObject

+ (instancetype)sharedCalculator;

// 计算文本尺寸
- (CGSize)sizeForText:(NSString *)text
                 font:(UIFont *)font
             maxWidth:(CGFloat)width;

// 计算属性文本尺寸
- (CGSize)sizeForAttributedText:(NSAttributedString *)attributedText
                       maxWidth:(CGFloat)width;


@end

NS_ASSUME_NONNULL_END
