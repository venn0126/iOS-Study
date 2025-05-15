//
//  TNLogger.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import "TNLogger.h"
#import "TNNetworkConfig.h"

// 定义宏，只在 DEBUG 模式下生效
#ifdef DEBUG
    #define TNLogEnabled 1
#else
    #define TNLogEnabled 0
#endif



// 日志级别对应的前缀
static NSString * const TNLogLevelPrefix[] = {
    @"💬", // Verbose
    @"🔍", // Debug
    @"ℹ️", // Info
    @"⚠️", // Warning
    @"❌"  // Error
};

// 日志级别对应的颜色（控制台 ANSI 颜色代码）
static NSString * const TNLogLevelColor[] = {
    @"\033[0;37m", // Verbose - 白色
    @"\033[0;36m", // Debug - 青色
    @"\033[0;32m", // Info - 绿色
    @"\033[0;33m", // Warning - 黄色
    @"\033[0;31m"  // Error - 红色
};

// 重置颜色
static NSString * const TNLogResetColor = @"\033[0m";

@implementation TNLogger

+ (NSString *)logDebugInfoWithRequest:(NSURLRequest *)request apiName:(NSString *)apiName service:(id)service {
    if (![TNNetworkConfig sharedConfig].enableDebugLog) {
        return @"";
    }
    
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n**************************************\n*            请求信息               *\n**************************************\n\n"];
    
    [logString appendFormat:@"API名称: %@\n", apiName];
    [logString appendFormat:@"请求URL: %@\n", request.URL.absoluteString];
    [logString appendFormat:@"请求方法: %@\n", request.HTTPMethod];
    
    [logString appendString:@"\n----------请求头----------\n"];
    [request.allHTTPHeaderFields enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [logString appendFormat:@"%@: %@\n", key, obj];
    }];
    
    if (request.HTTPBody) {
        NSString *bodyString = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        [logString appendString:@"\n----------请求体----------\n"];
        [logString appendFormat:@"%@\n", bodyString];
    }
    
    [logString appendString:@"\n**************************************\n\n"];
    
    TNLogD(@"%@", logString);
    
    return logString;
}

+ (NSString *)logDebugInfoWithResponse:(NSHTTPURLResponse *)response
                        responseObject:(id)responseObject
                        responseString:(NSString *)responseString
                               request:(NSURLRequest *)request
                                 error:(NSError *)error {
    if (![TNNetworkConfig sharedConfig].enableDebugLog) {
        return @"";
    }
    
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n======================================\n=            响应信息               =\n======================================\n\n"];
    
    [logString appendFormat:@"请求URL: %@\n", request.URL.absoluteString];
    
    if (error) {
        [logString appendFormat:@"错误信息: %@\n", error.localizedDescription];
    } else {
        [logString appendFormat:@"状态码: %ld\n", (long)response.statusCode];
        
        [logString appendString:@"\n----------响应头----------\n"];
        [response.allHeaderFields enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [logString appendFormat:@"%@: %@\n", key, obj];
        }];
        
        [logString appendString:@"\n----------响应体----------\n"];
        if (responseString) {
            [logString appendFormat:@"%@\n", responseString];
        } else if (responseObject) {
            [logString appendFormat:@"%@\n", responseObject];
        }
    }
    
    [logString appendString:@"\n======================================\n\n"];
    
    TNLogD(@"%@", logString);
    
    return logString;
}


+ (void)logWithLevel:(TNLogLevel)level
                file:(const char *)file
                line:(NSInteger)line
              method:(const char *)method
              format:(NSString *)format, ... {
    if (!TNLogEnabled || ![TNNetworkConfig sharedConfig].enableDebugLog) {
        return;
    }
    
    // 获取文件名（去掉路径）
    NSString *fileName = [[NSString stringWithUTF8String:file] lastPathComponent];
    // 获取方法名
    NSString *methodName = [NSString stringWithUTF8String:method];
    
    // 处理可变参数
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    // 构建完整日志消息
    NSString *logMessage = [NSString stringWithFormat:@"%@%@ %@ [%@:%ld] %@: %@%@",
                           TNLogLevelColor[level],
                           TNLogLevelPrefix[level],
                           [self currentTimeString],
                           fileName,
                           (long)line,
                           methodName,
                           message,
                           TNLogResetColor];
    
    // 输出到控制台
    printf("%s\n", [logMessage UTF8String]);
}

+ (NSString *)currentTimeString {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    });
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (void)logVerbose:(NSString *)format, ... {
    if (!TNLogEnabled || ![TNNetworkConfig sharedConfig].enableDebugLog) {
        return;
    }
    
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    [self logWithLevel:TNLogLevelVerbose file:__FILE__ line:__LINE__ method:__PRETTY_FUNCTION__ format:@"%@", message];
}

+ (void)logDebug:(NSString *)format, ... {
    if (!TNLogEnabled || ![TNNetworkConfig sharedConfig].enableDebugLog) {
        return;
    }
    
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    [self logWithLevel:TNLogLevelDebug file:__FILE__ line:__LINE__ method:__PRETTY_FUNCTION__ format:@"%@", message];
}

+ (void)logInfo:(NSString *)format, ... {
    if (!TNLogEnabled || ![TNNetworkConfig sharedConfig].enableDebugLog) {
        return;
    }
    
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    [self logWithLevel:TNLogLevelInfo file:__FILE__ line:__LINE__ method:__PRETTY_FUNCTION__ format:@"%@", message];
}

+ (void)logWarning:(NSString *)format, ... {
    if (!TNLogEnabled || ![TNNetworkConfig sharedConfig].enableDebugLog) {
        return;
    }
    
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    [self logWithLevel:TNLogLevelWarning file:__FILE__ line:__LINE__ method:__PRETTY_FUNCTION__ format:@"%@", message];
}

+ (void)logError:(NSString *)format, ... {
    if (!TNLogEnabled || ![TNNetworkConfig sharedConfig].enableDebugLog) {
        return;
    }
    
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    [self logWithLevel:TNLogLevelError file:__FILE__ line:__LINE__ method:__PRETTY_FUNCTION__ format:@"%@", message];
}

@end
