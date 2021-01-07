//
//  UIView+Guide.m
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/4.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "UIView+Guide.h"

@implementation UIView (Guide)

- (void)drawsShadowWithColor:(UIColor *)color {
    self.layer.shadowColor = color ? color.CGColor : UIColor.blackColor.CGColor;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowRadius = 8.0;
}

- (void)animateToAlpha:(CGFloat)alpha {
    if (alpha == self.alpha) {
        return;
    }
    
    [UIView animateWithDuration:1.25 animations:^{
        self.alpha = alpha;
    }];
}

- (void)animateToCenter:(CGPoint)center {
    if (CGPointEqualToPoint(center, self.center)) {
        return;
    }
    
    [UIView animateWithDuration:1.25 delay:0.0 usingSpringWithDamping:0.46 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.center = center;
    } completion:NULL];
}

@end
