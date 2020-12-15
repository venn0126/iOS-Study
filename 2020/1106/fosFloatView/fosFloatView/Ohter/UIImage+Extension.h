//
//  UIImage+Extension.h
//  fosFloatView
//
//  Created by Augus on 2020/11/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

/**
 传入图片返回可拉伸图片
 */
+ (UIImage *)resizableImageWith:(NSString *)img;

@end

NS_ASSUME_NONNULL_END
