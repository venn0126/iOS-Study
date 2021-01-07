//
//  IGuideViewController.m
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/1.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "IGuideViewController.h"
#import "IGuideAppleAnnotationView.h"
#import "IGuideIndicatorLineView.h"
#import "IGuideButton.h"
#import "UIView+Guide.h"
#import "UIColor+Guide.h"
#import "NSNumber+Guide.h"

@interface IGuideViewController ()
@property(nonatomic, weak) id<IGuideViewControllerDataSource, IGuideViewControllerDelegate> dataSource;
@property(nonatomic, strong) NSString *identifier;
@property(nonatomic, assign) NSInteger currentIndex;
@property(nonatomic, strong) CAShapeLayer *maskLayer;
@property(nonatomic, strong) UIVisualEffectView *visualEffectView;
@property(nonatomic, strong) UIButton *skipButton;
@property(nonatomic, strong) UIButton *neverRemindButton;
@property(nonatomic, strong) UIWindow *window;
@end

@implementation IGuideViewController

//MARK: - Life cycle
- (void)dealloc {
    self.window = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.visualEffectView];
    [self.view addSubview:self.skipButton];
    [self.view addSubview:self.neverRemindButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showGuideAtIndex:self.currentIndex];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.visualEffectView.frame = self.view.bounds;
    
    CGFloat skipW0dot5 = CGRectGetWidth(self.skipButton.frame) * 0.5;
    CGFloat skipCenterX = CGRectGetWidth(self.view.bounds) - skipW0dot5 - 20;
    CGFloat skipCenterY = CGRectGetHeight(self.view.bounds) * 0.1;
    CGPoint skipCenter = CGPointMake(skipCenterX, skipCenterY);
    
    if (CGPointEqualToPoint(CGPointZero, self.skipButton.frame.origin)) {
        self.skipButton.center = skipCenter;
    } else {
        [self.skipButton animateToCenter:skipCenter];
    }
    
    CGFloat neverCenterX = skipCenterX;
    CGFloat neverCenterY = CGRectGetHeight(self.view.bounds) - skipCenterY;
    CGPoint neverCenter = CGPointMake(neverCenterX, neverCenterY);
    [self.neverRemindButton animateToCenter:neverCenter];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        // 屏幕方向变化时
        [self showGuideAtIndex:self.currentIndex];
    }];
}

//MARK: - Private
- (void)showGuideAtIndex:(NSUInteger)index {
    NSUInteger count = [self.dataSource numberOfGuidesInGuideViewController:self.identifier];
    NSUInteger lastIndex = count - 1;
    if (index > lastIndex) {
        return;
    }
    
    IGuideItem *item = [self.dataSource guideViewController:self.identifier itemForGuideAtIndex:index];
    if (index == lastIndex) {
        item.highlightFrameOfAnnotated = self.neverRemindButton.frame;
        item.cornerRadiusOfAnnotated = self.neverRemindButton.layer.cornerRadius;
        item.annotatedView = nil;
        [self.view.layer setMask:nil];
        [self.neverRemindButton animateToAlpha:1.0];
    } else {
        [self.view.layer setMask:self.maskLayer];
        [self.neverRemindButton animateToAlpha:0.0];
    }
    
    CGRect highlightFrameOfAnnotated = item.highlightFrameOfAnnotated;
    if (item.annotatedView) {
        highlightFrameOfAnnotated = [item.annotatedView.superview convertRect:highlightFrameOfAnnotated toView:self.view];
    }
    UIBezierPath *toPath = ({
        UIBezierPath *highlightPath = [UIBezierPath bezierPathWithRoundedRect:highlightFrameOfAnnotated cornerRadius:item.cornerRadiusOfAnnotated];
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
        [bezierPath appendPath:highlightPath];
        bezierPath;
    });
    CGPathRef fromPath = self.maskLayer.path;
    self.maskLayer.path = toPath.CGPath;
    if (fromPath) {
        [self runAnimationFromPath:fromPath toPath:toPath.CGPath];
    }
    
    // annotationView
    UIView<IGuideAnnotationViewProtocol> *oldAnnotationView = [self.view viewWithTag:NSNumber.tagOfAnnotationView];
    UIView<IGuideAnnotationViewProtocol> *annotationView = nil;
    if ([self.dataSource respondsToSelector:@selector(guideViewController:annotationViewForGuideAtIndex:)]) {
        annotationView = [self.dataSource guideViewController:self.identifier annotationViewForGuideAtIndex:index];
    }
    if (!annotationView) {
        annotationView = IGuideAppleAnnotationView.new;
    }
    annotationView.model = item;
    annotationView.frame = oldAnnotationView.frame;
    annotationView.tag = NSNumber.tagOfAnnotationView;
    [annotationView.nextButton_protocol addTarget:self action:@selector(onNextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    if ([annotationView respondsToSelector:@selector(previousButton_protocol)]) {
        [annotationView.previousButton_protocol addTarget:self action:@selector(onPreviousButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        annotationView.previousButton_protocol.enabled = (index != 0);
    }
    BOOL hasUserCustomizedShadowOfAnnotationView = (annotationView.layer.shadowOpacity != 0);
    if (!hasUserCustomizedShadowOfAnnotationView) {
        [annotationView drawsShadowWithColor:item.shadowColor];
    }
    [self.view insertSubview:annotationView aboveSubview:self.visualEffectView];
    
    CGSize annotationSize = ({
        annotationView.translatesAutoresizingMaskIntoConstraints = NO;
        CGSize size = [annotationView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        annotationView.translatesAutoresizingMaskIntoConstraints = YES;
        size;
    });
    CGFloat annotationW = annotationSize.width;
    CGFloat annotationH = annotationSize.height;
    CGFloat maxWidth = CGRectGetWidth(self.view.bounds) * 0.8;
    if (annotationW > maxWidth) {
        annotationW = maxWidth;
        annotationH = ({
            annotationView.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *wConstraint = [annotationView.widthAnchor constraintEqualToConstant:annotationW];
            wConstraint.active = YES;
            CGSize size = [annotationView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            wConstraint.active = NO;
            annotationView.translatesAutoresizingMaskIntoConstraints = YES;
            size.height;
        });
    }
    CGFloat percentage = CGRectGetMidX(highlightFrameOfAnnotated) / CGRectGetWidth(self.view.bounds);
    CGFloat annotationX = CGRectGetMidX(highlightFrameOfAnnotated) - annotationW * percentage;
    BOOL isAnnotatedCenterYGreaterThanMidY = CGRectGetMidY(highlightFrameOfAnnotated) > CGRectGetMidY(self.view.bounds);
    CGFloat annotationY = ({
        CGFloat valueY = 0.0;
        if (isAnnotatedCenterYGreaterThanMidY) {
            valueY = (CGRectGetMinY(highlightFrameOfAnnotated) - item.spacingBetweenAnnotationAndAnnotated) - annotationH;
        } else {
            valueY = (CGRectGetMaxY(highlightFrameOfAnnotated) + item.spacingBetweenAnnotationAndAnnotated);
        }
        valueY;
    });
    CGRect annotationFrame = CGRectMake(annotationX, annotationY, annotationW, annotationH);
    
    BOOL isOpening = (index == 0) && !oldAnnotationView; // 是否开场（开场比喻教程的开始）
    
    if (isOpening) {
        annotationView.frame = annotationFrame;
    } else {
        if ([self.dataSource respondsToSelector:@selector(guideViewController:animateToFrame:fromAnnotationView:toAnnotationView:)]) {
            [self.dataSource guideViewController:self.identifier
                                  animateToFrame:annotationFrame
                              fromAnnotationView:oldAnnotationView
                                toAnnotationView:annotationView];
        } else {
            [self animateToFrame:annotationFrame
              fromAnnotationView:oldAnnotationView
                toAnnotationView:annotationView];
        }
    }
        
    // indicatorView
    UIView *oldIndicatorView = [self.view viewWithTag:NSNumber.tagOfIndicator];
    UIView *indicatorView = nil;
    if ([self.dataSource respondsToSelector:@selector(guideViewController:indicatorViewForGuideAtIndex:)]) {
        indicatorView = [self.dataSource guideViewController:self.identifier indicatorViewForGuideAtIndex:index];
    }
    if (!indicatorView) {
        indicatorView = IGuideIndicatorLineView.new;
    }
    indicatorView.center = oldIndicatorView.center;
    indicatorView.tag = NSNumber.tagOfIndicator;
    indicatorView.transform = CGAffineTransformMakeScale(1.0, isAnnotatedCenterYGreaterThanMidY ? -1.0 : 1.0);
    BOOL hasUserCustomizedShadowOfIndicatorView = (indicatorView.layer.shadowOpacity != 0);
    if (!hasUserCustomizedShadowOfIndicatorView) {
        [indicatorView drawsShadowWithColor:item.shadowColor];
    }
    [self.view insertSubview:indicatorView aboveSubview:annotationView];
    
    CGFloat indicatorH = CGRectGetHeight(indicatorView.frame);
    CGFloat indicatorCenterX = CGRectGetMidX(highlightFrameOfAnnotated) + item.offsetOfIndicator.x;
    CGFloat indicatorCenterY = ({
        CGFloat centerY = 0.0;
        if (isAnnotatedCenterYGreaterThanMidY) {
            centerY = CGRectGetMaxY(annotationFrame) + indicatorH * 0.5 + item.offsetOfIndicator.y;
        } else {
            centerY = CGRectGetMinY(annotationFrame) - indicatorH * 0.5 - item.offsetOfIndicator.y;
        }
        centerY;
    });
    CGPoint indicatorCenter = CGPointMake(indicatorCenterX, indicatorCenterY);
    
    if (isOpening) {
        indicatorView.center = indicatorCenter;
    } else {
        if ([self.dataSource respondsToSelector:@selector(guideViewController:animateToCenter:fromIndicatorView:toIndicatorView:)]) {
            [self.dataSource guideViewController:self.identifier
                                 animateToCenter:indicatorCenter
                               fromIndicatorView:oldIndicatorView
                                 toIndicatorView:indicatorView];
        } else {
            [self animateToCenter:indicatorCenter
                fromIndicatorView:oldIndicatorView
                  toIndicatorView:indicatorView];
        }
    }
    
    // 执行开场动画
    if (isOpening) {
        [self runOpeningAnimation];
    }
}

- (void)runAnimationFromPath:(CGPathRef)fromPath toPath:(CGPathRef)toPath {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = 0.25;
    animation.fromValue = (__bridge id _Nullable)(fromPath);
    animation.toValue = (__bridge id _Nullable)(toPath);
    [self.maskLayer addAnimation:animation forKey:nil];
}

- (void)runEndingAnimationWithCompletion:(void (^ __nullable)(void))completion {
    UIView *indicatorView = [self.view viewWithTag:NSNumber.tagOfIndicator];
    UIView *annotationView = [self.view viewWithTag:NSNumber.tagOfAnnotationView];
    [UIView animateWithDuration:0.25 animations:^{
        indicatorView.alpha = 0.0;
        annotationView.alpha = 0.0;
        self.skipButton.alpha = 0.0;
        self.neverRemindButton.alpha = 0.0;
    }];
    
    // 逐渐清晰动画
    [UIView animateWithDuration:1.0 animations:^{
        self.visualEffectView.effect = nil;
    } completion:^(BOOL finished) {
        !completion ?: completion();
    }];
}

- (void)runOpeningAnimation {
    UIView *indicatorView = [self.view viewWithTag:NSNumber.tagOfIndicator];
    UIView *annotationView = [self.view viewWithTag:NSNumber.tagOfAnnotationView];
    indicatorView.alpha = 0.0;
    annotationView.alpha = 0.0;
    [UIView animateWithDuration:0.25 animations:^{
        indicatorView.alpha = 1.0;
        annotationView.alpha = 1.0;
        self.skipButton.alpha = 1.0;
    }];
    
    // 逐渐模糊动画
    UIVisualEffect *effect = self.visualEffectView.effect;
    self.visualEffectView.effect = nil;
    self.visualEffectView.hidden = NO;
    [UIView animateWithDuration:1.0 animations:^{
        self.visualEffectView.effect = effect;
    }];
}

- (void)animateToFrame:(CGRect)frame
    fromAnnotationView:(UIView<IGuideAnnotationViewProtocol> *)oldAnnotationView
      toAnnotationView:(UIView<IGuideAnnotationViewProtocol> *)newAnnotationView {
    newAnnotationView.textLabel_protocol.alpha = 0.0;
    [UIView animateWithDuration:1.25 delay:0.0 usingSpringWithDamping:0.46 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        newAnnotationView.textLabel_protocol.alpha = 1.0;
        oldAnnotationView.alpha = 0.0;
        oldAnnotationView.frame = frame;
        newAnnotationView.frame = frame;
    } completion:^(BOOL finished) {
        [oldAnnotationView removeFromSuperview];
    }];
}

- (void)animateToCenter:(CGPoint)center
      fromIndicatorView:(UIView *)oldIndicatorView
        toIndicatorView:(UIView *)newIndicatorView {
    [UIView animateWithDuration:1.25 delay:0.0 usingSpringWithDamping:0.46 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        oldIndicatorView.alpha = 0.0;
        oldIndicatorView.center = center;
        newIndicatorView.center = center;
    } completion:^(BOOL finished) {
        [oldIndicatorView removeFromSuperview];
    }];
}

//MARK: - Public
+ (void)showsWithDataSource:(id<IGuideViewControllerDataSource,IGuideViewControllerDelegate>)dataSource {
    [IGuideViewController showsWithDataSource:dataSource identifier:nil];
}

+ (void)showsWithDataSource:(id<IGuideViewControllerDataSource,IGuideViewControllerDelegate>)dataSource identifier:(NSString *)identifier {
    [IGuideViewController.new showsWithDataSource:dataSource identifier:identifier];
}

- (void)showsWithDataSource:(id<IGuideViewControllerDataSource,IGuideViewControllerDelegate>)dataSource identifier:(NSString *)identifier {
    self.dataSource = dataSource;
    self.identifier = identifier;
    self.window.rootViewController = self;
    self.window.hidden = NO;
}

//MARK: - Getter & Setter
- (void)setDataSource:(id<IGuideViewControllerDataSource,IGuideViewControllerDelegate>)dataSource {
    _dataSource = dataSource;
    
    if ([dataSource respondsToSelector:@selector(visualEffectViewInGuideViewController:)]) {
        self.visualEffectView = [dataSource visualEffectViewInGuideViewController:self.identifier];
    }
    self.visualEffectView.hidden = YES;
    
    if ([dataSource respondsToSelector:@selector(skipButtonInGuideViewController:)]) {
        self.skipButton = [dataSource skipButtonInGuideViewController:self.identifier];
        self.skipButton.alpha = 0.0;
        [self.skipButton addTarget:self action:@selector(onSkipButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    if ([dataSource respondsToSelector:@selector(neverRemindButtonInGuideViewController:)]) {
        self.neverRemindButton = [dataSource neverRemindButtonInGuideViewController:self.identifier];
        self.neverRemindButton.alpha = 0.0;
        [self.neverRemindButton addTarget:self action:@selector(onNeverRemindButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (UIWindow *)window {
    if (!_window) {
        UIWindow *window = UIWindow.new;
        _window = window;
        window.backgroundColor = UIColor.clearColor;
        if (@available(iOS 13.0, *)) {
            UIWindowScene *windowScene = (UIWindowScene *)UIApplication.sharedApplication.connectedScenes.anyObject;
            window.windowScene = windowScene;
        }
    }
    return _window;
}

- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        CAShapeLayer *layer = CAShapeLayer.layer;
        _maskLayer = layer;
        layer.fillRule = kCAFillRuleEvenOdd;
    }
    return _maskLayer;
}

- (UIVisualEffectView *)visualEffectView {
    if (!_visualEffectView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _visualEffectView = visualEffectView;
        visualEffectView.alpha = 0.9;
    }
    return _visualEffectView;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        CGRect frame = CGRectMake(0, 0, 110, 40);
        IGuideButton *button = [IGuideButton buttonWithType:UIButtonTypeSystem];
        _skipButton = button;
        button.layer.cornerRadius = CGRectGetHeight(frame) * 0.5;
        button.layer.backgroundColor = UIColor.systemBlueColor.CGColor;
        button.alpha = 0.0;
        CGFloat h = UIApplication.sharedApplication.statusBarFrame.size.height;
        button.safeInsets = UIEdgeInsetsMake(h, 20, 20, 20);
        [button setFrame:frame];
        [button setTitle:@"跳过教程" forState:UIControlStateNormal];
        [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
        [button addTarget:self action:@selector(onSkipButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button drawsShadowWithColor:UIColor.blackColor];
    }
    return _skipButton;
}

- (UIButton *)neverRemindButton {
    if (!_neverRemindButton) {
        CGRect frame = CGRectMake(0, 0, 110, 40);
        IGuideButton *button = [IGuideButton buttonWithType:UIButtonTypeSystem];
        _neverRemindButton = button;
        button.layer.cornerRadius = CGRectGetHeight(frame) * 0.5;
        button.layer.backgroundColor = UIColor.systemBlueColor.CGColor;
        button.alpha = 0.0;
        CGFloat h = UIApplication.sharedApplication.statusBarFrame.size.height;
        button.safeInsets = UIEdgeInsetsMake(h, 20, 20, 20);
        [button setFrame:frame];
        [button setTitle:@"不再提醒" forState:UIControlStateNormal];
        [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
        [button addTarget:self action:@selector(onNeverRemindButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button drawsShadowWithColor:UIColor.blackColor];
    }
    return _neverRemindButton;
}

//MARK: - Event response
- (void)onPreviousButtonPressed:(UIButton *)button {
    self.currentIndex--;
    [self showGuideAtIndex:self.currentIndex];
}

- (void)onNextButtonPressed:(UIButton *)button {
    NSUInteger count = [self.dataSource numberOfGuidesInGuideViewController:self.identifier];
    self.currentIndex++;
    if (self.currentIndex >= count) {
        [self onSkipButtonPressed:nil];
    } else {
        [self showGuideAtIndex:self.currentIndex];
    }
}

- (void)onSkipButtonPressed:(UIButton *)button {
    [self runEndingAnimationWithCompletion:^{
        if ([self.dataSource respondsToSelector:@selector(guideViewControllerDidSelectSkipTutorial:)]) {
            [self.dataSource guideViewControllerDidSelectSkipTutorial:self.identifier];
        }
        self.window.hidden = YES;
        self.window.rootViewController = nil;
    }];
}

- (void)onNeverRemindButtonPressed:(UIButton *)button {
    [self runEndingAnimationWithCompletion:^{
        if ([self.dataSource respondsToSelector:@selector(guideViewControllerDidSelectNeverRemind:)]) {
            [self.dataSource guideViewControllerDidSelectNeverRemind:self.identifier];
        }
        self.window.hidden = YES;
        self.window.rootViewController = nil;
    }];
}

@end
