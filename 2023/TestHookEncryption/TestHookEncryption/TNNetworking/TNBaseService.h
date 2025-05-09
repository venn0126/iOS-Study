//
//  TNBaseService.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import <Foundation/Foundation.h>
#import "TNServiceProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface TNBaseService : NSObject

// 服务环境
@property (nonatomic, assign) TNServiceAPIEnvironment apiEnvironment;

// 初始化方法
- (instancetype)initWithBaseURL:(NSString *)baseURL;

// 子类可重写的方法
- (NSString *)baseURLString;
- (NSDictionary *)commonHeaders;
- (NSDictionary *)commonParams;
- (AFHTTPSessionManager *)sessionManager;
- (NSURLSessionConfiguration *)sessionConfiguration;
- (NSString *)baseURLForEnvironment:(TNServiceAPIEnvironment)environment;


// 辅助方法
- (NSString *)urlStringWithMethodName:(NSString *)methodName;
- (NSError *)errorWithCode:(NSInteger)code message:(NSString *)message;


@end

NS_ASSUME_NONNULL_END
