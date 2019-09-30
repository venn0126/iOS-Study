//
//  MTransitionButton.h
//  Test0929
//
//  Created by 牛威 on 2019/9/30.
//  Copyright © 2019 fosafer. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    
    MTransitionButtonNormal,
    MTransitionButtonExpand,
    MTransitionButtonShake,
    
} MTransitionButtonStyle;

NS_ASSUME_NONNULL_BEGIN

@interface MTransitionButton : UIButton

- (void)startAnimation;

- (void)stopAnimation:(MTransitionButtonStyle)style delay:(NSTimeInterval)delay completion:(void(^)(void))completion;


@end

NS_ASSUME_NONNULL_END
