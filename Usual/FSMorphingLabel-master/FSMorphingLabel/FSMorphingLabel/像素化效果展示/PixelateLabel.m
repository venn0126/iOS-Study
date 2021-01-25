//
//  PixelateLabel.m
//  FSMorphingLabel
//
//  Created by 翁志方 on 2017/12/20.
//  Copyright © 2017年 wzf. All rights reserved.
//

#import "PixelateLabel.h"

@implementation PixelateLabel

- (void)drawRect:(CGRect)rect {

    float scale = MIN([UIScreen mainScreen].scale, self.progress);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, scale);
    rect.origin = CGPointZero;
    
    [self.text drawInRect:rect withAttributes:@{NSFontAttributeName: self.font,
                                          NSForegroundColorAttributeName: [self.textColor colorWithAlphaComponent:1]
                                          }];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [newImage drawInRect:rect];
}


@end
