//
//  TNMediator+HandyTools.m
//  TNMediator
//
//  Created by Augus Venn on 2025/4/27.
//

#if TARGET_OS_IOS

#import "TNMediator+HandyTools.h"

@implementation TNMediator (HandyTools)

- (UIWindow *)keyWindow {
    for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
        if (scene.activationState == UISceneActivationStateForegroundActive) {
            for (UIWindow *window in scene.windows) {
                if (window.isKeyWindow) {
                    return window;
                }
            }
        }
    }
    return nil;
}

- (UIViewController *)topViewController
{
    UIViewController *topController = [self keyWindow].rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UINavigationController *navigationController = (UINavigationController *)[self topViewController];
    
    if ([navigationController isKindOfClass:[UINavigationController class]] == NO) {
        if ([navigationController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabbarController = (UITabBarController *)navigationController;
            navigationController = tabbarController.selectedViewController;
            if ([navigationController isKindOfClass:[UINavigationController class]] == NO) {
                navigationController = tabbarController.selectedViewController.navigationController;
            }
        } else {
            navigationController = navigationController.navigationController;
        }
    }
    
    if ([navigationController isKindOfClass:[UINavigationController class]]) {
        [navigationController pushViewController:viewController animated:animated];
    }
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ _Nullable)(void))completion
{
    UIViewController *viewController = [self topViewController];
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        viewController = navigationController.topViewController;
    }
    
    if ([viewController isKindOfClass:[UIAlertController class]]) {
        UIViewController *viewControllerToUse = viewController.presentingViewController;
        [viewController dismissViewControllerAnimated:false completion:nil];
        viewController = viewControllerToUse;
    }
    
    if (viewController) {
        [viewController presentViewController:viewControllerToPresent animated:animated completion:completion];
    }
}

@end

#endif
