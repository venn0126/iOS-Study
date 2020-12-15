//
//  FSGuideController.h
//  fosFloatView
//
//  Created by Augus on 2020/11/18.
//

#import <UIKit/UIKit.h>
#import "FSGuideItem.h"
#import "FSGuideAnnotationViewProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@protocol FSGuideViewControllerDataSource <NSObject>

@required
- (NSUInteger)numberOfGuidesInGuideViewController:(NSString *)identifier;
- (FSGuideItem *)guideViewController:(NSString *)identifier itemForGuideAtIndex:(NSUInteger)index;

@optional

/**
 如果需要自定义"注解"视图，可实现此代理方法。
 */
- (UIView<FSGuideAnnotationViewProtocol> *)guideViewController:(NSString *)identifier annotationViewForGuideAtIndex:(NSUInteger)index;

/**
 如果需要自定义指示器，可实现此代理方法。
 */
- (UIView *)guideViewController:(NSString *)identifier indicatorViewForGuideAtIndex:(NSUInteger)index;

/**
 如果需要自定义模糊背景，可实现此代理方法。
 */
- (UIVisualEffectView *)visualEffectViewInGuideViewController:(NSString *)identifier;

/**
 如果需要自定义"跳过"按钮，可实现此代理方法。
 */
- (UIButton *)skipButtonInGuideViewController:(NSString *)identifier;

/**
 如果需要自定义"不再提醒"按钮，可实现此代理方法。
 */
- (UIButton *)neverRemindButtonInGuideViewController:(NSString *)identifier;

/**
 如果需要自定义"注解"视图的动画，可实现此代理方法。
 可参考IGuideViewController类的 -animateToFrame:fromAnnotationView:toAnnotationView: 方法
 
 @param identifier  在 +showsWithDataSource:identifier: 方法中传入的控制器标识符
 @param frame   内部已经计算好的"注解"视图的frame
 @param oldAnnotationView   即将消失的"注解"视图
 @param newAnnotationView   即将显示的"注解"视图
 */
- (void)guideViewController:(NSString *)identifier
             animateToFrame:(CGRect)frame
         fromAnnotationView:(UIView<FSGuideAnnotationViewProtocol> *)oldAnnotationView
           toAnnotationView:(UIView<FSGuideAnnotationViewProtocol> *)newAnnotationView;

/**
 如果需要自定义指示器动画，可实现此代理方法。
 可参考IGuideViewController类的 -animateToCenter:fromIndicatorView:toIndicatorView: 方法
 
 @param identifier  在 +showsWithDataSource:identifier: 方法中传入的控制器标识符
 @param center   内部已经计算好的指示器的center
 @param oldIndicatorView   即将消失的指示器
 @param newIndicatorView   即将显示的指示器
 */
- (void)guideViewController:(NSString *)identifier
            animateToCenter:(CGPoint)center
          fromIndicatorView:(UIView *)oldIndicatorView
            toIndicatorView:(UIView *)newIndicatorView;

@end

#pragma mark - FSGuideViewControllerDelegate

@protocol FSGuideViewControllerDelegate <NSObject>

- (void)guideViewControllerDidSelectSkipTutorial:(NSString *)identifier;
- (void)guideViewControllerDidSelectNeverRemind:(NSString *)identifier;

@end


@interface FSGuideController : UIViewController

+ (void)showsWithDataSource:(id<FSGuideViewControllerDataSource, FSGuideViewControllerDelegate>)dataSource;
+ (void)showsWithDataSource:(id<FSGuideViewControllerDataSource, FSGuideViewControllerDelegate>)dataSource identifier:(nullable NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
