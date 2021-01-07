//
//  I2DIYAnimationViewController.m
//  IGuide_Example
//
//  Created by whatsbug on 2019/12/18.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "I2DIYAnimationViewController.h"
#import "UIColor+I2Add.h"
#import "IGuide.h"

@interface I2DIYAnimationViewController ()<IGuideViewControllerDataSource, IGuideViewControllerDelegate>

@end

@implementation I2DIYAnimationViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [IGuideViewController showsWithDataSource:self];
}

//MARK: - IGuideViewControllerDataSource
- (NSUInteger)numberOfGuidesInGuideViewController:(NSString *)identifier {
    return 2 + 1;
}

- (IGuideItem *)guideViewController:(NSString *)identifier itemForGuideAtIndex:(NSUInteger)index {
    IGuideItem *item = IGuideItem.new;
    
    CGRect frame = CGRectZero;
    CGFloat cornerRadius = 0.0;
    if (index == 0) {
        frame = CGRectInset(self.button.frame, -8.0, -2.0);
        cornerRadius = 8.0;
    } else if (index == 1) {
        frame = self.aSwitch.frame;
        cornerRadius = CGRectGetHeight(frame) * 0.5;
    }
    
    item.highlightFrameOfAnnotated = frame;
    item.cornerRadiusOfAnnotated = cornerRadius;
    item.annotationText = @"演示自定义动画";
    item.annotationTitle = @"动画";
    item.iconImageName = @"bird";
    return item;
}

- (void)guideViewController:(NSString *)identifier animateToFrame:(CGRect)frame fromAnnotationView:(UIView<IGuideAnnotationViewProtocol> *)oldAnnotationView toAnnotationView:(UIView<IGuideAnnotationViewProtocol> *)newAnnotationView {
    // 自定义"注解"视图的出现和消失动画
    // 有两个注意点
    // 为了保证"新"视图位置大小正确，需要调用 newAnnotationView.frame = frame
    // 为了保证"旧"视图从superview中移除，需要调用 [oldAnnotationView removeFromSuperview]
    newAnnotationView.frame = frame;
    newAnnotationView.alpha = 0.0;
    [UIView animateWithDuration:2.0 animations:^{
        newAnnotationView.alpha = 1.0;
        oldAnnotationView.frame = CGRectOffset(oldAnnotationView.frame, -512, 0);
    } completion:^(BOOL finished) {
        [oldAnnotationView removeFromSuperview];
    }];
}

- (void)guideViewController:(NSString *)identifier animateToCenter:(CGPoint)center fromIndicatorView:(UIView *)oldIndicatorView toIndicatorView:(UIView *)newIndicatorView {
    // 自定义指示器视图的出现和消失动画
    // 有两个注意点
    // 为了保证"新"视图位置正确，需要调用 newIndicatorView.center = center
    // 为了保证"旧"视图从superview中移除，需要调用 [oldIndicatorView removeFromSuperview]
    newIndicatorView.alpha = 0.0;
    [UIView animateWithDuration:2.0 animations:^{
        newIndicatorView.alpha = 1.0;
        newIndicatorView.center = center;
        oldIndicatorView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [oldIndicatorView removeFromSuperview];
    }];
}

//MARK: - IGuideViewControllerDelegate
- (void)guideViewControllerDidSelectSkipTutorial:(NSString *)identifier {
    NSLog(@"下次提醒");
}

- (void)guideViewControllerDidSelectNeverRemind:(NSString *)identifier {
    NSLog(@"不再提醒");
}

@end
