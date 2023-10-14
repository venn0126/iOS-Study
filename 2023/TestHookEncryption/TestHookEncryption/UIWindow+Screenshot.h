//
//  UIWindow+Screenshot.h
//  TestHookEncryption
//
//  Created by Augus on 2023/10/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (Screenshot)

- (UIImage *)screenshot;
- (UIImage *)screenshotWithRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
