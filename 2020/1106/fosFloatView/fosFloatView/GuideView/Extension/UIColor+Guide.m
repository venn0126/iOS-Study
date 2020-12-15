//
//  UIColor+Guide.m
//  fosFloatView
//
//  Created by Augus on 2020/11/18.
//

#import "UIColor+Guide.h"

@implementation UIColor (Guide)

- (UIColor *)fsDisabledColor {
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha * 0.23];
}

+ (UIColor *)fsThemeColor {
    return [UIColor colorWithRed:226.0/255.0 green:222.0/255.0 blue:133.0/255.0 alpha:1.0];
    
//    return UIColor.redColor;
}

@end
