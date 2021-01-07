//
//  FOSBottomView.h
//  TestGuideLayout
//
//  Created by Augus on 2020/12/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FOSBottomView : UIView


@property (nonatomic, assign)  NSTimeInterval fosDuration;


- (void)fosStartAnimation;
- (void)fosStopAnimation;

@end

NS_ASSUME_NONNULL_END
