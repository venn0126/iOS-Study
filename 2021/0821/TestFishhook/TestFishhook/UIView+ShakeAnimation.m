//
//  UIView+ShakeAnimation.m
//  TestFishhook
//
//  Created by Augus on 2021/9/27.
//

#import "UIView+ShakeAnimation.h"

@implementation UIView (ShakeAnimation)

- (void)shakeDirection:(SNAugusDirection)shakeDirection {
    
     [self shakeTimes:10 speed:0.05 range:5 shakeDirection:shakeDirection];
 }

 - (void)shakeTimes:(NSInteger)times shakeDirection:(SNAugusDirection)shakeDirection {
     
     [self shakeTimes:times speed:0.05 range:5 shakeDirection:shakeDirection];
 }

 - (void)shakeTimes:(NSInteger)times speed:(CGFloat)speed shakeDirection:(SNAugusDirection)shakeDirection {
     
     [self shakeTimes:times speed:speed range:5 shakeDirection:shakeDirection];
 }

- (void)shakeTimes:(NSInteger)times speed:(CGFloat)speed range:(CGFloat)range shakeDirection:(SNAugusDirection)shakeDirection {
    
     [self shakeViewTimes:times speed:speed range:range shakeDirection:shakeDirection currentTimes:0 direction:1];
    
    // Login Optimations
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.65 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self shakeViewTimes:times speed:speed range:range shakeDirection:shakeDirection currentTimes:0 direction:1];
    });
 }


/**
 *  @param times          震动的次数
 *  @param speed          震动的速度
 *  @param range          震动的幅度
 *  @param shakeDirection 哪个方向上的震动
 *  @param currentTimes   当前的震动次数
 *  @param direction      向哪边震动
 */
 - (void)shakeViewTimes:(NSInteger)times speed:(CGFloat)speed range:(CGFloat)range shakeDirection:(SNAugusDirection)shakeDirection currentTimes:(NSInteger)currentTimes direction:(int)direction{

     [UIView animateWithDuration:speed animations:^{
         self.transform = (shakeDirection == SNAugusDirectionHorizontal)? CGAffineTransformMakeTranslation(range * direction, 0):CGAffineTransformMakeTranslation(0, range * direction);
     } completion:^(BOOL finished) {
         if (currentTimes >= times) {
             [UIView animateWithDuration:speed animations:^{
                 self.transform = CGAffineTransformIdentity;
             }];
             return;
         }
         // 循环到times == currentTimes时候 会跳出该方法
         [self shakeViewTimes:times - 1
                                  speed:speed
                                  range:range
               shakeDirection:shakeDirection
                           currentTimes:currentTimes + 1
                              direction:direction * -1];
     }];
 }

@end
