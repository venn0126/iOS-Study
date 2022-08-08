//
//  SNAugusFadeImageView.h
//  TestMutableDictionary
//
//  Created by Augus on 2022/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 正文页加载的动画对象
@interface SNAugusFadeImageView : UIView

/// 需要展示的图片的名字
@property (nonatomic, copy) NSString *imageName;

/// 完成一次动画的时间
@property (nonatomic, assign) NSTimeInterval animationDuration;

/// 动画是否在进行中的标识符
@property (nonatomic, assign, readonly) BOOL isAnimationing;

/// 开始动画
- (void)startAnimation;

/// 停止动画
- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
