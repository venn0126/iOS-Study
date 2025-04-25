//
//  UIView+Layout.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/4/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 此值在设备旋转时不会变化。
/// 宽度总是小于高度。
/// 获取竖屏时的屏幕尺寸（宽高）
UIKIT_EXTERN CGSize TNScreenPortraitSize(void);

/// 获取状态栏高度（兼容iOS 13及以上，自动适配）
UIKIT_EXTERN CGFloat TNStatusBarHeight(void);

/// 获取竖屏下的屏幕宽度
UIKIT_STATIC_INLINE CGFloat TNScreenPortraitWidth(void) {
    return TNScreenPortraitSize().width;
}

/// 获取竖屏下的屏幕高度
UIKIT_STATIC_INLINE CGFloat TNScreenPortraitHeight(void) {
    return TNScreenPortraitSize().height;
}

typedef CGFloat UIScreenType;

@interface UIView (Layout)

/// 获取视图高度
- (CGFloat)tn_height;
/// 获取视图宽度
- (CGFloat)tn_width;
/// 获取视图x坐标（frame.origin.x）
- (CGFloat)tn_x;
/// 获取视图y坐标（frame.origin.y）
- (CGFloat)tn_y;
/// 获取视图的尺寸（CGSize）
- (CGSize)tn_size;
/// 获取视图的原点（CGPoint）
- (CGPoint)tn_origin;
/// 获取视图中心点的x坐标
- (CGFloat)tn_centerX;
/// 获取视图中心点的y坐标
- (CGFloat)tn_centerY;
/// 获取视图左边界（frame.origin.x）
- (CGFloat)tn_left;

/// top
/// 获取视图上边界（frame.origin.y）
- (CGFloat)tn_top;
/// 获取视图下边界（frame.origin.y + height）
- (CGFloat)tn_bottom;
/// 获取视图右边界（frame.origin.x + width）
- (CGFloat)tn_right;
///
- (void)setTn_x:(CGFloat)x;
/// 设置左边界（frame.origin.x）
- (void)setTn_left:(CGFloat)left;
/// 设置y坐标（frame.origin.y）
- (void)setTn_y:(CGFloat)y;
/// 设置上边界（frame.origin.y）
- (void)setTn_top:(CGFloat)top;

// height
/// 设置视图高度
- (void)setTn_height:(CGFloat)height;
/// 高度等于指定视图
- (void)heightEqualToView:(UIView *)view;

// width
/// 设置视图宽度
- (void)setTn_width:(CGFloat)width;
/// 宽度等于指定视图
- (void)widthEqualToView:(UIView *)view;

// size
/// 设置视图尺寸（CGSize）
- (void)setTn_size:(CGSize)size;
/// 根据不同屏幕类型设置尺寸
- (void)setSize:(CGSize)size screenType:(UIScreenType)screenType;
/// 尺寸等于指定视图
- (void)sizeEqualToView:(UIView *)view;

// center
/// 设置视图中心点的X坐标
- (void)setTn_centerX:(CGFloat)centerX;
/// 设置视图中心点的Y坐标
- (void)setTn_centerY:(CGFloat)centerY;
/// centerX等于指定视图
- (void)centerXEqualToView:(UIView *)view;
/// centerY等于指定视图
- (void)centerYEqualToView:(UIView *)view;
/// center等于指定视图
- (void)centerEqualToView:(UIView *)view;

/// 距离指定视图顶部一定距离
- (void)fromTheTop:(CGFloat)distance ofView:(UIView *)view;
/// 距离指定视图底部一定距离
- (void)fromTheBottom:(CGFloat)distance ofView:(UIView *)view;
/// 距离指定视图左侧一定距离
- (void)fromTheLeft:(CGFloat)distance ofView:(UIView *)view;
/// 距离指定视图右侧一定距离
- (void)fromTheRight:(CGFloat)distance ofView:(UIView *)view;

/// 相对屏幕类型，距离指定视图顶部一定距离
- (void)fromTheRelativeTop:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType;
/// 相对屏幕类型，距离指定视图底部一定距离
- (void)fromTheRelativeBottom:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType;
/// 相对屏幕类型，距离指定视图左侧一定距离
- (void)fromTheRelativeLeft:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType;
/// 相对屏幕类型，距离指定视图右侧一定距离
- (void)fromTheRelativeRight:(CGFloat)distance ofView:(UIView *)view screenType:(UIScreenType)screenType;

/// 视图在父容器顶部的相对距离，是否自适应高度，适配不同屏幕类型
- (void)relativeTopInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
/// 视图在父容器底部的相对距离，是否自适应高度，适配不同屏幕类型
- (void)relativeBottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
/// 视图在父容器左侧的相对距离，是否自适应宽度，适配不同屏幕类型
- (void)relativeLeftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
/// 视图在父容器右侧的相对距离，是否自适应宽度，适配不同屏幕类型
- (void)relativeRightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;

/// 距离指定视图顶部top距离
- (void)top:(CGFloat)top FromView:(UIView *)view;
/// 距离指定视图底部bottom距离
- (void)bottom:(CGFloat)bottom FromView:(UIView *)view;
/// 距离指定视图左侧left距离
- (void)left:(CGFloat)left FromView:(UIView *)view;
/// 距离指定视图右侧right距离
- (void)right:(CGFloat)right FromView:(UIView *)view;

/// 距离指定视图顶部比例距离（适配屏幕类型）
- (void)topRatio:(CGFloat)top FromView:(UIView *)view screenType:(UIScreenType)screenType;
/// 距离指定视图底部比例距离（适配屏幕类型）
- (void)bottomRatio:(CGFloat)bottom FromView:(UIView *)view screenType:(UIScreenType)screenType;
/// 距离指定视图左侧比例距离（适配屏幕类型）
- (void)leftRatio:(CGFloat)left FromView:(UIView *)view screenType:(UIScreenType)screenType;
/// 距离指定视图右侧比例距离（适配屏幕类型）
- (void)rightRatio:(CGFloat)right FromView:(UIView *)view screenType:(UIScreenType)screenType;

/// 视图在父容器顶部的距离，是否自适应高度
- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize;
/// 视图在父容器底部的距离，是否自适应高度
- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize;
/// 视图在父容器左侧的距离，是否自适应宽度
- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize;
/// 视图在父容器右侧的距离，是否自适应宽度
- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize;

/// 视图在父容器顶部的比例距离，是否自适应高度（适配屏幕类型）
- (void)topRatioInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
/// 视图在父容器底部的比例距离，是否自适应高度（适配屏幕类型）
- (void)bottomRatioInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
/// 视图在父容器左侧的比例距离，是否自适应宽度（适配屏幕类型）
- (void)leftRatioInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
/// 视图在父容器右侧的比例距离，是否自适应宽度（适配屏幕类型）
- (void)rightRatioInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;

/// 顶部等于指定视图
- (void)topEqualToView:(UIView *)view;
/// 底部等于指定视图
- (void)bottomEqualToView:(UIView *)view;
/// 左侧等于指定视图
- (void)leftEqualToView:(UIView *)view;
/// 右侧等于指定视图
- (void)rightEqualToView:(UIView *)view;

/// 获取安全区底部的距离
- (CGFloat)safeAreaBottomGap;
/// 获取安全区顶部的距离
- (CGFloat)safeAreaTopGap;
/// 获取安全区左侧的距离
- (CGFloat)safeAreaLeftGap;
/// 获取安全区右侧的距离
- (CGFloat)safeAreaRightGap;

/// 获取当前视图最顶层的父视图
- (UIView *)topSuperView;
@end

NS_ASSUME_NONNULL_END
