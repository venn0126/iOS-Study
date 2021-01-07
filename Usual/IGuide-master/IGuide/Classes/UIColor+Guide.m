//
//  UIColor+Guide.m
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/4.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "UIColor+Guide.h"

@implementation UIColor (Guide)

- (UIColor *)igDisabledColor {
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha * 0.23];
}

+ (UIColor *)igThemeColor {
    return [UIColor colorWithRed:226.0/255.0 green:222.0/255.0 blue:133.0/255.0 alpha:1.0];
}

@end
