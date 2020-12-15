//
//  FosTool.h
//  fosFloatView
//
//  Created by Augus on 2020/11/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FosTool : NSObject

+ (UIViewController *)fs_convertToController:(NSString *)controller;

+ (UIViewController *)fs_currentViewController;
+ (UITabBarController *)fs_currentTabBarController;
+ (UINavigationController *)fs_currentNavigationController;

+ (void)fos_hideKeyboard:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
