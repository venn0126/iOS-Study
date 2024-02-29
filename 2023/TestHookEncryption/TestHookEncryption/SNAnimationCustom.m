//
//  SNAnimationCustom.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2024/2/29.
//

#import "SNAnimationCustom.h"

@implementation SNAnimationCustom

+ (void)animationPushLeft:(UIView *)view duration:(CFTimeInterval)duration {
    
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationPushRight:(UIView *)view duration:(CFTimeInterval)duration {
    
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [view.layer addAnimation:animation forKey:nil];
}

+ (CABasicAnimation *)animation_moveX:(float)time X:(NSNumber *)x {
    
    CABasicAnimation * animation;
    //选择横向移动动画
    animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue = x;
    animation.duration = time;
    //默认设置是yes，那意味着，在制定时间完成后  动画自动从layer上一处，
    animation.removedOnCompletion = NO;
    //动画播放次数
    animation.repeatCount = MAXFLOAT;
    //保持动画结束时状态
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = YES;
    return animation;
}


@end
