//
//  TNApiProxy.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import "TNApiProxy.h"
#import "TNServiceFactory.h"
#import "TNLogger.h"
#import "NSURLRequest+TNAdditions.h"
#import "NSString+TNAdditions.h"
#import "TNNetworkConfig.h"
#import <AFNetworking/AFNetworking.h>

@interface TNApiProxy ()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;

@end

@implementation TNApiProxy

#pragma mark - 懒加载
- (NSMutableDictionary *)dispatchTable {
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)sessionManagerWithService:(id<TNServiceProtocol>)service {
    AFHTTPSessionManager *sessionManager = nil;
    if ([service respondsToSelector:@selector(sessionManager)]) {
        sessionManager = service.sessionManager;
    }
    if (sessionManager == nil) {
        sessionManager = [AFHTTPSessionManager manager];
        
        // 配置默认超时时间
        sessionManager.requestSerializer.timeoutInterval = [TNNetworkConfig sharedConfig].defaultTimeoutInterval;
        
        // 配置安全策略
        if ([TNNetworkConfig sharedConfig].validatesDomainName) {
            sessionManager.securityPolicy.validatesDomainName = YES;
        }
        
        if ([TNNetworkConfig sharedConfig].pinnedCertificates) {
            sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
            sessionManager.securityPolicy.pinnedCertificates = [NSSet setWithArray:[TNNetworkConfig sharedConfig].pinnedCertificates];
        }
    }
    return sessionManager;
}

#pragma mark - 生命周期
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static TNApiProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TNApiProxy alloc] init];
    });
    return sharedInstance;
}

#pragma mark - 公共方法
- (void)cancelRequestWithRequestID:(NSNumber *)requestID {
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray<NSNumber *> *)requestIDList {
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(TNCallback)success fail:(TNCallback)fail {
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [[self sessionManagerWithService:request.service] dataTaskWithRequest:request
                                         uploadProgress:nil
                                       downloadProgress:nil
                                      completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        
        NSDictionary *result = [request.service resultWithResponseObject:responseObject
                                                               response:response
                                                                request:request
                                                                  error:&error];
        
        // 输出返回数据
        TNURLResponse *tResponse = [[TNURLResponse alloc] initWithResponseString:result[kTNApiProxyValidateResultKeyResponseString]
                                                                      requestId:requestID
                                                                        request:request
                                                                 responseObject:result[kTNApiProxyValidateResultKeyResponseObject]
                                                                          error:error];
        
        tResponse.logString = [TNLogger logDebugInfoWithResponse:(NSHTTPURLResponse *)response
                                                  responseObject:responseObject
                                                  responseString:result[kTNApiProxyValidateResultKeyResponseString]
                                                         request:request
                                                           error:error];
        
        if (error) {
            fail ? fail(tResponse) : nil;
        } else {
            success ? success(tResponse) : nil;
        }
    }];
    
    NSNumber *requestId = @([dataTask taskIdentifier]);
    
    self.dispatchTable[requestId] = dataTask;
    [dataTask resume];
    
    return requestId;
}

- (NSArray<NSNumber *> *)callApiBatchWithRequests:(NSArray<NSURLRequest *> *)requests success:(TNCallback)success fail:(TNCallback)fail {
    if (requests.count == 0) {
        return @[];
    }
    
    NSMutableArray<NSNumber *> *requestIds = [NSMutableArray arrayWithCapacity:requests.count];
    
    // 创建一个调度组
    dispatch_group_t group = dispatch_group_create();
    
    // 用于存储所有响应
    __block NSMutableArray *responses = [NSMutableArray arrayWithCapacity:requests.count];
    
    // 标记是否有任何请求失败
    __block BOOL hasError = NO;
    __block TNURLResponse *firstErrorResponse = nil;
    
    for (NSURLRequest *request in requests) {
        dispatch_group_enter(group);
        
        NSNumber *requestId = [self callApiWithRequest:request success:^(TNURLResponse *response) {
            @synchronized (responses) {
                [responses addObject:response];
            }
            dispatch_group_leave(group);
        } fail:^(TNURLResponse *response) {
            @synchronized (responses) {
                [responses addObject:response];
                if (!hasError) {
                    hasError = YES;
                    firstErrorResponse = response;
                }
            }
            dispatch_group_leave(group);
        }];
        
        [requestIds addObject:requestId];
    }
    
    // 所有请求完成后的回调
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (hasError) {
            fail ? fail(firstErrorResponse) : nil;
        } else {
            // 创建一个组合响应
            TNURLResponse *combinedResponse = [[TNURLResponse alloc] initWithResponseString:@"批量请求成功"
                                                                               requestId:nil
                                                                                 request:nil
                                                                          responseObject:responses
                                                                                   error:nil];
            success ? success(combinedResponse) : nil;
        }
    });
    
    return requestIds;
}


@end
