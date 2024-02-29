# AnimationDemo

# YFAnimationCostum.h

```

/**
*  永久的闪烁动画
*
*  @param time 闪烁的时间周期
*
*  @return [layer addAnimation: forKey:];
*/
+ (CABasicAnimation *)animation_opacityForever:(float)time;

/**
*  横向移动动画
*
*  @param time 移动的时间周期
*  @param x    横移距离
*
*  @return [layer addAnimation: forKey:];
*/
+ (CABasicAnimation *)animation_moveX:(float)time X:(NSNumber *)x;

/**
*  纵向移动动画
*
*  @param time 移动的时间周期
*  @param y    纵移距离
*
*  @return [layer addAnimation: forKey:];
*/
+ (CABasicAnimation *)animation_moveY:(float)time Y:(NSNumber *)y;

/**
*  缩放
*
*  @param Multiple      动画前大小比例
*  @param orginMultiple 动画后大小比例
*  @param time          动画时间周期
*
*  @return [layer addAnimation: forKey:];
*/
+ (CABasicAnimation *)animation_scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time;

/**
*  组合动画
*
*  @param animationAry 组合动画数组
*  @param time         动画时间周期
*  @param repeatTimes  动画运行次数
*
*  @return animation
*/
+ (CAAnimationGroup *)animation_groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes;

/**
*  路径动画
*  @param path             移动控制点
*  @param time             动画时间
*  @param repeatTimes      动画次数
*/
+ (CAKeyframeAnimation *)animation_keyframeAnimation:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes;

/**
*  旋转动画
*  @param time         时间
*  @param transform3D  CATransform3DMakeRotation
*  @param  repeatCount 动画次数
*/
+ (CABasicAnimation *)animation_rotation:(float)time CATransform3D:(CATransform3D)transform3D repeatCount:(int)repeatCount;

/*
*  抖动动画
*  @param  from    CATransform3DRotate
*  @param  to      CATransform3DRotate
*/
+ (CABasicAnimation *)animation_JitterFromCATransform3D:(CATransform3D)from To:(CATransform3D)to;




/**
*  向上翻页动画
*  @param view  要执行动画的view
*/
+ (void)animationCurlUp:(UIView *)view;

/**
*  向下翻页动画
*  @param view  要执行动画的view
*/
+ (void)animationCurlDown:(UIView *)view;

/**
*  向左翻页动画
*  @param view  要执行动画的view
*/

+ (void)animationCurlLeft:(UIView *)view;
/**
*  向右翻页动画
*  @param view  要执行动画的view
*/
+ (void)animationCurlRight:(UIView *)view;

/**
*  向上翻转动画
*  @param view  要执行动画的view
*/
+ (void)animationFlipUp:(UIView *)view;

/**
*  向下翻转动画
*  @param view  要执行动画的view
*/
+ (void)animationFlipDown:(UIView *)view;

/**
*  向左翻转动画
*  @param view  要执行动画的view
*/
+ (void)animationFlipLeft:(UIView *)view;

/**
*  向右翻转动画
*  @param view  要执行动画的view
*/
+ (void)animationFlipRight:(UIView *)view;

/**
*  向上Push
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationPushUp:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  向下Push
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationPushDown:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  向左Push
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationPushLeft:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  向右Push
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationPushRight:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  向上Present
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationMoveUp:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  向下Present
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationMoveDown:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  向左Present
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationMoveLeft:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  向右Present
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationMoveRight:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  立方体向上
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationCubeUp:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  立方体向下
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationCubeDown:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  立方体向左
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationCubeLeft:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  立方体向右
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationCubeRight:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  吸收 
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationSuckEffect:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  波纹
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationRippleEffect:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  镜头开
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationCameraOpen:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  镜头关
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationCameraClose:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  覆盖向上
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationRevealUp:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  覆盖向下
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationRevealDown:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  覆盖向左
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationRevealLeft:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  覆盖向右
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationRevealRight:(UIView *)view duration:(CFTimeInterval)duration;

/**
*  淡入
*  @param view  要执行动画的view
*  @param duration  动画时间
*/
+ (void)animationFade:(UIView *)view duration:(CFTimeInterval)duration;


```
# UINavigationController+YFTransition.h

```
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

```