//
//  FSBounceView.h
//  TestGuideLayout
//
//  Created by Augus on 2020/12/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSBounceView : UIView

//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
