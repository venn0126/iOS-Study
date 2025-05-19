//
//  TNNetworkConfig.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import <Foundation/Foundation.h>
#import "TNNetworkingDefines.h"


NS_ASSUME_NONNULL_BEGIN

@interface TNNetworkConfig : NSObject

// 单例
+ (instancetype)sharedConfig;

// 全局配置
@property (nonatomic, assign) NSTimeInterval defaultTimeoutInterval;  // 默认 20.0
@property (nonatomic, assign) TNServiceAPIEnvironment defaultEnvironment;
@property (nonatomic, assign) BOOL enableDebugLog;
@property (nonatomic, assign) BOOL enableNetworkActivityIndicator;

// 全局缓存配置
@property (nonatomic, assign) NSUInteger maxMemoryCacheSize;  // 默认 20MB
@property (nonatomic, assign) NSUInteger maxDiskCacheSize;    // 默认 100MB
@property (nonatomic, copy) NSString *diskCachePath;

// 全局重试配置
@property (nonatomic, assign) NSUInteger defaultMaxRetryCount;  // 默认 3
@property (nonatomic, assign) NSTimeInterval defaultRetryInterval;  // 默认 2.0
@property (nonatomic, assign) TNAPIManagerRetryPolicy defaultRetryPolicy;

// 安全配置
@property (nonatomic, assign) BOOL validatesDomainName;
@property (nonatomic, strong, nullable) NSArray<NSData *> *pinnedCertificates;

// 用户信息
@property (nonatomic, copy, nullable) NSString *userAgent;
@property (nonatomic, copy, nullable) NSString *(^tokenProvider)(void);

// 清除缓存
- (void)clearAllCache;
- (void)clearMemoryCache;
- (void)clearDiskCache;

@end

NS_ASSUME_NONNULL_END
