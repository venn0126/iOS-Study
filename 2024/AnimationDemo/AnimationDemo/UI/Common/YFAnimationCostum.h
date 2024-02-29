//
//  AnimationCostum.h
//  AnimationDemo
//
//  Created by EnforLiu on 15/11/27.
//  Copyright © 2015年 EnforLiu. All rights reserved.
//


#define kRadianToDegrees(radian) (radian*180.0)/(M_PI)
#define kDegreesToRadian(x) (M_PI * (x) / 180.0)

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/CAMediaTimingFunction.h>
#import <QuartzCore/CAAnimation.h>




@interface YFAnimationCostum : NSObject

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

@end














#pragma mark - 问题解析

/** CATransition
 *
 *  @see http://www.dreamingwish.com/dream-2012/the-concept-of-coreanimation-programming-guide.html
 *  @see http://geeklu.com/2012/09/animation-in-ios/
 *
 *  CATransition 常用设置及属性注解如下:
 */


/** delegate
 *
 *  动画的代理,如果你想在动画开始和结束的时候做一些事,可以设置此属性,它会自动回调两个代理方法.
 *
 *  @see CAAnimationDelegate    (按下command键点击)
 */


/** duration
 *
 *  动画持续时间
 */


/** timingFunction
 *
 *  用于变化起点和终点之间的插值计算,形象点说它决定了动画运行的节奏,比如是均匀变化(相同时间变化量相同)还是
 *  先快后慢,先慢后快还是先慢再快再慢.
 *
 *  动画的开始与结束的快慢,有五个预置分别为(下同):
 *  kCAMediaTimingFunctionLinear            线性,即匀速
 *  kCAMediaTimingFunctionEaseIn            先慢后快
 *  kCAMediaTimingFunctionEaseOut           先快后慢
 *  kCAMediaTimingFunctionEaseInEaseOut     先慢后快再慢
 *  kCAMediaTimingFunctionDefault           实际效果是动画中间比较快.
 */

/** timingFunction
 *
 *  当上面的预置不能满足你的需求的时候,你可以使用下面的两个方法来自定义你的timingFunction
 *  具体参见下面的URL
 *
 *  @see http://developer.apple.com/library/ios/#documentation/Cocoa/Reference/CAMediaTimingFunction_class/Introduction/Introduction.html
 *
 *  + (id)functionWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y;
 *
 *  - (id)initWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y;
 */

/** fillMode
 *
 *  决定当前对象过了非active时间段的行为,比如动画开始之前,动画结束之后.
 *  预置为:
 *  kCAFillModeRemoved   默认,当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
 *  kCAFillModeForwards  当动画结束后,layer会一直保持着动画最后的状态
 *  kCAFillModeBackwards 和kCAFillModeForwards相对,具体参考上面的URL
 *  kCAFillModeBoth      kCAFillModeForwards和kCAFillModeBackwards在一起的效果
 */


/** removedOnCompletion
 *
 *  这个属性默认为YES.一般情况下,不需要设置这个属性.
 *
 *  但如果是CAAnimation动画,并且需要设置 fillMode 属性,那么需要将 removedOnCompletion 设置为NO,否则
 *  fillMode无效
 */

/** type
 *
 *  各种动画效果  其中除了'fade', `moveIn', `push' , `reveal' ,其他属于似有的API(我是这么认为的,可以点进去看下注释).
 *  ↑↑↑上面四个可以分别使用'kCATransitionFade', 'kCATransitionMoveIn', 'kCATransitionPush', 'kCATransitionReveal'来调用.
 *  @"cube"                     立方体翻滚效果
 *  @"moveIn"                   新视图移到旧视图上面
 *  @"reveal"                   显露效果(将旧视图移开,显示下面的新视图)
 *  @"fade"                     交叉淡化过渡(不支持过渡方向)             (默认为此效果)
 *  @"pageCurl"                 向上翻一页
 *  @"pageUnCurl"               向下翻一页
 *  @"suckEffect"               收缩效果，类似系统最小化窗口时的神奇效果(不支持过渡方向)
 *  @"rippleEffect"             滴水效果,(不支持过渡方向)
 *  @"oglFlip"                  上下左右翻转效果
 *  @"rotate"                   旋转效果
 *  @"push"
 *  @"cameraIrisHollowOpen"     相机镜头打开效果(不支持过渡方向)
 *  @"cameraIrisHollowClose"    相机镜头关上效果(不支持过渡方向)
 */

/** subtype
 *  
 *  动画方向
 *  kCATransitionFromRight      
 *  kCATransitionFromLeft
 *  kCATransitionFromTop
 *  kCATransitionFromBottom
 */

/**
  *  UIViewAnimation
  *
  *  @see    http://www.cocoachina.com/bbs/read.php?tid=110168
  *
  *  @brief  UIView动画应该是最简单便捷创建动画的方式了,详解请猛戳URL.
  *
  *  @method beginAnimations:context 第一个参数用来作为动画的标识,第二个参数给代理代理传递消息.至于为什么一个使用
  *                                  nil而另外一个使用NULL,是因为第一个参数是一个对象指针,而第二个参数是基本数据类型.
  *  @method setAnimationCurve:      设置动画的加速或减速的方式(速度)
  *  @method setAnimationDuration:   动画持续时间
  *  @method setAnimationTransition:forView:cache:   第一个参数定义动画类型，第二个参数是当前视图对象，第三个参数是是否使用缓冲区
  *  @method commitAnimations        动画结束
  */

/** CABasicAnimation
  *
  *  @see https://developer.apple.com/library/mac/#documentation/cocoa/conceptual/CoreAnimation_guide/Articles/KVCAdditions.html
  *
  *  @brief                      便利构造函数 animationWithKeyPath: KeyPath需要一个字符串类型的参数,实际上是一个
  *                              键-值编码协议的扩展,参数必须是CALayer的某一项属性,你的代码会对应的去改变该属性的效果
  *                              具体可以填写什么请参考上面的URL,切勿乱填!
  *                              例如这里填写的是 @"transform.rotation.z" 意思就是围绕z轴旋转,旋转的单位是弧度.
  *                              这个动画的效果是把view旋转到最小,再旋转回来.
  *                              你也可以填写@"opacity" 去修改透明度...以此类推.修改layer的属性,可以用这个类.
  *
  *  @param toValue              动画结束的值.CABasicAnimation自己只有三个属性(都很重要)(其他属性是继承来的),分别为:
  *                              fromValue(开始值), toValue(结束值), byValue(偏移值),
  !                              这三个属性最多只能同时设置两个;
  *                              他们之间的关系如下:
  *                              如果同时设置了fromValue和toValue,那么动画就会从fromValue过渡到toValue;
  *                              如果同时设置了fromValue和byValue,那么动画就会从fromValue过渡到fromValue +byValue;
  *                              如果同时设置了byValue  和toValue,那么动画就会从toValue - byValue过渡到toValue;
  *
  *                              如果只设置了fromValue,那么动画就会从fromValue过渡到当前的value;
  *                              如果只设置了toValue  ,那么动画就会从当前的value过渡到toValue;
  *                              如果只设置了byValue  ,那么动画就会从从当前的value过渡到当前value + byValue.
  *
  *                              可以这么理解,当你设置了三个中的一个或多个,系统就会根据以上规则使用插值算法计算出一个时间差
  *                              并同时开启一个Timer.Timer的间隔也就是这个时间差,通过这个Timer去不停地刷新keyPath的值.
  !                              而实际上,keyPath的值(layer的属性)在动画运行这一过程中,是没有任何变化的,它只是调用
  *                              了GPU去完成这些显示效果而已.在这个动画里,是设置了要旋转到的弧度,根据以上规则,动画将会
  *                              从它当前的弧度专旋转到我设置的度.
  *
  *  @param duration             动画持续时间
  *
  *  @param timingFunction       动画起点和终点之间的插值计算,也就是说它决定了动画运行的节奏,是快还是慢,还是先快后慢...
  */

/** CABasicAnimation
 *
 *  我们可以通过animationWithKeyPath键值对的方式来改变动画
 *  animationWithKeyPath的值：
 *  transform.scale                 比例转换
 *  transform.scale.x               横向比例转换
 *  transform.scale.y               纵向比例转换
 *  transform.rotation.z            平面圆的旋转
 *  transform.translation.x         横向移动距离
 *  transform.translation.y         纵向移动距离
 *  opacity                         透明度
 *  margin
 *  zPosition
 *  backgroundColor                 背景颜色
 *  cornerRadius                    圆角
 *  borderWidth
 *  bounds
 *  contents
 *  contentsRect
 *  cornerRadius
 *  frame
 *  hidden
 *  mask
 *  masksToBounds
 *  opacity
 *  position
 *  shadowColor
 *  shadowOffset
 *  shadowOpacity
 *  shadowRadius
 *
 */

/** CAAnimationGroup
  *
  *  @brief                      顾名思义,这是一个动画组,它允许多个动画组合在一起并行显示.比如这里设置了两个动画,
  *                              把他们加在动画组里,一起显示.例如你有几个动画,在动画执行的过程中需要同时修改动画的某些属性,
  *                              这时候就可以使用CAAnimationGroup.
  *
  *  @param duration             动画持续时间,值得一提的是,如果添加到group里的子动画不设置此属性,
  *                              group里的duration会统一设置动画(包括子动画)的duration属性;但是如果子动画设置了
  *                              duration属性,那么group的duration属性的值不应该小于每个子动画中duration属性的值,
  *                              否则会造成子动画显示不全就停止了动画.
  *
  *  @param autoreverses         动画完成后自动重新开始,默认为NO.
  *
  *  @param repeatCount          动画重复次数,默认为0.
  *
  *  @param animations           动画组(数组类型),把需要同时运行的动画加到这个数组里.
  *
  *  @note  addAnimation:forKey  这个方法的forKey参数是一个字符串,这个字符串可以随意设置.
  *
  *  @note                       如果你需要在动画group执行结束后保存动画效果的话,设置 fillMode 属性,并且把
  *                              removedOnCompletion 设置为NO;
  */


/** CATransform3D
 *
 *  
 *      CATransform3D transform3D = CATransform3DMakeRotation(angle, x, y, z);
 *
 *      该CATransform3DMakeRotation函数创建了一个转变，将在三维轴坐标系以任意弧度旋转层。
 *      x-y-z轴的有个确定的范围（介于-1 和+1之间） 。相应的坐标轴指定的值告诉系统在该轴上旋转。
 *
 *      angle是由角度值经计算转化为弧度值。要把角度值转化为弧度值，可以使用一个简单的公式Mπ/180 。
 *      例如， 45π/180 = 45 （ 3.1415 ） / 180 = 0.7853 。
 *      如果你打算在你的程序里面一直都用角度值的话，你可以写一个简单的转化方法，
 *      以帮助保持您的代码是可以理解的：
 *      #define kDegreesToRadian(x) (M_PI * (x) / 180.0)
 *
 */


/**
 *
 *  CGMutablePathRef path = CGPathCreateMutable();CGPathCreateMutable主要是为动画设置移动路径的。
 *  CGPathMoveToPoint设置移动到某点，这个方法之前的点不会建立一条直线
 *  CGPathAddQuadCurveToPoint以二次曲线的方式移动
 *  CGPathGetBoundingBox得到占用的区域的大小
 *  UIGraphicsBeginImageContext创建一个基于位图的上下文，并将其设置为上下文
 *
 *
 *  创建一个 二阶贝塞尔曲线
 *  CGMutablePathRef path = CGPathCreateMutable();
 *  CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
 !  startPoint 是起点  endPoint是终点 x,y 是x轴y轴的控制点
 *  CGPathAddQuadCurveToPoint(path, NULL, x, y, endPoint.x, endPoint.y);
 
 *  @see http://www.cnblogs.com/jay-dong/archive/2012/09/26/2704188.html
 *
 */



