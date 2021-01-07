//
//  FSProcessView.h
//  TestGuideLayout
//
//  Created by Augus on 2020/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSProcessView : UIView

/** 进度 */
@property (nonatomic, assign) CGFloat progress;
/** 底层颜色 */
@property (nonatomic, strong) UIColor *bottomColor;
/** 顶层颜色 */
@property (nonatomic, strong) UIColor *topColor;
/** 宽度 */
@property (nonatomic, assign) CGFloat progressWidth;


/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame progress:(CGFloat)progress;

- (void)startProcessAnimation;

- (void)stopProcessAnimation;

@end

NS_ASSUME_NONNULL_END
