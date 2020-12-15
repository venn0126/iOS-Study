//
//  UIImage+HQExtension.m
//  QQPage
//
//  Created by 李海群 on 2017/7/18.
//  Copyright © 2017年 李海群. All rights reserved.
//

#import "UIImage+HQExtension.h"

@implementation UIImage (HQExtension)

+ (UIImage *) resizableImageWith:(NSString *) img
{
    UIImage *iconImage = [UIImage imageNamed:img];
    CGFloat w = iconImage.size.width;
    CGFloat h = iconImage.size.height;
    UIImage *newImage = [iconImage resizableImageWithCapInsets:UIEdgeInsetsMake(h * 0.5, w * 0.5, h * 0.5, w * 0.5) resizingMode:UIImageResizingModeStretch];
    return newImage;
}

@end
