//
//  GuanFloatView.h
//  TestObjcSome
//
//  Created by Augus on 2023/6/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



typedef void(^TapActionWithBlock)(void);


// 停留方式
typedef NS_ENUM(NSInteger, GuanFloatViewStayMode) {
    /// 停靠左右两侧
    GuanFloatViewStayModeLeftAndRight = 0,
    /// 停靠左侧
    GuanFloatViewStayModeLeft = 1,
    /// 停靠右侧
    GuanFloatViewStayModeRight = 2
};

@interface GuanFloatView : UIImageView

/// 悬浮图片停留的方式(默认为GuanFloatViewStayModeLeftAndRight)
@property (nonatomic, assign) GuanFloatViewStayMode stayMode;

/// 悬浮图片左右边距(默认5)
@property (nonatomic, assign) CGFloat stayEdgeDistance;

/// 悬浮图片停靠的动画事件(默认0.3秒)
@property (nonatomic, assign) CGFloat stayAnimateTime;

@property (nonatomic,assign) BOOL isTouchBegin;

@property (nonatomic,assign) BOOL isTouchMoved;

@property (nonatomic,assign) CGPoint touchPoint;

@property (nonatomic,copy) TapActionWithBlock tapActionWithBlock;

/// 设置轻点 block事件
- (void)setTapActionWithBlock:(TapActionWithBlock)block;

/// 根据 imageName 改变GuanFloatView的image
- (void)setImageWithName:(NSString *)imageName;

/// 当滚动的时候悬浮图片居中在屏幕边缘
- (void)moveTohalfInScreenWhenScrolling;

/// 设置当前浮动图片的透明度
- (void)setCurrentAlpha:(CGFloat)stayAlpha;

/// 内容视图的是否展示
- (void)contentViewShowChange;

@end

NS_ASSUME_NONNULL_END
