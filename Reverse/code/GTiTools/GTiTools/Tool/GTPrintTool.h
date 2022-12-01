//
//  GTPrintTool.h
//  GTiTools
//
//  Created by Augus on 2022/12/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 默认颜色
extern NSString *GTPrintColorDefault;

extern NSString *GTPrintColorRed;
extern NSString *GTPrintColorGreen;
extern NSString *GTPrintColorBlue;
extern NSString *GTPrintColorWhite;
extern NSString *GTPrintColorBlack;
extern NSString *GTPrintColorYellow;
extern NSString *GTPrintColorCyan;
extern NSString *GTPrintColorMagenta;

/// 打印警告
extern NSString *GTPrintColorWarning;

/// 打印错误
extern NSString *GTPrintColorError;

/// 打印颜色
extern NSString *GTPrintColorStrong;



@interface GTPrintTool : NSObject

+ (void)print:(NSString *)format, ...;
+ (void)printError:(NSString *)format, ...;
+ (void)printWarning:(NSString *)format, ...;
+ (void)printStrong:(NSString *)format, ...;
+ (void)printColor:(NSString * __nullable )color format:(NSString *)format, ...;

@end

NS_ASSUME_NONNULL_END
