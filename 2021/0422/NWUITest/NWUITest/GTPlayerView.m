//
//  GTPlayerView.m
//  NWUITest
//
//  Created by Augus on 2021/5/7.
//

#import "GTPlayerView.h"
#import <AVFoundation/AVFoundation.h>

@implementation GTPlayerView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (id)initWithPlayer:(AVPlayer *)player {
    
    self = [super initWithFrame:CGRectZero];
    if (!self) {
        return nil;
    }
    
    
    self.backgroundColor = UIColor.blackColor;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    //从AVPlayer输出的视频指向AVPlayerLayer实例
    [(AVPlayerLayer *)[self layer] setPlayer:player];
    
    // 添加view
    
    
    
    return self;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *touchView = self;
    if ([self pointInside:point withEvent:event] && !self.hidden && self.userInteractionEnabled && self.alpha >= 0.01f) {
        for (UIView *subView in self.subviews) {
            CGPoint subPoint = [subView convertPoint:point fromView:self];
            UIView *subTouchView = [subView hitTest:subPoint withEvent:event];
            if (subTouchView) {
                touchView = subTouchView;
                break;
            }
            
        }
    } else {
        touchView = nil;
    }
    
    return touchView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
