//
//  NWButton.m
//  YPYDemo
//
//  Created by Augus on 2021/3/5.
//

#import "NWButton.h"

@implementation NWButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 判断是否是当当前类 隐藏 alpha 是否可以交互
    if (!self.hidden && self.alpha >= 0.01 && self.userInteractionEnabled == YES) {
        // 进行点的转化以及处理
        // dian
        CGFloat padding = 50.f;
        CGPoint point0 = [self convertPoint:point toView:self];
        CGPoint tmpPoint = CGPointMake(point0.x + padding, point0.y + padding);
       BOOL isPoint = [self pointInside:tmpPoint withEvent:event];
//        // 扩大响应点的范围
//        // 进行当前范围的一个计算
//        if (CGRectContainsPoint(self.bounds, tmpPoint)) {
//            return self;
//        }
        
        if (isPoint) {
            return self;
        }
    }
    return nil;
}

@end
