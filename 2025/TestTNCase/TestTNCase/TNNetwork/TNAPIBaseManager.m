//
//  TNAPIBaseManager.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import "TNAPIBaseManager.h"
#import "TNNetworking.h"
#import "TNCacheCenter.h"
#import "TNLogger.h"
#import "TNServiceFactory.h"
#import "TNApiProxy.h"
#import "TNReachability.h"


// 常量定义
NSString * const kTNAPIBaseManagerRequestID = @"kTNAPIBaseManagerRequestID";
NSString * const kTNUserTokenInvalidNotification = @"kTNUserTokenInvalidNotification";
NSString * const kTNUserTokenIllegalNotification = @"kTNUserTokenIllegalNotification";
NSString * const kTNUserTokenNotificationUserInfoKeyManagerToContinue = @"kTNUserTokenNotificationUserInfoKeyManagerToContinue";
NSString * const kTNApiProxyValidateResultKeyResponseObject = @"kTNApiProxyValidateResultKeyResponseObject";
NSString * const kTNApiProxyValidateResultKeyResponseString = @"kTNApiProxyValidateResultKeyResponseString";

@interface TNAPIBaseManager ()

@property (nonatomic, strong, readwrite) id fetchedRawData;
@property (nonatomic, assign, readwrite) BOOL isLoading;
@property (nonatomic, copy, readwrite, nullable) NSString *errorMessage;
@property (nonatomic, strong, readwrite) TNURLResponse *response;
@property (nonatomic, readwrite) TNAPIManagerErrorType errorType;
@property (nonatomic, strong) NSMutableArray *requestIdList;
@property (nonatomic, assign) NSUInteger retryCount;

@property (nonatomic, strong, nullable) void (^successBlock)(TNAPIBaseManager *apimanager);
@property (nonatomic, strong, nullable) void (^failBlock)(TNAPIBaseManager *apimanager);

@end

@implementation TNAPIBaseManager

#pragma mark - 生命周期
- (instancetype)init {
    self = [super init];
    if (self) {
        _delegate = nil;
        _validator = nil;
        _paramSource = nil;
        
        _fetchedRawData = nil;
        
        _errorMessage = nil;
        _errorType = TNAPIManagerErrorTypeDefault;

        _memoryCacheSecond = 3 * 60;
        _diskCacheSecond = 3 * 60;
        _shouldIgnoreCache = NO;
        
        _retryPolicy = TNAPIManagerRetryPolicyNone;
        _maxRetryCount = 3;
        _retryInterval = 2.0;
        _retryCount = 0;
        
        if ([self conformsToProtocol:@protocol(TNAPIManager)]) {
            self.child = (id <TNAPIManager>)self;
        } else {
            NSException *exception = [[NSException alloc] initWithName:@"TNAPIManagerException"
                                                               reason:@"子类必须实现TNAPIManager协议"
                                                             userInfo:nil];
            @throw exception;
        }
    }
    return self;
}

- (void)dealloc {
    [self cancelAllRequests];
    self.requestIdList = nil;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark - 公共方法
- (void)cancelAllRequests {
    [[TNApiProxy sharedInstance] cancelRequestWithRequestIDList:self.requestIdList];
    [self.requestIdList removeAllObjects];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestID {
    [self removeRequestIdWithRequestID:requestID];
    [[TNApiProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
}

- (id)fetchDataWithReformer:(id<TNAPIManagerDataReformer>)reformer {
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    } else {
        resultData = [self.fetchedRawData mutableCopy];
    }
    return resultData;
}

#pragma mark - 调用API
- (NSInteger)loadData {
    NSDictionary *params = [self.paramSource paramsForApi:self];
    NSInteger requestId = [self loadDataWithParams:params];
    return requestId;
}

+ (NSInteger)loadDataWithParams:(NSDictionary *)params success:(void (^)(TNAPIBaseManager *))successCallback fail:(void (^)(TNAPIBaseManager *))failCallback {
    return [[[self alloc] init] loadDataWithParams:params success:successCallback fail:failCallback];
}

- (NSInteger)loadDataWithParams:(NSDictionary *)params success:(void (^)(TNAPIBaseManager *))successCallback fail:(void (^)(TNAPIBaseManager *))failCallback {
    self.successBlock = successCallback;
    self.failBlock = failCallback;
    
    return [self loadDataWithParams:params];
}

- (NSInteger)loadDataWithParams:(NSDictionary *)params {
    NSInteger requestId = 0;
    NSDictionary *reformedParams = [self reformParams:params];
    if (reformedParams == nil) {
        reformedParams = @{};
    }
    
    if ([self shouldCallAPIWithParams:reformedParams]) {
        TNAPIManagerErrorType errorType = [self.validator manager:self isCorrectWithParamsData:reformedParams];
        if (errorType == TNAPIManagerErrorTypeNoError) {
            
            TNURLResponse *response = nil;
            // 先检查一下是否有内存缓存
            if ((self.cachePolicy & TNAPIManagerCachePolicyMemory) && self.shouldIgnoreCache == NO) {
                response = [[TNCacheCenter sharedInstance] fetchMemoryCacheWithServiceIdentifier:self.child.serviceIdentifier
                                                                                   methodName:self.child.methodName
                                                                                      params:reformedParams];
            }
            
            // 再检查是否有磁盘缓存
            if (response == nil && (self.cachePolicy & TNAPIManagerCachePolicyDisk) && self.shouldIgnoreCache == NO) {
                response = [[TNCacheCenter sharedInstance] fetchDiskCacheWithServiceIdentifier:self.child.serviceIdentifier
                                                                                 methodName:self.child.methodName
                                                                                    params:reformedParams];
            }
            
            if (response != nil) {
                [self successedOnCallingAPI:response];
                return 0;
            }
            
            // 实际的网络请求
            if ([self isReachable]) {
                self.isLoading = YES;
                
                id <TNServiceProtocol> service = [[TNServiceFactory sharedInstance] serviceWithIdentifier:self.child.serviceIdentifier];
                NSURLRequest *request = [service requestWithParams:reformedParams
                                                       methodName:self.child.methodName
                                                      requestType:self.child.requestType];
                
                if ([request valueForKey:@"service"] == nil) {
                    [request setValue:service forKey:@"service"];
                }
                
                [TNLogger logDebugInfoWithRequest:request apiName:self.child.methodName service:service];
                
                __weak typeof(self) weakSelf = self;
                NSNumber *requestId = [[TNApiProxy sharedInstance] callApiWithRequest:request success:^(TNURLResponse *response) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    [strongSelf successedOnCallingAPI:response];
                } fail:^(TNURLResponse *response) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    
                    // 处理重试逻辑
                    BOOL shouldRetry = NO;
                    if (strongSelf.retryCount < strongSelf.maxRetryCount) {
                        if ((strongSelf.retryPolicy & TNAPIManagerRetryPolicyOnNetworkError) &&
                            response.status == TNURLResponseStatusErrorNoNetwork) {
                            shouldRetry = YES;
                        } else if ((strongSelf.retryPolicy & TNAPIManagerRetryPolicyOnTimeout) &&
                                  response.status == TNURLResponseStatusErrorTimeout) {
                            shouldRetry = YES;
                        } else if ((strongSelf.retryPolicy & TNAPIManagerRetryPolicyOnServerError) &&
                                  response.status == TNURLResponseStatusErrorResponse) {
                            shouldRetry = YES;
                        }
                    }
                    
                    if (shouldRetry) {
                        strongSelf.retryCount++;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(strongSelf.retryInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [strongSelf loadDataWithParams:reformedParams];
                        });
                    } else {
                        strongSelf.retryCount = 0;
                        
                        TNAPIManagerErrorType errorType = TNAPIManagerErrorTypeDefault;
                        if (response.status == TNURLResponseStatusErrorTimeout) {
                            errorType = TNAPIManagerErrorTypeTimeout;
                        } else if (response.status == TNURLResponseStatusErrorNoNetwork) {
                            errorType = TNAPIManagerErrorTypeNoNetWork;
                        } else if (response.status == TNURLResponseStatusErrorCancel) {
                            errorType = TNAPIManagerErrorTypeCanceled;
                        }
                        
                        [strongSelf failedOnCallingAPI:response withErrorType:errorType];
                    }
                }];
                
                [self.requestIdList addObject:requestId];
                
                NSMutableDictionary *params = [reformedParams mutableCopy];
                params[kTNAPIBaseManagerRequestID] = requestId;
                [self afterCallingAPIWithParams:params];
                return [requestId integerValue];
                
            } else {
                [self failedOnCallingAPI:nil withErrorType:TNAPIManagerErrorTypeNoNetWork];
                return requestId;
            }
        } else {
            [self failedOnCallingAPI:nil withErrorType:errorType];
            return requestId;
        }
    }
    return requestId;
}

#pragma mark - API回调
- (void)successedOnCallingAPI:(TNURLResponse *)response {
    self.isLoading = NO;
    self.response = response;
    
    if (response.status == TNURLResponseStatusSuccess) {
        self.fetchedRawData = response.responseObject;
        
        TNAPIManagerErrorType errorType = [self.validator manager:self isCorrectWithCallBackData:response.responseObject];
        if (errorType == TNAPIManagerErrorTypeNoError) {
            // 缓存处理
            if (self.cachePolicy != TNAPIManagerCachePolicyNoCache && !self.shouldIgnoreCache) {
                if (self.cachePolicy & TNAPIManagerCachePolicyMemory) {
                    [[TNCacheCenter sharedInstance] saveMemoryCacheWithResponse:response
                                                            serviceIdentifier:self.child.serviceIdentifier
                                                                   methodName:self.child.methodName
                                                                       params:[self.paramSource paramsForApi:self]];
                }
                
                if (self.cachePolicy & TNAPIManagerCachePolicyDisk) {
                    [[TNCacheCenter sharedInstance] saveDiskCacheWithResponse:response
                                                          serviceIdentifier:self.child.serviceIdentifier
                                                                 methodName:self.child.methodName
                                                                     params:[self.paramSource paramsForApi:self]];
                }
            }
            
            if ([self beforePerformSuccessWithResponse:response]) {
                self.errorType = TNAPIManagerErrorTypeSuccess;
                [self.delegate managerCallAPIDidSuccess:self];
                if (self.successBlock) {
                    self.successBlock(self);
                }
                [self afterPerformSuccessWithResponse:response];
            }
        } else {
            [self failedOnCallingAPI:response withErrorType:errorType];
        }
    } else {
        [self failedOnCallingAPI:response withErrorType:TNAPIManagerErrorTypeDefault];
    }
}

- (void)failedOnCallingAPI:(TNURLResponse *)response withErrorType:(TNAPIManagerErrorType)errorType {
    self.isLoading = NO;
    if (response) {
        self.response = response;
    }
    
    self.errorType = errorType;
    
    // 处理通用错误
    BOOL shouldContinue = YES;
    if (self.child.serviceIdentifier && response) {
        id<TNServiceProtocol> service = [[TNServiceFactory sharedInstance] serviceWithIdentifier:self.child.serviceIdentifier];
        if ([service respondsToSelector:@selector(handleCommonErrorWithResponse:manager:errorType:)]) {
            shouldContinue = [service handleCommonErrorWithResponse:response manager:self errorType:errorType];
        }
    }
    
    if (shouldContinue) {
        if ([self beforePerformFailWithResponse:response]) {
            if (self.errorType == TNAPIManagerErrorTypeNoNetWork) {
                self.errorMessage = @"网络连接失败，请检查网络";
            } else if (self.errorType == TNAPIManagerErrorTypeTimeout) {
                self.errorMessage = @"请求超时，请稍后再试";
            } else if (self.errorType == TNAPIManagerErrorTypeNoContent) {
                self.errorMessage = @"返回内容为空";
            } else if (self.errorType == TNAPIManagerErrorTypeNeedLogin) {
                self.errorMessage = @"需要登录";
            } else {
                self.errorMessage = @"请求失败，请稍后再试";
            }
            
            [self.delegate managerCallAPIDidFailed:self];
            if (self.failBlock) {
                self.failBlock(self);
            }
            [self afterPerformFailWithResponse:response];
        }
    }
}

#pragma mark - 私有方法
- (void)removeRequestIdWithRequestID:(NSInteger)requestId {
    NSNumber *requestIDToRemove = nil;
    for (NSNumber *storedRequestId in self.requestIdList) {
        if ([storedRequestId integerValue] == requestId) {
            requestIDToRemove = storedRequestId;
            break;
        }
    }
    if (requestIDToRemove) {
        [self.requestIdList removeObject:requestIDToRemove];
    }
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    // 1. 首先检查 child 是否为 nil
    if (self.child == nil) {
        return params;
    }
    
    // 2. 检查是否支持 reformParams: 方法
    if (![self.child respondsToSelector:@selector(reformParams:)]) {
        return params;
    }
    
    // 3. 通过比较 IMP 防止循环调用
    IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
    IMP selfIMP = [self methodForSelector:@selector(reformParams:)];
    
    if (childIMP == selfIMP) {
        return params;
    }
    
    // 4. 调用 child 的 reformParams: 方法并检查结果
    NSDictionary *result = [self.child reformParams:params];
    return result ?: params;
}

- (BOOL)isReachable {
    return [[TNReachability sharedInstance] isReachable];
}

- (NSMutableArray *)requestIdList {
    if (_requestIdList == nil) {
        _requestIdList = [[NSMutableArray alloc] init];
    }
    return _requestIdList;
}

- (void)cleanData {
    self.fetchedRawData = nil;
    self.errorMessage = nil;
    self.errorType = TNAPIManagerErrorTypeDefault;
    if ([self.child respondsToSelector:@selector(cleanData)]) {
        [self.child cleanData];
    }
}

@end

@implementation TNAPIBaseManager (InnerInterceptor)

- (BOOL)beforePerformSuccessWithResponse:(TNURLResponse *)response {
    if ((NSInteger)self != (NSInteger)self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforePerformSuccessWithResponse:)]) {
        return [self.interceptor manager:self beforePerformSuccessWithResponse:response];
    }
    return YES;
}

- (void)afterPerformSuccessWithResponse:(TNURLResponse *)response {
    if ((NSInteger)self != (NSInteger)self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformSuccessWithResponse:)]) {
        [self.interceptor manager:self afterPerformSuccessWithResponse:response];
    }
}

- (BOOL)beforePerformFailWithResponse:(TNURLResponse *)response {
    if ((NSInteger)self != (NSInteger)self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforePerformFailWithResponse:)]) {
        return [self.interceptor manager:self beforePerformFailWithResponse:response];
    }
    return YES;
}

- (void)afterPerformFailWithResponse:(TNURLResponse *)response {
    if ((NSInteger)self != (NSInteger)self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformFailWithResponse:)]) {
        [self.interceptor manager:self afterPerformFailWithResponse:response];
    }
}

- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params {
    if ((NSInteger)self != (NSInteger)self.interceptor && [self.interceptor respondsToSelector:@selector(manager:shouldCallAPIWithParams:)]) {
        return [self.interceptor manager:self shouldCallAPIWithParams:params];
    }
    return YES;
}

- (void)afterCallingAPIWithParams:(NSDictionary *)params {
    if ((NSInteger)self != (NSInteger)self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterCallingAPIWithParams:)]) {
        [self.interceptor manager:self afterCallingAPIWithParams:params];
    }
}

@end
