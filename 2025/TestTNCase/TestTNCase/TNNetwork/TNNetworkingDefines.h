//
//  TNNetworkingDefines.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#ifndef TNNetworkingDefines_h
#define TNNetworkingDefines_h

NS_ASSUME_NONNULL_BEGIN

@class TNAPIBaseManager;
@class TNURLResponse;

// 服务环境
typedef NS_ENUM(NSUInteger, TNServiceAPIEnvironment) {
    TNServiceAPIEnvironmentDevelop,        // 开发环境
    TNServiceAPIEnvironmentStaging,        // 测试环境
    TNServiceAPIEnvironmentReleaseCandidate, // 预发布环境
    TNServiceAPIEnvironmentRelease         // 生产环境
};

// 请求方法
typedef NS_ENUM(NSUInteger, TNAPIManagerRequestType) {
    TNAPIManagerRequestTypeGet,
    TNAPIManagerRequestTypePost,
    TNAPIManagerRequestTypePut,
    TNAPIManagerRequestTypeDelete,
    TNAPIManagerRequestTypePatch,
    TNAPIManagerRequestTypeHead
};

// 错误类型
typedef NS_ENUM(NSUInteger, TNAPIManagerErrorType) {
    TNAPIManagerErrorTypeNoError,           // 无错误
    TNAPIManagerErrorTypeDefault,           // 默认错误
    TNAPIManagerErrorTypeNeedAccessToken,   // 需要刷新访问令牌
    TNAPIManagerErrorTypeNeedLogin,         // 需要登录
    TNAPIManagerErrorTypeLoginCanceled,     // 登录取消
    TNAPIManagerErrorTypeSuccess,           // 请求成功
    TNAPIManagerErrorTypeNoContent,         // 无内容
    TNAPIManagerErrorTypeParamsError,       // 参数错误
    TNAPIManagerErrorTypeTimeout,           // 超时
    TNAPIManagerErrorTypeNoNetWork,         // 无网络
    TNAPIManagerErrorTypeCanceled,          // 请求取消
    TNAPIManagerErrorTypeDownGrade,         // 降级
    TNAPIManagerErrorTypeServerError        // 服务器错误
};

// 缓存策略
typedef NS_OPTIONS(NSUInteger, TNAPIManagerCachePolicy) {
    TNAPIManagerCachePolicyNoCache = 0,           // 不缓存
    TNAPIManagerCachePolicyMemory = 1 << 0,       // 内存缓存
    TNAPIManagerCachePolicyDisk = 1 << 1,         // 磁盘缓存
    TNAPIManagerCachePolicyOffline = 1 << 2,      // 离线缓存
    TNAPIManagerCachePolicyForceRefresh = 1 << 3, // 强制刷新
    TNAPIManagerCachePolicyBackground = 1 << 4    // 后台刷新
};

// 重试策略
typedef NS_OPTIONS(NSUInteger, TNAPIManagerRetryPolicy) {
    TNAPIManagerRetryPolicyNone = 0,              // 不重试
    TNAPIManagerRetryPolicyOnNetworkError = 1 << 0, // 网络错误重试
    TNAPIManagerRetryPolicyOnTimeout = 1 << 1,    // 超时重试
    TNAPIManagerRetryPolicyOnServerError = 1 << 2 // 服务器错误重试
};

// 常量定义
extern NSString *  const kTNAPIBaseManagerRequestID;
/// 用户登录token无效
extern NSString *  const kTNUserTokenInvalidNotification;
/// 用户登录token非法
extern NSString *  const kTNUserTokenIllegalNotification;
/// 用户需要再次登录
extern NSString *  const kTNUserTokenNotificationUserInfoKeyManagerToContinue;
/// 验证响应结果的对象
extern NSString *  const kTNApiProxyValidateResultKeyResponseObject;
//// 验证响应的字符串
extern NSString *  const kTNApiProxyValidateResultKeyResponseString;

// API管理协议
@protocol TNAPIManager <NSObject>

@required
- (NSString *)methodName;
- (NSString *)serviceIdentifier;
- (TNAPIManagerRequestType)requestType;

@optional
- (void)cleanData;
- (NSDictionary *_Nullable)reformParams:(NSDictionary *_Nullable)params;
- (NSInteger)loadDataWithParams:(NSDictionary *_Nullable)params;

@end

// API拦截器协议
@protocol TNAPIManagerInterceptor <NSObject>

@optional
- (BOOL)manager:(TNAPIBaseManager *)manager beforePerformSuccessWithResponse:(TNURLResponse *)response;
- (void)manager:(TNAPIBaseManager *)manager afterPerformSuccessWithResponse:(TNURLResponse *)response;
- (BOOL)manager:(TNAPIBaseManager *)manager beforePerformFailWithResponse:(TNURLResponse *)response;
- (void)manager:(TNAPIBaseManager *)manager afterPerformFailWithResponse:(TNURLResponse *)response;
- (BOOL)manager:(TNAPIBaseManager *)manager shouldCallAPIWithParams:(NSDictionary *_Nullable)params;
- (void)manager:(TNAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *_Nullable)params;
- (void)manager:(TNAPIBaseManager *)manager didReceiveResponse:(TNURLResponse *_Nullable)response;

@end

// 回调代理协议
@protocol TNAPIManagerCallBackDelegate <NSObject>

@required
- (void)managerCallAPIDidSuccess:(TNAPIBaseManager * )manager;
- (void)managerCallAPIDidFailed:(TNAPIBaseManager * )manager;

@end

// 分页协议
@protocol TNPagableAPIManager <NSObject>

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign, readonly) NSUInteger currentPageNumber;
@property (nonatomic, assign, readonly) BOOL isFirstPage;
@property (nonatomic, assign, readonly) BOOL isLastPage;
@property (nonatomic, assign, readonly) NSUInteger totalCount;

- (void)loadNextPage;
- (void)resetToFirstPage;

@end

// 数据重构协议
@protocol TNAPIManagerDataReformer <NSObject>

@required
- (id _Nullable)manager:(TNAPIBaseManager * )manager reformData:(NSDictionary * _Nullable)data;

@end

// 数据验证协议
@protocol TNAPIManagerValidator <NSObject>

@required
- (TNAPIManagerErrorType)manager:(TNAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *_Nullable)data;
- (TNAPIManagerErrorType)manager:(TNAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *_Nullable)data;

@end

// 参数源协议
@protocol TNAPIManagerParamSource <NSObject>

@required
- (NSDictionary *_Nullable)paramsForApi:(TNAPIBaseManager *)manager;

@end

NS_ASSUME_NONNULL_END


#endif /* TNNetworkingDefines_h */
