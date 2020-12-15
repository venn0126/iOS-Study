//
//  UIImage+Extension.m
//  fosFloatView
//
//  Created by Augus on 2020/11/11.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)resizableImageWith:(NSString *)img {
    
    UIImage *iconImage = [UIImage imageNamed:img];
    CGFloat w = iconImage.size.width;
    CGFloat h = iconImage.size.height;
    UIImage *newImage = [iconImage resizableImageWithCapInsets:UIEdgeInsetsMake(h * 0.5, w * 0.5, h * 0.5, w * 0.5) resizingMode:UIImageResizingModeStretch];
    return newImage;
}

@end
