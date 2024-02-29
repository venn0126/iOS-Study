//
//  SNAnimationCustom.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2024/2/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNAnimationCustom : NSObject

+ (void)animationPushLeft:(UIView *)view duration:(CFTimeInterval)duration;

+ (void)animationPushRight:(UIView *)view duration:(CFTimeInterval)duration;

+ (CABasicAnimation *)animation_moveX:(float)time X:(NSNumber *)x;


@end

NS_ASSUME_NONNULL_END
