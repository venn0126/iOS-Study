//
//  FadeTransition.m
//  Test0929
//
//  Created by 牛威 on 2019/9/30.
//  Copyright © 2019 fosafer. All rights reserved.
//

#import "FadeTransition.h"


//static NSTimeInterval transitionDuration = 0.5;
//static CGFloat startingAlpha = 0.0;

@interface FadeTransition()<UIViewControllerAnimatedTransitioning>


@end

@implementation FadeTransition{
    
    
    NSTimeInterval transitionDuration;
    CGFloat startingAlpha;
}


- (instancetype)init {
    if (self = [super init]) {
        transitionDuration = 0.5;
        startingAlpha = 0.0;
        
    }
    return self;
}

- (instancetype)initTransitionDuration:(NSTimeInterval)duration startingAlpha:(CGFloat)alpha {

    if (self = [super init]) {
        
        transitionDuration = duration;
        startingAlpha = alpha;
    }
    return self;
}


- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:@"to"];
    UIView *fromView=  [transitionContext viewForKey:@"from"];
    toView.alpha = startingAlpha;
    fromView.alpha = 0.8;
    
    toView.frame = containView.frame;
    [containView addSubview:toView];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        toView.alpha = 1.0;
        fromView.alpha = 0.8;
    } completion:^(BOOL finished) {
        fromView.alpha = 1.0;
        [transitionContext completeTransition:YES];
        
    }];
}

@end
