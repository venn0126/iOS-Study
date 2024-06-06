//
//  DiamondView.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2024/6/6.
//

#import "DiamondView.h"

@implementation DiamondView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    
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
