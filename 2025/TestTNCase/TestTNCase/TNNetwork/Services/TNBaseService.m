//
//  TNBaseService.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import "TNBaseService.h"
#import "TNNetworkConfig.h"
#import "NSString+TNAdditions.h"

@interface TNBaseService ()

@property (nonatomic, copy) NSString *baseURL;
@property (nonatomic, strong) AFHTTPSessionManager *sessionMgr;

@end


@implementation TNBaseService

#pragma mark - 初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        _apiEnvironment = [TNNetworkConfig sharedConfig].defaultEnvironment;
    }
    return self;
}

- (instancetype)initWithBaseURL:(NSString *)baseURL {
    self = [self init];
    if (self) {
        _baseURL = [baseURL copy];
    }
    return self;
}

#pragma mark - TNServiceProtocol
- (NSURLRequest *)requestWithParams:(NSDictionary *)params methodName:(NSString *)methodName requestType:(TNAPIManagerRequestType)requestType {
    NSString *urlString = [self urlStringWithMethodName:methodName];
    NSMutableDictionary *finalParams = [NSMutableDictionary dictionary];
    
    // 添加通用参数
    NSDictionary *commonParams = [self commonParams];
    if (commonParams) {
        [finalParams addEntriesFromDictionary:commonParams];
    }
    
    // 添加业务参数
    if (params) {
        [finalParams addEntriesFromDictionary:params];
    }
    
    // 创建请求
    AFHTTPSessionManager *sessionManager = [self sessionManager];
    NSMutableURLRequest *request = nil;
    
    switch (requestType) {
        case TNAPIManagerRequestTypeGet: {
            if (finalParams.count > 0) {
                urlString = [urlString tn_stringByAppendingURLParams:finalParams];
            }
            request = [sessionManager.requestSerializer requestWithMethod:@"GET"
                                                                URLString:urlString
                                                               parameters:nil
                                                                    error:nil];
            break;
        }
        case TNAPIManagerRequestTypePost:
            request = [sessionManager.requestSerializer requestWithMethod:@"POST"
                                                                URLString:urlString
                                                               parameters:finalParams
                                                                    error:nil];
            break;
        case TNAPIManagerRequestTypePut:
            request = [sessionManager.requestSerializer requestWithMethod:@"PUT"
                                                                URLString:urlString
                                                               parameters:finalParams
                                                                    error:nil];
            break;
        case TNAPIManagerRequestTypeDelete:
            request = [sessionManager.requestSerializer requestWithMethod:@"DELETE"
                                                                URLString:urlString
                                                               parameters:finalParams
                                                                    error:nil];
            break;
        case TNAPIManagerRequestTypePatch:
            request = [sessionManager.requestSerializer requestWithMethod:@"PATCH"
                                                                URLString:urlString
                                                               parameters:finalParams
                                                                    error:nil];
            break;
        case TNAPIManagerRequestTypeHead:
            request = [sessionManager.requestSerializer requestWithMethod:@"HEAD"
                                                                URLString:urlString
                                                               parameters:finalParams
                                                                    error:nil];
            break;
        default:
            request = [sessionManager.requestSerializer requestWithMethod:@"GET"
                                                                URLString:urlString
                                                               parameters:finalParams
                                                                    error:nil];
            break;
    }
    
    // 添加通用头部
    NSDictionary *commonHeaders = [self commonHeaders];
    if (commonHeaders) {
        [commonHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [request setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    // 添加用户代理
    if ([TNNetworkConfig sharedConfig].userAgent) {
        [request setValue:[TNNetworkConfig sharedConfig].userAgent forHTTPHeaderField:@"User-Agent"];
    }
    
    return request;
}

- (NSDictionary *)resultWithResponseObject:(id)responseObject response:(NSURLResponse *)response request:(NSURLRequest *)request error:(NSError **)error {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    // 处理响应对象
    if (responseObject) {
        result[kTNApiProxyValidateResultKeyResponseObject] = responseObject;
        
        // 如果是字典或数组，转换为JSON字符串
        if ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSArray class]]) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
            if (jsonData) {
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                result[kTNApiProxyValidateResultKeyResponseString] = jsonString;
            }
        }
        // 如果是NSData，尝试转换为字符串
        else if ([responseObject isKindOfClass:[NSData class]]) {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            result[kTNApiProxyValidateResultKeyResponseString] = responseString;
        }
        // 如果是字符串，直接使用
        else if ([responseObject isKindOfClass:[NSString class]]) {
            result[kTNApiProxyValidateResultKeyResponseString] = responseObject;
        }
    }
    
    return result;
}

- (BOOL)handleCommonErrorWithResponse:(TNURLResponse *)response manager:(TNAPIBaseManager *)manager errorType:(TNAPIManagerErrorType)errorType {
    // 默认实现，子类可以重写
    if (errorType == TNAPIManagerErrorTypeNeedLogin) {
        // 发送需要登录的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kTNUserTokenInvalidNotification
                                                            object:nil
                                                          userInfo:@{kTNUserTokenNotificationUserInfoKeyManagerToContinue:manager}];
        return NO;
    } else if (errorType == TNAPIManagerErrorTypeNeedAccessToken) {
        // 发送需要刷新Token的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kTNUserTokenIllegalNotification
                                                            object:nil
                                                          userInfo:@{kTNUserTokenNotificationUserInfoKeyManagerToContinue:manager}];
        return NO;
    }
    
    return YES;
}

#pragma mark - 子类可重写的方法
- (NSString *)baseURLString {
    if (self.baseURL) {
        return self.baseURL;
    }
    
    // 根据环境获取基础URL
    if ([self respondsToSelector:@selector(baseURLForEnvironment:)]) {
        return [self baseURLForEnvironment:self.apiEnvironment];
    }	
    
    return @"";
}

- (NSDictionary *)commonHeaders {
    // 默认实现，子类可以重写
    return nil;
}

- (NSDictionary *)commonParams {
    // 默认实现，子类可以重写
    return nil;
}

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionMgr) {
        NSURLSessionConfiguration *config = [self sessionConfiguration];
        _sessionMgr = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
        _sessionMgr.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionMgr.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionMgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    }
    return _sessionMgr;
}

- (NSURLSessionConfiguration *)sessionConfiguration {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = [TNNetworkConfig sharedConfig].defaultTimeoutInterval;
    return config;
}

- (NSString *)baseURLForEnvironment:(TNServiceAPIEnvironment)environment {
    // 默认实现，子类可以重写
    switch (environment) {
        case TNServiceAPIEnvironmentDevelop:
            return @"https://api-dev.example.com";
        case TNServiceAPIEnvironmentStaging:
            return @"https://api-staging.example.com";
        case TNServiceAPIEnvironmentReleaseCandidate:
            return @"https://api-rc.example.com";
        case TNServiceAPIEnvironmentRelease:
            return @"https://api.example.com";
        default:
            return @"https://api.example.com";
    }
}

#pragma mark - 辅助方法
- (NSString *)urlStringWithMethodName:(NSString *)methodName {
    NSString *baseURLString = [self baseURLString];
    if ([baseURLString hasSuffix:@"/"]) {
        return [NSString stringWithFormat:@"%@%@", baseURLString, methodName];
    } else {
        return [NSString stringWithFormat:@"%@/%@", baseURLString, methodName];
    }
}

- (NSError *)errorWithCode:(NSInteger)code message:(NSString *)message {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    if (message) {
        userInfo[NSLocalizedDescriptionKey] = message;
    }
    return [NSError errorWithDomain:@"TNNetworkingErrorDomain" code:code userInfo:userInfo];
}

@end
