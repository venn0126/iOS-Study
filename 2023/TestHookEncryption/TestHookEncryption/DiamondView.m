//
//  DiamondView.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2024/6/6.
//

#import "DiamondView.h"


@interface DiamondView ()

@property(nonatomic, strong) UIColor *fillColor;

@end

@implementation DiamondView


- (instancetype)initWithFrame:(CGRect)frame fillColor:(UIColor *)fillColor {
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    _fillColor = fillColor;
    self.backgroundColor = UIColor.clearColor;
    return  self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *lastColor = nil;
    if(_fillColor) {
        lastColor = _fillColor;
    } else {
        lastColor = UIColor.redColor;
    }
    CGContextSetFillColorWithColor(context, lastColor.CGColor);
    
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    CGPoint top = CGPointMake(center.x, center.y - rect.size.height / 2);
    CGPoint right = CGPointMake(center.x + rect.size.width / 2, center.y);
    CGPoint bottom = CGPointMake(center.x, center.y + rect.size.height / 2);
    CGPoint left = CGPointMake(center.x - rect.size.width / 2, center.y);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, top.x, top.y);
    CGContextAddLineToPoint(context, right.x, right.y);
    CGContextAddLineToPoint(context, bottom.x, bottom.y);
    CGContextAddLineToPoint(context, left.x, left.y);
    CGContextClosePath(context);
    
    CGContextFillPath(context);
}

@end
