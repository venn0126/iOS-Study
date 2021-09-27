//
//  UIView+ShakeAnimation.h
//  TestFishhook
//
//  Created by Augus on 2021/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    SNAugusDirectionHorizontal,
    SNAugusDirectionVetical
} SNAugusDirection;

@interface UIView (ShakeAnimation)



/// Shake View
/// @param times Shake times
/// @param speed Shake speed
/// @param range Shake offset
/// @param shakeDirection Shake Direction
- (void)shakeTimes:(NSInteger)times
             speed:(CGFloat)speed
             range:(CGFloat)range
    shakeDirection:(SNAugusDirection)shakeDirection;
@end

NS_ASSUME_NONNULL_END
