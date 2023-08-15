//
//  GuanUITool.m
//  TestHookEncryption
//
//  Created by Augus on 2023/8/15.
//

#import "GuanUITool.h"



CGFloat GuanStatusBarHeight(void) {
    static CGFloat statusBarHeight;
    if (statusBarHeight <= 0) {
        if (@available(iOS 13.0, *)) {
            UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
            statusBarHeight = statusBarManager.statusBarFrame.size.height;
        } else {
            statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        }
    }
    
    return statusBarHeight;
}

@implementation GuanUITool


+ (CGFloat)guan_navigationViewHeight {
    
    return 44.0 + GuanStatusBarHeight();
}

+ (UIColor *)guan_red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [self guan_red:red green:green blue:blue alpha:1];
}

+ (UIColor *)guan_red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red/256.0 green:green/256.0 blue:blue/256.0 alpha:alpha];
}


@end
