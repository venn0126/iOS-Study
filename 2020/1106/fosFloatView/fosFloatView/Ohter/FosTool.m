//
//  FosTool.m
//  fosFloatView
//
//  Created by Augus on 2020/11/10.
//

#import "FosTool.h"

@implementation FosTool

+ (UIViewController *)fs_convertToController:(NSString *)controller {
    
    if (!controller || controller.length <= 0) {
        return  nil;
    }
    Class fsClass = NSClassFromString(controller);
    id fsObj = [[fsClass alloc] init];
    if ([fsObj isKindOfClass:[UIViewController class]]) {
        
        return (UIViewController *)fsObj;
    }
    
    return  nil;
}


+ (UIViewController *)fs_currentViewController {
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController *) vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController *) vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        } else {
            break;
        }
    }
    return vc;
}

+ (UINavigationController *)fs_currentNavigationController {
    return [self fs_currentViewController].navigationController;
}

+ (UITabBarController *)fs_currentTabBarController {
    return [self fs_currentViewController].tabBarController;
}


+ (void)fos_hideKeyboard:(UIView *)view {
    [self _traverseAllSubviewsToResignFirstResponder:view];
}

// 遍历父视图的所有子视图包括嵌套的视图
+ (void)_traverseAllSubviewsToResignFirstResponder:(UIView *)view {
    for (UIView *subview in view.subviews) {
        if (subview.subviews.count != 0) {
            [self _traverseAllSubviewsToResignFirstResponder:subview];
        }
        [subview resignFirstResponder];
    }
}

@end
