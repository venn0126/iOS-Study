//
//  IGuideButton.m
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/18.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "IGuideButton.h"

@implementation IGuideButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

///MARK: - Privacy
- (void)commonInit {
    self.safeInsets = UIEdgeInsetsZero;
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    [self addGestureRecognizer:panGestureRecognizer];
}

///MARK: - UIPanGestureRecognizer Callback
- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(panGestureRecognized:)]) {
        [self.delegate panGestureRecognized:recognizer];
    }

    CGPoint translation = [recognizer translationInView:self.superview];
    [recognizer setTranslation:CGPointZero inView:self.superview];
    
    CGPoint newCenter = CGPointMake(self.center.x + translation.x, self.center.y + translation.y);
    self.center = newCenter;
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat superviewWidth = CGRectGetWidth(self.superview.bounds);
        CGFloat superviewHeight = CGRectGetHeight(self.superview.bounds);
        CGFloat selfWidth = CGRectGetWidth(self.bounds);
        CGFloat selfHeight = CGRectGetHeight(self.bounds);
        
        CGFloat centerX = ({
            CGFloat minCenterX = selfWidth * 0.5 + self.safeInsets.left;
            CGFloat maxCenterX = superviewWidth - selfWidth * 0.5 - self.safeInsets.right;
            CGFloat centerX = self.center.x < superviewWidth * 0.5 ? minCenterX : maxCenterX;
            centerX;
        });
        CGFloat centerY = ({
            CGFloat minCenterY = selfHeight * 0.5 + self.safeInsets.top;
            CGFloat maxCenterY = superviewHeight - selfHeight * 0.5 - self.safeInsets.bottom;
            CGFloat centerY = fminf(fmaxf(self.center.y, minCenterY), maxCenterY);
            centerY;
        });
        CGPoint center = CGPointMake(centerX, centerY);
        
        // do animation
        [UIView animateWithDuration:0.25 animations:^{
            self.center = center;
        }];
    }
}

@end
