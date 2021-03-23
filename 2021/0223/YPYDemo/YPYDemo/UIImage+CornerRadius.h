//
//  UIImage+CornerRadius.h
//  YPYDemo
//
//  Created by Augus on 2021/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CornerRadius)

- (UIImage *)nw_imageAddRadius:(CGFloat)radius withSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
