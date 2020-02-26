//
//  FOSButton.m
//  JRTT
//
//  Created by Augus on 2020/2/14.
//  Copyright © 2020 fosafer. All rights reserved.
//

#import "FOSButton.h"

@interface FOSButton()
{
    
    CAShapeLayer *_shape;
    id _target;
    SEL _action;
    
}

@end

@implementation FOSButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:CGRectGetMidX(self.bounds) startAngle:M_PI endAngle:0 clockwise:YES];
        // 确定两条直线，并与半圆弧的两边零界点相连
        
        CGPoint bottomPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds));
        CGPoint endPoint = CGPointMake(CGRectGetMinX(self.bounds),CGRectGetMidY(self.bounds));
        [path addLineToPoint:bottomPoint];
        [path addLineToPoint:endPoint];
        
        // 封装成layer
        _shape = [CAShapeLayer layer];
        [_shape setStrokeColor:[UIColor redColor].CGColor];
        [_shape setFillColor:[UIColor yellowColor].CGColor];
        _shape.path = path.CGPath;
        [self.layer addSublayer:_shape];
        
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    CGPoint point = [[touches anyObject] locationInView:self]; // touch point
    point = [self.layer convertPoint:point toLayer:_shape]; // point to layer
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:_shape.path];//  得到画图部分的path
    // 判断是否为画图中的点，确定是否响应事件
    if ([path containsPoint:point]) {
        if ([_target respondsToSelector:_action]) {
            [_target performSelectorOnMainThread:_action withObject:nil waitUntilDone:NO];
        }
    }
}

- (void)fos_addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    
    _target = target;
    _action = action;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
