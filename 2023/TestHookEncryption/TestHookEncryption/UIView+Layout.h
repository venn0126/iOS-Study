//
//  UIView+Layout.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/4/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// This value does not change as the device rotates.
/// width is always smaller than height.
UIKIT_EXTERN CGSize TNScreenPortraitSize(void);

/// 获取状态栏高度
UIKIT_EXTERN CGFloat TNStatusBarHeight(void);


/// 纵向屏幕宽度
UIKIT_STATIC_INLINE CGFloat TNScreenPortraitWidth(void) {
    return TNScreenPortraitSize().width;
}

/// 纵向屏幕高度
UIKIT_STATIC_INLINE CGFloat TNScreenPortraitHeight(void) {
    return TNScreenPortraitSize().height;
}

typedef CGFloat UIScreenType;

@interface UIView (Layout)

/// height
- (CGFloat)tn_height;
/// width
- (CGFloat)tn_width;
/// x
- (CGFloat)tn_x;
/// y
- (CGFloat)tn_y;
/// size
- (CGSize)tn_size;
/// origin
- (CGPoint)tn_origin;
/// centerX
- (CGFloat)tn_centerX;
/// centerY
- (CGFloat)tn_centerY;
/// left
- (CGFloat)tn_left;
/// top
- (CGFloat)tn_top;
/// bottom
- (CGFloat)tn_bottom;
/// right
- (CGFloat)tn_right;
///
- (void)setTn_x:(CGFloat)x;
- (void)setTn_left:(CGFloat)left;
- (void)setTn_y:(CGFloat)y;
- (void)setTn_top:(CGFloat)top;

// height
- (void)setTn_height:(CGFloat)height;
- (void)heightEqualToView:(UIView *)view;

// width
- (void)setTn_width:(CGFloat)width;
- (void)widthEqualToView:(UIView *)view;

// size
- (void)setTn_size:(CGSize)size;
- (void)setSize:(CGSize)size screenType:(UIScreenType)screenType;
- (void)sizeEqualToView:(UIView *)view;

// center
- (void)setTn_centerX:(CGFloat)centerX;
- (void)setTn_centerY:(CGFloat)centerY;
- (void)centerXEqualToView:(UIView *)view;
- (void)centerYEqualToView:(UIView *)view;
- (void)centerEqualToView:(UIView *)view;

- (void)fromTheTop:(CGFloat)distance ofView:(UIView *)view;
- (void)fromTheBottom:(CGFloat)distance ofView:(UIView *)view;
- (void)fromTheLeft:(CGFloat)distance ofView:(UIView *)view;
- (void)fromTheRight:(CGFloat)distance ofView:(UIView *)view;

- (void)fromTheRelativeTop:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType;
- (void)fromTheRelativeBottom:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType;
- (void)fromTheRelativeLeft:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType;
- (void)fromTheRelativeRight:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType;

- (void)relativeTopInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)relativeBottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)relativeLeftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)relativeRightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;

- (void)top:(CGFloat)top FromView:(UIView *)view;
- (void)bottom:(CGFloat)bottom FromView:(UIView *)view;
- (void)left:(CGFloat)left FromView:(UIView *)view;
- (void)right:(CGFloat)right FromView:(UIView *)view;

- (void)topRatio:(CGFloat)top FromView:(UIView *)view screenType:(UIScreenType)screenType;
- (void)bottomRatio:(CGFloat)bottom FromView:(UIView *)view screenType:(UIScreenType)screenType;
- (void)leftRatio:(CGFloat)left FromView:(UIView *)view screenType:(UIScreenType)screenType;
- (void)rightRatio:(CGFloat)right FromView:(UIView *)view screenType:(UIScreenType)screenType;

- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize;
- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize;
- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize;
- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize;

- (void)topRatioInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)bottomRatioInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)leftRatioInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)rightRatioInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;

- (void)topEqualToView:(UIView *)view;
- (void)bottomEqualToView:(UIView *)view;
- (void)leftEqualToView:(UIView *)view;
- (void)rightEqualToView:(UIView *)view;

- (CGFloat)safeAreaBottomGap;
- (CGFloat)safeAreaTopGap;
- (CGFloat)safeAreaLeftGap;
- (CGFloat)safeAreaRightGap;

- (UIView *)topSuperView;
@end

NS_ASSUME_NONNULL_END
