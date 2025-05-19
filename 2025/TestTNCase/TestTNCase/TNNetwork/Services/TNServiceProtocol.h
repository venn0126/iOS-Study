//
//  TNServiceProtocol.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import <Foundation/Foundation.h>
#import "TNNetworkingDefines.h"
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@class TNAPIBaseManager;
@class TNURLResponse;

@protocol TNServiceProtocol <NSObject>

@property (nonatomic, assign) TNServiceAPIEnvironment apiEnvironment;

// 请求创建
- (NSURLRequest *)requestWithParams:(nullable NSDictionary *)params
                         methodName:(NSString *)methodName
                        requestType:(TNAPIManagerRequestType)requestType;

// 响应处理
- (NSDictionary *)resultWithResponseObject:(nullable id)responseObject
                                  response:(nullable NSURLResponse *)response
                                   request:(nullable NSURLRequest *)request
                                     error:(NSError **)error;

// 错误处理
- (BOOL)handleCommonErrorWithResponse:(TNURLResponse *)response
                              manager:(TNAPIBaseManager *)manager
                            errorType:(TNAPIManagerErrorType)errorType;

// 可选方法
@optional
- (AFHTTPSessionManager *)sessionManager;
- (NSDictionary *)commonHeaders;
- (NSDictionary *)commonParams;
- (NSString *)baseURLForEnvironment:(TNServiceAPIEnvironment)environment;
- (BOOL)shouldEnableDebugLog;

@end

NS_ASSUME_NONNULL_END
