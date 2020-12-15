//
//  NSString+Extension.h
//  fosFloatView
//
//  Created by Augus on 2020/11/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

/**
 返回文本高度

 @param font 字体及大小
 @param maxSize 最大宽度
 @return CGSize
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end

NS_ASSUME_NONNULL_END
