//
//  TNHomeService.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/15.
//

#import "TNHomeService.h"

@interface TNHomeService ()

@property (nonatomic, strong) NSString *publicKey;
@property (nonatomic, strong) NSString *privateKey;
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation TNHomeService


// 请求创建
- (NSURLRequest *)requestWithParams:(nullable NSDictionary *)params
                         methodName:(NSString *)methodName
                        requestType:(TNAPIManagerRequestType)requestType {
    if (requestType == TNAPIManagerRequestTypeGet) {
        NSString *urlString = [NSString stringWithFormat:@"%@/%@", [self baseURLString], methodName];
        NSString *tsString = [NSUUID UUID].UUIDString;
        NSString *md5Hash = [[NSString stringWithFormat:@"%@%@%@", tsString, self.privateKey, self.publicKey] tn_md5];
        NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET"
                                                                           URLString:urlString
                                                                          parameters:@{
                                                                                       @"apikey":self.publicKey,
                                                                                       @"ts":tsString,
                                                                                       @"hash":md5Hash
                                                                                       }
                                                                               error:nil];
        return request;
    }

    return nil;
}

// 响应处理
- (NSDictionary *)resultWithResponseObject:(nullable id)responseObject
                                  response:(nullable NSURLResponse *)response
                                   request:(nullable NSURLRequest *)request
                                     error:(NSError **)error {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    if (*error || !responseObject) {
        return result;
    }
    
    if ([responseObject isKindOfClass:[NSData class]]) {
        result[kTNApiProxyValidateResultKeyResponseString] = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        result[kTNApiProxyValidateResultKeyResponseObject] = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
    } else {
        //这里的kTNApiProxyValidateResultKeyResponseString是用作打印日志用的，实际使用时可以把实际类型的对象转换成string用于日志打印
//        result[kTNApiProxyValidateResultKeyResponseObject] = responseObject;
        result[kTNApiProxyValidateResultKeyResponseObject] = responseObject;
    }
    
    return result;
}

// 错误处理
- (BOOL)handleCommonErrorWithResponse:(TNURLResponse *)response
                              manager:(TNAPIBaseManager *)manager
                            errorType:(TNAPIManagerErrorType)errorType {
    // 业务上这些错误码表示需要重新登录
    NSString *resCode = [NSString stringWithFormat:@"%@", response.data[@"resCode"]];
    if ([resCode isEqualToString:@"00100009"]
        || [resCode isEqualToString:@"05111001"]
        || [resCode isEqualToString:@"05111002"]
        || [resCode isEqualToString:@"1080002"]
        ) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTNUserTokenIllegalNotification
                                                            object:nil
                                                          userInfo:@{
            kTNUserTokenNotificationUserInfoKeyManagerToContinue:self
                                                                     }];
        return NO;
    }
    
    // 业务上这些错误码表示需要刷新token
    NSString *errorCode = [NSString stringWithFormat:@"%@", response.data[@"errorCode"]];
    if ([response.data[@"errorMsg"] isEqualToString:@"invalid token"]
        || [response.data[@"errorMsg"] isEqualToString:@"access_token is required"]
        || [errorCode isEqualToString:@"BL10015"]
        ) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTNUserTokenInvalidNotification
                                                            object:nil
                                                          userInfo:@{
            kTNUserTokenNotificationUserInfoKeyManagerToContinue:self
                                                                     }];
        return NO;
    }
    
    return YES;
}

- (NSString *)publicKey
{
    return @"123";
}

- (NSString *)privateKey
{
    return @"456";
}

- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        [_httpRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return _httpRequestSerializer;
}


#pragma mark - 可选方法

- (NSString *)baseURLForEnvironment:(TNServiceAPIEnvironment)environment {
    switch (environment) {
        case TNServiceAPIEnvironmentDevelop:
            return @"http://10.18.75.190:7700";
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

- (NSDictionary *)commonHeaders {
    return @{
        @"Content-Type": @"application/json",
        @"Accept": @"application/json",
        @"X-App-Version": @"1.0.0"
    };
}

- (NSDictionary *)commonParams {
    return @{
        @"platform": @"iOS",
        @"timestamp": @((NSInteger)[[NSDate date] timeIntervalSince1970])
    };
}

@end
