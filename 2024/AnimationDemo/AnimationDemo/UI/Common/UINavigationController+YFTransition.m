//
//  UINavigationController+YFTransition.m
//  AnimationDemo
//
//  Created by EnforLiu on 15/11/30.
//  Copyright © 2015年 EnforLiu. All rights reserved.
//



#import "UINavigationController+YFTransition.h"

@implementation UINavigationController (YFTransition)


- (void)pushViewController:(UIViewController *)viewController withAnimated:(YFPushAnimation)animated {

    if (animated == YFPushAnimationDefine) {    //默认 不需要做任何处理
        [self pushViewController:viewController animated:YES];
    }
    else if (animated == YFPushAnimationFlip||animated == YFPushAnimationCurl) {
        //系统动画
        [UIView beginAnimations:nil context:NULL];
        [self pushViewController:viewController animated:NO];
        [UIView setAnimationDuration:ANIMATION_TIME];
        [UIView setAnimationBeginsFromCurrentState:YES];
       
        if (animated == YFPushAnimationFlip) {  //翻转
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        }else { //立方体
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
        }
        [UIView commitAnimations];
        
    }
    else {
        //私密动画
        CATransition *animation = [CATransition animation];
        animation.duration = ANIMATION_TIME;
        animation.fillMode = kCAFillModeForwards;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        if (animated == YFPushAnimationCube) {
            animation.type = CUBE;
        }else if (animated == YFPushAnimationSuckEffect) {
            animation.type = SUCK_EFFECT;
        }else if (animated == YFPushAnimationRippleEffect) {
            animation.type = RIPPLE_EFFECT;
        }else if (animated == YFPushAnimationCameraIris) {
            animation.type = CAMERA_IRIS_OPEN;
        }else if (animated == YFPushAnimationReveal) {
            animation.type =kCATransitionReveal;
        }else if (animated == YFPushAnimationFade) {
            animation.type = kCATransitionFade;
        }else if (animated == YFPushAnimationCurlTWo) {
            animation.type = PAGE_CURL;
        }
        if (animated == YFPushAnimationCurlTWo) {
            animation.subtype = kCATransitionFromLeft;
        }else {
            animation.subtype = kCATransitionFromRight;
        }
        [self.view.layer addAnimation:animation forKey:nil];
        [self pushViewController:viewController animated:NO];
    }


}

- (UIViewController *)popViewControllerWithAnimated:(YFPushAnimation)animated {
    UIViewController *controller;
    
    if (animated == YFPushAnimationDefine) {
        controller = [self popViewControllerAnimated:YES];
    }
    else {
        controller = [self popViewControllerAnimated:NO];
        
        if (animated == YFPushAnimationFlip||animated == YFPushAnimationCurl) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:ANIMATION_TIME];
            [UIView setAnimationBeginsFromCurrentState:YES];
            if (animated == YFPushAnimationFlip) {
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
            }else {
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
            }
            [UIView commitAnimations];
        }
   
        else {
            CATransition *animation = [CATransition animation];
            animation.duration = ANIMATION_TIME;
            animation.fillMode = kCAFillModeForwards;
            if (animated == YFPushAnimationCube) {
                animation.type = CUBE;
            }else if (animated == YFPushAnimationSuckEffect) {
                animation.type = SUCK_EFFECT;
            }else if (animated == YFPushAnimationRippleEffect) {
                animation.type = RIPPLE_EFFECT;
            }else if (animated == YFPushAnimationCameraIris) {
                animation.type = CAMERA_IRIS_CLOSE;
            }else if (animated == YFPushAnimationReveal) {
                animation.type = kCATransitionReveal;
            }else if (animated == YFPushAnimationFade) {
                animation.type = kCATransitionFade;
            }else if (animated == YFPushAnimationCurlTWo) {
                animation.type = PAGE_UN_CURL;
            }
            animation.subtype = kCATransitionFromLeft;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            [self.view.layer addAnimation:animation forKey:nil];
        }
    }
    return controller;

}
@end
