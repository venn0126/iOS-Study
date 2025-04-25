//
//  UIView+Layout.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/4/25.
//

#import "UIView+Layout.h"
#import <objc/runtime.h>


static void * const kUIViewLayoutMethodPropertyBottomGap = @"kUIViewLayoutMethodPropertyBottomGap";
static void * const kUIViewLayoutMethodPropertyTopGap = @"kUIViewLayoutMethodPropertyTopGap";
static void * const kUIViewLayoutMethodPropertyLeftGap = @"kUIViewLayoutMethodPropertyLeftGap";
static void * const kUIViewLayoutMethodPropertyRightGap = @"kUIViewLayoutMethodPropertyRightGap";


CGSize TNScreenPortraitSize(void) {
    static CGSize screenSizeInPoints;
    if (CGSizeEqualToSize(screenSizeInPoints, CGSizeZero))  {
        screenSizeInPoints = UIScreen.mainScreen.bounds.size;
        if (screenSizeInPoints.width > screenSizeInPoints.height) {
            screenSizeInPoints = CGSizeMake(screenSizeInPoints.height, screenSizeInPoints.width);
        }
    }
    return screenSizeInPoints;
}

CGFloat TNStatusBarHeight(void) {
    static CGFloat statusBarHeight;
    if (statusBarHeight <= 0) {
        if (@available(iOS 13.0, *)) {
            UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
            statusBarHeight = statusBarManager.statusBarFrame.size.height;
        } else {
            // Fallback on earlier versions
        }
    }
    return statusBarHeight;
}




@implementation UIView (Layout)

- (CGFloat)tn_height
{
    return self.frame.size.height;
}

- (CGFloat)tn_width
{
    return self.frame.size.width;
}

- (CGFloat)tn_x
{
    return self.frame.origin.x;
}

- (CGFloat)tn_y
{
    return self.frame.origin.y;
}

- (CGSize)tn_size
{
    return self.frame.size;
}

- (CGPoint)tn_origin
{
    return self.frame.origin;
}

- (CGFloat)tn_centerX
{
    return self.center.x;
}

- (CGFloat)tn_centerY
{
    return self.center.y;
}

- (CGFloat)tn_left
{
    return self.frame.origin.x;
}

- (CGFloat)tn_top
{
    return self.frame.origin.y;
}

- (CGFloat)tn_bottom
{
    return self.frame.size.height + self.frame.origin.y;
}

- (CGFloat)tn_right
{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setTn_x:(CGFloat)x
{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setTn_y:(CGFloat)y
{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (void)setTn_left:(CGFloat)left
{
    self.tn_x = left;
}

- (void)setTn_top:(CGFloat)top
{
    self.tn_y = top;
}

- (void)setTn_height:(CGFloat)height
{
    CGRect newFrame = CGRectMake(self.tn_x, self.tn_y, self.tn_width, height);
    self.frame = newFrame;
}

- (void)heightEqualToView:(UIView *)view
{
    self.tn_height = view.tn_height;
}

// width
- (void)setTn_width:(CGFloat)width
{
    CGRect newFrame = CGRectMake(self.tn_x, self.tn_y, width, self.tn_height);
    self.frame = newFrame;
}

- (void)widthEqualToView:(UIView *)view
{
    self.tn_width = view.tn_width;
}

// center
- (void)setTn_centerX:(CGFloat)centerX
{
    CGPoint center = CGPointMake(self.tn_centerX, self.tn_centerY);
    center.x = centerX;
    self.center = center;
}

- (void)setTn_centerY:(CGFloat)centerY
{
    CGPoint center = CGPointMake(self.tn_centerX, self.tn_centerY);
    center.y = centerY;
    self.center = center;
}

// size
- (void)setTn_size:(CGSize)size
{
    self.frame = CGRectMake(self.tn_x, self.tn_y, size.width, size.height);
}

- (void)setSize:(CGSize)size screenType:(UIScreenType)screenType
{
    CGFloat ratio = TNScreenPortraitWidth() / screenType;
    self.frame = CGRectMake(self.tn_x, self.tn_y, size.width * ratio, size.height * ratio);
}

- (void)sizeEqualToView:(UIView *)view
{
    self.frame = CGRectMake(self.tn_x, self.tn_y, view.tn_width, view.tn_height);
}

- (void)centerXEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.tn_centerX = centerPoint.x;
}

- (void)centerYEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.tn_centerY = centerPoint.y;
}

- (void)centerEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.tn_centerX = centerPoint.x;
    self.tn_centerY = centerPoint.y;
}

- (void)top:(CGFloat)top FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.tn_origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.tn_y = floorf(newOrigin.y + top + view.tn_height);
}

- (void)bottom:(CGFloat)bottom FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.tn_origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.tn_y = newOrigin.y - bottom - self.tn_height;
}

- (void)left:(CGFloat)left FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.tn_origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.tn_x = newOrigin.x - left - self.tn_width;
}

- (void)right:(CGFloat)right FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.tn_origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.tn_x = newOrigin.x + right + view.tn_width;
}

- (void)fromTheTop:(CGFloat)distance ofView:(UIView *)view
{
    [self bottom:distance FromView:view];
}

- (void)fromTheBottom:(CGFloat)distance ofView:(UIView *)view
{
    [self top:distance FromView:view];
}

- (void)fromTheLeft:(CGFloat)distance ofView:(UIView *)view
{
    [self left:distance FromView:view];
}

- (void)fromTheRight:(CGFloat)distance ofView:(UIView *)view
{
    [self right:distance FromView:view];
}


- (void)fromTheRelativeTop:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType
{
    [self bottomRatio:distance FromView:view screenType:screenType];
}

- (void)fromTheRelativeBottom:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType
{
    [self topRatio:distance FromView:view screenType:screenType];
}

- (void)fromTheRelativeLeft:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType
{
    [self leftRatio:distance FromView:view screenType:screenType];
}

- (void)fromTheRelativeRight:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType
{
    [self rightRatio:distance FromView:view screenType:screenType];
}


- (void)relativeTopInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    [self topRatioInContainer:top shouldResize:shouldResize screenType:screenType];
}

- (void)relativeBottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    [self bottomRatioInContainer:bottom shouldResize:shouldResize screenType:screenType];
}

- (void)relativeLeftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    [self leftRatioInContainer:left shouldResize:shouldResize screenType:screenType];
}

- (void)relativeRightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    [self rightRatioInContainer:right shouldResize:shouldResize screenType:screenType];
}

- (void)topRatio:(CGFloat)top FromView:(UIView *)view screenType:(UIScreenType)screenType
{
    CGFloat topRatio = top / screenType;
    CGFloat topValue = topRatio * self.superview.tn_width;
    [self top:topValue FromView:view];
}

- (void)bottomRatio:(CGFloat)bottom FromView:(UIView *)view screenType:(UIScreenType)screenType
{
    CGFloat bottomRatio = bottom / screenType;
    CGFloat bottomValue = bottomRatio * self.superview.tn_width;
    [self bottom:bottomValue FromView:view];
}

- (void)leftRatio:(CGFloat)left FromView:(UIView *)view screenType:(UIScreenType)screenType
{
    CGFloat leftRatio = left / screenType;
    CGFloat leftValue = leftRatio * self.superview.tn_width;
    [self left:leftValue FromView:view];
}

- (void)rightRatio:(CGFloat)right FromView:(UIView *)view screenType:(UIScreenType)screenType
{
    CGFloat rightRatio = right / screenType;
    CGFloat rightValue = rightRatio * self.superview.tn_width;
    [self right:rightValue FromView:view];
}

- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.tn_height = self.tn_y - top + self.tn_height;
    }
    self.tn_y = top;
}

- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.tn_height = self.superview.tn_height - bottom - self.tn_y - self.safeAreaBottomGap;
    } else {
        self.tn_y = self.superview.tn_height - self.tn_height - bottom - self.safeAreaBottomGap;
    }
}

- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.tn_width = self.tn_x - left + self.tn_width;
    }
    self.tn_x = left;
}

- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.tn_width = self.superview.tn_width - right - self.tn_x;
    } else {
        self.tn_x = self.superview.tn_width - self.tn_width - right;
    }
}

- (void)topRatioInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    CGFloat topRatio = top / screenType;
    CGFloat topValue = topRatio * self.superview.tn_width;
    [self topInContainer:topValue shouldResize:shouldResize];
}

- (void)bottomRatioInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    CGFloat bottomRatio = bottom / screenType;
    CGFloat bottomValue = bottomRatio * self.superview.tn_width;
    [self bottomInContainer:bottomValue shouldResize:shouldResize];
}

- (void)leftRatioInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    CGFloat leftRatio = left / screenType;
    CGFloat leftValue = leftRatio * self.superview.tn_width;
    [self leftInContainer:leftValue shouldResize:shouldResize];
}

- (void)rightRatioInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType
{
    CGFloat rightRatio = right / screenType;
    CGFloat rightValue = rightRatio * self.superview.tn_width;
    [self rightInContainer:rightValue shouldResize:shouldResize];
}

- (void)topEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.tn_origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.tn_y = newOrigin.y;
}

- (void)bottomEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.tn_origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.tn_y = newOrigin.y + view.tn_height - self.tn_height;
}

- (void)leftEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.tn_origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.tn_x = newOrigin.x;
}

- (void)rightEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.tn_origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.tn_x = newOrigin.x + view.tn_width - self.tn_width;
}

- (UIView *)topSuperView
{
    UIView *topSuperView = self.superview;
    
    if (topSuperView == nil) {
        topSuperView = self;
    } else {
        while (topSuperView.superview) {
            topSuperView = topSuperView.superview;
        }
    }
    
    return topSuperView;
}

- (CGFloat)safeAreaBottomGap
{
    NSNumber *gap = objc_getAssociatedObject(self, kUIViewLayoutMethodPropertyBottomGap);
    if (gap == nil) {
        if (self.superview.safeAreaLayoutGuide.layoutFrame.size.height > 0) {
            gap = @((self.superview.tn_height - self.superview.safeAreaLayoutGuide.layoutFrame.origin.y - self.superview.safeAreaLayoutGuide.layoutFrame.size.height));
        } else {
            gap = nil;
        }
        
        objc_setAssociatedObject(self, kUIViewLayoutMethodPropertyBottomGap, gap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gap.floatValue;
}

- (CGFloat)safeAreaTopGap
{
    NSNumber *gap = objc_getAssociatedObject(self, kUIViewLayoutMethodPropertyTopGap);
    if (gap == nil) {
        gap = @(self.superview.safeAreaLayoutGuide.layoutFrame.origin.y);
        objc_setAssociatedObject(self, kUIViewLayoutMethodPropertyTopGap, gap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gap.floatValue;
}

- (CGFloat)safeAreaLeftGap
{
    NSNumber *gap = objc_getAssociatedObject(self, kUIViewLayoutMethodPropertyLeftGap);
    if (gap == nil) {
        gap = @(self.superview.safeAreaLayoutGuide.layoutFrame.origin.x);
        objc_setAssociatedObject(self, kUIViewLayoutMethodPropertyLeftGap, gap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gap.floatValue;
}

- (CGFloat)safeAreaRightGap
{
    NSNumber *gap = objc_getAssociatedObject(self, kUIViewLayoutMethodPropertyRightGap);
    if (gap == nil) {
        gap = @(self.superview.safeAreaLayoutGuide.layoutFrame.origin.x);
        objc_setAssociatedObject(self, kUIViewLayoutMethodPropertyRightGap, gap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gap.floatValue;
}

@end
