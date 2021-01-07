//
//  UIView+Guide.h
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/4.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Guide)

- (void)animateToAlpha:(CGFloat)alpha;
- (void)animateToCenter:(CGPoint)center;

- (void)drawsShadowWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
