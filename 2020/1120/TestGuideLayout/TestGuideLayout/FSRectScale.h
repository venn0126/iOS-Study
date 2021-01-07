//
//  FSRectScale.h
//  TestGuideLayout
//
//  Created by Augus on 2020/12/29.
//

#import <UIKit/UIKit.h>


typedef void(^animationBlock) (BOOL flag);

NS_ASSUME_NONNULL_BEGIN

@interface FSRectScale : UIView


- (void)rs_startAnimation;
- (void)rs_stopAnimation:(animationBlock)block;


@end

NS_ASSUME_NONNULL_END
