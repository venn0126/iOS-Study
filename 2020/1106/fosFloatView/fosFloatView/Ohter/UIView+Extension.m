//
//  UIView+Extension.m
//  FosAttendance
//
//  Created by Wei Niu on 2018/6/28.
//  Copyright © 2018年 Fosafer. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (CGFloat)x {
    return self.frame.origin.x;
}


- (void)setX:(CGFloat)x {
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}


- (CGFloat)y {
    return self.frame.origin.y;
}


- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}


- (CGFloat)width {
    return self.frame.size.width;
}


- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}


- (CGFloat)height {
    return self.frame.size.height;
}


- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

- (CGPoint)fos_origin {
    return self.frame.origin;
}

- (void)setFos_origin:(CGPoint)fos_origin {
    CGRect rect = self.frame;
    rect.origin = fos_origin;
    self.frame = rect;
}

- (CGSize)fos_size {
    return self.frame.size;
}

- (void)setFos_size:(CGSize)fos_size {
    CGRect rect = self.frame;
    rect.size = fos_size;
    self.frame = rect;
}


- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.centerY);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.centerX, centerY);
}

- (CGFloat)fs_right {
    return self.frame.origin.x + self.frame.size.width;
}


- (void)setFs_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (CGFloat)fs_left {
    return self.frame.origin.x;
}


- (void)setFs_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (CGFloat)fs_top {
    return self.frame.origin.y;
}


- (void)setFs_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)fs_bottom {
    return self.frame.origin.y + self.frame.size.height;
}


- (void)setFs_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

#pragma mark - For Guide View

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
