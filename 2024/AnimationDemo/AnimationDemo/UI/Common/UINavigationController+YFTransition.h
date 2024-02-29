//
//  UINavigationController+YFTransition.h
//  AnimationDemo
//
//  Created by EnforLiu on 15/11/30.
//  Copyright © 2015年 EnforLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ANIMATION_TIME 0.8

#define CUBE                @"cube"
#define SUCK_EFFECT         @"suckEffect"
#define RIPPLE_EFFECT       @"rippleEffect"
#define PAGE_CURL           @"pageCurl"
#define PAGE_UN_CURL        @"pageUnCurl"
#define CAMERA_IRIS_OPEN    @"cameraIrisHollowOpen"
#define CAMERA_IRIS_CLOSE   @"cameraIrisHollowClose"



typedef NS_ENUM(NSInteger, YFPushAnimation) {
    YFPushAnimationDefine,          //默认
    YFPushAnimationCurl,            //翻页
    YFPushAnimationCurlTWo,         //翻页二
    YFPushAnimationFlip,            //翻转
    YFPushAnimationCube,            //立方体
    YFPushAnimationSuckEffect,      //吸收
    YFPushAnimationRippleEffect,    //波纹
    YFPushAnimationCameraIris,      //镜头
    YFPushAnimationReveal,          //覆盖
    YFPushAnimationFade,            //淡入
};
@interface UINavigationController (YFTransition)

/**
 *  push方法
 *
 *  @param viewController 视图控制器
 *  @param animated       动画类型
 */
- (void)pushViewController:(nullable UIViewController *)viewController withAnimated:(YFPushAnimation)animated;

/**
 *  pop方法
 *
 *  @param animated 动画类型
 *
 *  @return 视图控制器
 */
- (nullable UIViewController *)popViewControllerWithAnimated:(YFPushAnimation)animated;

@end
