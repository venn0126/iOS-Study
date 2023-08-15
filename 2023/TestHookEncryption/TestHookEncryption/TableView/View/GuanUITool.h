//
//  GuanUITool.h
//  TestHookEncryption
//
//  Created by Augus on 2023/8/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+Extension.h"


/// Get status bar's height.
UIKIT_EXTERN CGFloat GuanStatusBarHeight(void);

#define GuanOneTitleFont 22.0
#define GuanTwoTitleFont 20.0
#define GuanThreeTitleFont 18.0
#define GuanTourTitleFont 16.0

NS_ASSUME_NONNULL_BEGIN

@interface GuanUITool : NSObject


+ (CGFloat)guan_navigationViewHeight;

+ (UIColor *)guan_red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

+ (UIColor *)guan_red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

@end

NS_ASSUME_NONNULL_END
