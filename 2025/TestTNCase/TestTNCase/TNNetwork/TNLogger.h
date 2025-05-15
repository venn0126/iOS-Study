//
//  TNLogger.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 定义日志级别
typedef NS_ENUM(NSInteger, TNLogLevel) {
    TNLogLevelVerbose,
    TNLogLevelDebug,
    TNLogLevelInfo,
    TNLogLevelWarning,
    TNLogLevelError
};

@interface TNLogger : NSObject

+ (NSString *)logDebugInfoWithRequest:(NSURLRequest *)request
                              apiName:(NSString *)apiName
                              service:(id)service;

+ (NSString *)logDebugInfoWithResponse:(NSHTTPURLResponse *)response
                        responseObject:(nullable id)responseObject
                        responseString:(nullable NSString *)responseString
                               request:(NSURLRequest *)request
                                 error:(nullable NSError *)error;


+ (void)logInfo:(NSString *)format, ...;
+ (void)logWarning:(NSString *)format, ...;
+ (void)logError:(NSString *)format, ...;
+ (void)logVerbose:(NSString *)format, ...;
+ (void)logDebug:(NSString *)format, ...;

// 通用日志方法
+ (void)logWithLevel:(TNLogLevel)level
                file:(const char *)file
                line:(NSInteger)line
              method:(const char *)method
              format:(NSString *)format, ...;

@end

// 便捷宏定义，方便在代码中使用
#ifdef DEBUG
    #define TNLogV(fmt, ...) [TNLogger logVerbose:fmt, ##__VA_ARGS__]
    #define TNLogD(fmt, ...) [TNLogger logDebug:fmt, ##__VA_ARGS__]
    #define TNLogI(fmt, ...) [TNLogger logInfo:fmt, ##__VA_ARGS__]
    #define TNLogW(fmt, ...) [TNLogger logWarning:fmt, ##__VA_ARGS__]
    #define TNLogE(fmt, ...) [TNLogger logError:fmt, ##__VA_ARGS__]
#else
    #define TNLogV(fmt, ...)
    #define TNLogD(fmt, ...)
    #define TNLogI(fmt, ...)
    #define TNLogW(fmt, ...)
    #define TNLogE(fmt, ...)
#endif

NS_ASSUME_NONNULL_END
