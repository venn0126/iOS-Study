//
//  GTFloatButton.h
//  TestObjcSome
//
//  Created by Augus on 2023/2/7.
//

#import <UIKit/UIKit.h>
#import "GTFloatButtonContent.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GTAssistiveTouchType)
{
    GTAssistiveTypeNone = 0,   //自动识别贴边
    GTAssistiveTypeNearLeft,   //拖动停止之后，自动向左贴边
    GTAssistiveTypeNearRight,  //拖动停止之后，自动向右贴边
};


@interface GTFloatButton : UIWindow

/// 任何模式都显示floatBtn
+ (void)show;

/// 仅在Debug模式下显示floatBtn(**推荐这种设置，防止floatBtn跑生产环境上**)
+ (void)showDebugMode;

/// Debug模式下都显示floatBtn - 并设置float吸附设置
+ (void)showDebugModeWithType:(GTAssistiveTouchType)type;

/// 移除floatBtn在界面显示
+ (void)hidden;

/// 获取floatBtn对象
+ (GTFloatButtonContent *)sharedBtn;

/**
 做的环境映射
 
 比如
 dev - https://miniDev.com
 qa  - https://miniQA.com
 pro - https://miniPro.com
 
 {
 @"开发":miniDev,
 @"测试":miniQA,
 @"生产":miniPro,
 }
 
 @param environmentMap 环境 - Host 的 映射
 @param currentEnv - 当前环境的Host
 */
+ (void)setEnvironmentMap:(NSDictionary *)environmentMap
               currentEnv:(NSString *)currentEnv;


@end

NS_ASSUME_NONNULL_END
