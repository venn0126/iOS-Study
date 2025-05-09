//
//  TNLogger.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import "TNLogger.h"
#import "TNNetworkConfig.h"

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
    
    NSLog(@"%@", logString);
    
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
    
    NSLog(@"%@", logString);
    
    return logString;
}

+ (void)logInfo:(NSString *)format, ... {
    if (![TNNetworkConfig sharedConfig].enableDebugLog) {
        return;
    }
    
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    NSLog(@"[TNNetworking INFO] %@", message);
}

+ (void)logWarning:(NSString *)format, ... {
    if (![TNNetworkConfig sharedConfig].enableDebugLog) {
        return;
    }
    
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    NSLog(@"[TNNetworking WARNING] %@", message);
}

+ (void)logError:(NSString *)format, ... {
    if (![TNNetworkConfig sharedConfig].enableDebugLog) {
        return;
    }
    
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    NSLog(@"[TNNetworking ERROR] %@", message);
}

@end
