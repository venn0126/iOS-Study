//
//  OneView.m
//  NWUITest
//
//  Created by Augus on 2021/5/13.
//

#import "OneView.h"

@implementation OneView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//
//    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));
//    UIView *temp = nil;
//    if (self.alpha >= 0.01 && self.hidden == NO && self.userInteractionEnabled == YES && self.clipsToBounds == NO) {
//        for (UIView *sub in self.subviews) {
//            CGPoint subPoint = [sub convertPoint:point fromView:self];
//            UIView *touchView = [sub hitTest:subPoint withEvent:event];
//            if (touchView) {
//                temp = touchView;
//                break;
//            }
//
//        }
//
//
//    } else {
//        temp = nil;
//    }
//
//
//
//    return temp;
//}


/// find the best fit view to responder event
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));

    UIView *temp = nil;
    if (self.hidden == NO && self.alpha >= 0.01f && self.userInteractionEnabled == YES && self.clipsToBounds == YES && [self pointInside:point withEvent:event]) {
        
        for (UIView *sub in self.subviews) {
            CGPoint subPoint = [sub convertPoint:point fromView:self];
            UIView *touchView = [sub hitTest:subPoint withEvent:event];
            if (touchView) {
                temp = touchView;
                break;
            }
        }
    } else {
        temp = nil;
    }
    
    return temp;
}

@end
