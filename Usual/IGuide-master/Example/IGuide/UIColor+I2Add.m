//
//  UIColor+I2Add.m
//  IGuide_Example
//
//  Created by whatsbug on 2019/12/17.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "UIColor+I2Add.h"

@implementation UIColor (I2Add)

+ (UIColor *)randomColor {
    CGFloat red = (arc4random() % 255 / 255.0);
    CGFloat green = (arc4random() % 255 / 255.0);
    CGFloat blue = (arc4random() % 255 / 255.0);
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
