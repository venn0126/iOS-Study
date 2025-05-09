//
//  TNMediator+HandyTools.h
//  TNMediator
//
//  Created by Augus Venn on 2025/4/27.
//

#import "TNMediator.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TNMediator (HandyTools)

/// 最顶层控制器
- (UIViewController * _Nullable)topViewController NS_EXTENSION_UNAVAILABLE_IOS("not available on iOS (App Extension)");

/// 关键窗口
- (UIWindow * _Nullable)keyWindow NS_EXTENSION_UNAVAILABLE_IOS("not available on iOS (App Extension)");

/// push控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated NS_EXTENSION_UNAVAILABLE_IOS("not available on iOS (App Extension)");

/// present控制器
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ _Nullable )(void))completion NS_EXTENSION_UNAVAILABLE_IOS("not available on iOS (App Extension)");

@end

NS_ASSUME_NONNULL_END
