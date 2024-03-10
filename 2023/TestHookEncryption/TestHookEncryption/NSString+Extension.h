//
//  NSString+Extension.h
//  TestHookEncryption
//
//  Created by Augus on 2024/3/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

- (CGSize)gt_mulLineTextSizeForMaxWidth:(CGFloat)maxWidth font:(UIFont *)font;

- (CGSize)gt_singleLineTextSizeForMaxWidth:(CGFloat)maxWidth font:(UIFont *)font;


@end

NS_ASSUME_NONNULL_END
