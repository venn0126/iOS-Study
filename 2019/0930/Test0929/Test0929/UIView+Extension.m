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

@end
