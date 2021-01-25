//
//  TianButton.m
//  TestDictNil
//
//  Created by Augus on 2021/1/10.
//

#import "TianButton.h"

@implementation TianButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    UIView *touchView = nil;
    BOOL isInside = [self pointInside:point withEvent:event];
    if (isInside && self.alpha >= 0.01 && self.userInteractionEnabled && !self.hidden) {
        
        for (UIView *subview in self.subviews) {
            
            CGPoint subPoint = [subview convertPoint:point fromView:self];
            UIView *subTouchView = [subview hitTest:subPoint withEvent:event];
            if (subTouchView) {
                touchView = subTouchView;
                break;
            }
            
        }
    }else {
        touchView = nil;
    }
    return touchView;
}

@end
