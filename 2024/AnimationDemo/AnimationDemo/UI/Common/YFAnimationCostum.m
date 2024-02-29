//
//  AnimationCostum.m
//  AnimationDemo
//
//  Created by EnforLiu on 15/11/27.
//  Copyright © 2015年 EnforLiu. All rights reserved.
//

#import "YFAnimationCostum.h"



@implementation YFAnimationCostum

#pragma mark - 永久的闪烁动画

/**
 *  永久的闪烁动画
 *
 *  @param time 闪烁的时间周期
 *
 *  @return [layer addAnimation: forKey:nil];
 */
+ (CABasicAnimation *)animation_opacityForever:(float)time {
    //选择动画效果 透明度
    CABasicAnimation * animation;
    animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    //fromValue 就是透明度
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    //当autoreverses为 YES 时,在它到达目的地之后,动画的返回到开始的值,代替了直接跳转到开始的值
    animation.autoreverses = YES;
    //动画时间
    animation.duration = time;
    //repeatCount
    //默认的是 0,意味着动画只会播放一次。如果指定一个无限大的重复次数,使用 1e100f。
    //这个不应该和 repeatDration 属性一块使用。
    animation.repeatCount = MAXFLOAT;
    //这个属性默认为 YES,那意味着,在指定的时间段完成后,动画就自动的从层上移除了。这个一般不用。
    animation.removedOnCompletion = NO;
    //解释在.h中
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return animation;
}

#pragma mark - 横向移动

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

#pragma mark - 纵向移动

+ (CABasicAnimation *)animation_moveY:(float)time Y:(NSNumber *)y {
    
    CABasicAnimation * animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.toValue = y;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = YES;

    return animation;
}

#pragma mark - 缩放

+ (CABasicAnimation *)animation_scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time {
    
    CABasicAnimation * animation;
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = Multiple;
    animation.toValue = orginMultiple;
    animation.duration = time;
    //动画结束返回到开始大小
    animation.autoreverses = YES;
    //动画次数
    animation.repeatCount = MAXFLOAT;
    //动画结束时不移除动画
    animation.removedOnCompletion = NO;
    //动画后保持结束时状态
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

#pragma mark - 组合动画

+ (CAAnimationGroup *)animation_groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes {
    CAAnimationGroup * animation = [CAAnimationGroup animation];
    animation.animations = animationAry;
    animation.duration = time;
    animation.repeatCount = repeatTimes;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}

#pragma mark - 路径动画

+ (CAKeyframeAnimation *)animation_keyframeAnimation:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes {
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    animation.removedOnCompletion = NO;
    animation.duration = time;
    animation.repeatCount = repeatTimes;
    animation.autoreverses = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fillMode = kCAFillModeForwards;
    animation.calculationMode = kCAAnimationCubicPaced;
    return animation;
}

#pragma mark - 旋转动画

+ (CABasicAnimation *)animation_rotation:(float)time CATransform3D:(CATransform3D)transform3D repeatCount:(int)repeatCount {
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.removedOnCompletion = NO;
    animation.repeatCount = repeatCount;
    animation.duration = time;
    animation.autoreverses = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    animation.toValue = [NSValue valueWithCATransform3D:transform3D];
    animation.cumulative = NO;
    
    return animation;
}

#pragma mark - 旋转动画

+ (CABasicAnimation *)animation_JitterFromCATransform3D:(CATransform3D)from To:(CATransform3D)to {
    CABasicAnimation*animation =[CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration =0.1;
    animation.repeatCount = MAXFLOAT;
    animation.autoreverses =YES;
    animation.fromValue =[NSValue valueWithCATransform3D:from];
    animation.toValue =[NSValue valueWithCATransform3D:to];
    return animation;
}

#pragma mark - 向上翻页

+ (void)animationCurlUp:(UIView *)view {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:view cache:NO];
    [UIView commitAnimations];
}

#pragma mark - 向下翻页

+ (void)animationCurlDown:(UIView *)view {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.7f];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:view cache:NO];
    [UIView commitAnimations];
}
#pragma mark - 向左翻页

+ (void)animationCurlLeft:(UIView *)view {
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = @"pageUnCurl";
    animation.subtype = kCATransitionFromLeft;
    [view.layer addAnimation:animation forKey:nil];
}

#pragma mark - 向右翻页

+ (void)animationCurlRight:(UIView *)view {
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = @"pageCurl";
    animation.subtype = kCATransitionFromLeft;
    [view.layer addAnimation:animation forKey:nil];
}


#pragma mark - 向右翻转

+ (void)animationFlipUp:(UIView *)view {
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = @"oglFlip";
    animation.subtype = kCATransitionFromTop;
    [view.layer addAnimation:animation forKey:nil];
}
#pragma mark - 向下翻转

+ (void)animationFlipDown:(UIView *)view {
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = @"oglFlip";
    animation.subtype = kCATransitionFromBottom;
    [view.layer addAnimation:animation forKey:nil];
}

#pragma mark - 向右翻转

+ (void)animationFlipRight:(UIView *)view {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:NO];
    [UIView commitAnimations];
}

#pragma mark - 向左翻转

+ (void)animationFlipLeft:(UIView *)view {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:view cache:NO];
    [UIView commitAnimations];
}


#pragma mark - Push

+ (void)animationPushUp:(UIView *)view duration:(CFTimeInterval)duration {
    
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationPushDown:(UIView *)view duration:(CFTimeInterval)duration {
    
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [view.layer addAnimation:animation forKey:nil];
}

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

#pragma mark - Present

+ (void)animationMoveUp:(UIView *)view duration:(CFTimeInterval)duration {
    
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromTop;
     [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationMoveDown:(UIView *)view duration:(CFTimeInterval)duration {

    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromBottom;
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationMoveLeft:(UIView *)view duration:(CFTimeInterval)duration {
    
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromLeft;
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationMoveRight:(UIView *)view duration:(CFTimeInterval)duration {
    
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromRight;
    [view.layer addAnimation:animation forKey:nil];
}

#pragma mark - 立方体

+ (void)animationCubeUp:(UIView *)view duration:(CFTimeInterval)duration {
    
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = @"cube";
    animation.subtype = kCATransitionFromTop;
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCubeDown:(UIView *)view duration:(CFTimeInterval)duration {
   
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = @"cube";
    animation.subtype = kCATransitionFromBottom;
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCubeLeft:(UIView *)view duration:(CFTimeInterval)duration {
   
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = @"cube";
    animation.subtype = kCATransitionFromRight;
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCubeRight:(UIView *)view duration:(CFTimeInterval)duration {
 
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = @"cube";
    animation.subtype = kCATransitionFromLeft;
    [view.layer addAnimation:animation forKey:nil];
}

#pragma mark - 吸收

+ (void)animationSuckEffect:(UIView *)view duration:(CFTimeInterval)duration {
    
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = @"suckEffect";
    [view.layer addAnimation:animation forKey:nil];
}

#pragma mark - 波纹

+ (void)animationRippleEffect:(UIView *)view duration:(CFTimeInterval)duration {
   
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = @"rippleEffect";
    [view.layer addAnimation:animation forKey:nil];
}

#pragma mark - 镜头开

+ (void)animationCameraOpen:(UIView *)view duration:(CFTimeInterval)duration {

    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = @"cameraIrisHollowOpen";
    [view.layer addAnimation:animation forKey:nil];
}

#pragma mark - 镜头关

+ (void)animationCameraClose:(UIView *)view duration:(CFTimeInterval)duration {
    
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = @"cameraIrisHollowClose";
    [view.layer addAnimation:animation forKey:nil];
}

#pragma mark - 覆盖

+ (void)animationRevealUp:(UIView *)view duration:(CFTimeInterval)duration {

    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromTop;
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRevealDown:(UIView *)view duration:(CFTimeInterval)duration {
    
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromBottom;
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRevealLeft:(UIView *)view duration:(CFTimeInterval)duration {
    
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromLeft;
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRevealRight:(UIView *)view duration:(CFTimeInterval)duration {
    
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromRight;
    [view.layer addAnimation:animation forKey:nil];
}

#pragma mark - 淡入

+ (void)animationFade:(UIView *)view duration:(CFTimeInterval)duration {
    
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionFade;
    [view.layer addAnimation:animation forKey:nil];
}


@end
