//
//  FadeTransition.h
//  Test0929
//
//  Created by 牛威 on 2019/9/30.
//  Copyright © 2019 fosafer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FadeTransition : NSObject

- (instancetype)initTransitionDuration:(NSTimeInterval)duration startingAlpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
