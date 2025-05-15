//
//  TNAPIBaseManager.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import <Foundation/Foundation.h>
#import "TNURLResponse.h"
#import "TNNetworkingDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface TNAPIBaseManager : NSObject


// 代理和数据源
@property (nonatomic, weak, nullable) id<TNAPIManagerCallBackDelegate> delegate;
@property (nonatomic, weak, nullable) id<TNAPIManagerParamSource> paramSource;
@property (nonatomic, weak, nullable) id<TNAPIManagerValidator> validator;
@property (nonatomic, weak, nullable) NSObject<TNAPIManager> *child;
@property (nonatomic, weak, nullable) id<TNAPIManagerInterceptor> interceptor;

// 缓存相关
@property (nonatomic, assign) TNAPIManagerCachePolicy cachePolicy;
@property (nonatomic, assign) NSTimeInterval memoryCacheSecond; // 默认 3 * 60
@property (nonatomic, assign) NSTimeInterval diskCacheSecond;   // 默认 3 * 60
@property (nonatomic, assign) BOOL shouldIgnoreCache;           // 默认 NO

// 重试相关
@property (nonatomic, assign) TNAPIManagerRetryPolicy retryPolicy;
@property (nonatomic, assign) NSUInteger maxRetryCount;         // 默认 3
@property (nonatomic, assign) NSTimeInterval retryInterval;     // 默认 2.0

// 响应相关
@property (nonatomic, strong, readonly) TNURLResponse *response;
@property (nonatomic, readonly) TNAPIManagerErrorType errorType;
@property (nonatomic, copy, readonly, nullable) NSString *errorMessage;

// 状态相关
@property (nonatomic, readonly, getter=isReachable) BOOL reachable;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;

// 请求方法
- (NSInteger)loadData;
- (NSInteger)loadDataWithParams:(nullable NSDictionary *)params;

// 批量请求
+ (NSInteger)loadDataWithParams:(nullable NSDictionary *)params
                        success:(nullable void (^)(TNAPIBaseManager *apiManager))successCallback
                           fail:(nullable void (^)(TNAPIBaseManager *apiManager))failCallback;

// 取消请求
- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestID;

// 数据处理
- (nullable id)fetchDataWithReformer:(nullable id<TNAPIManagerDataReformer>)reformer;
- (void)cleanData;


@end

// 内部拦截器分类
@interface TNAPIBaseManager (InnerInterceptor)

- (BOOL)beforePerformSuccessWithResponse:(nullable TNURLResponse *)response;
- (void)afterPerformSuccessWithResponse:(nullable TNURLResponse *)response;

- (BOOL)beforePerformFailWithResponse:(nullable TNURLResponse *)response;
- (void)afterPerformFailWithResponse:(nullable TNURLResponse *)response;

- (BOOL)shouldCallAPIWithParams:(nullable NSDictionary *)params;
- (void)afterCallingAPIWithParams:(nullable NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
