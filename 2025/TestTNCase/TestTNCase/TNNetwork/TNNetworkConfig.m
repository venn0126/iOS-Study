//
//  TNNetworkConfig.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import "TNNetworkConfig.h"
#import "TNCacheCenter.h"


@implementation TNNetworkConfig

+ (instancetype)sharedConfig {
    static TNNetworkConfig *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 默认配置
        _defaultTimeoutInterval = 20.0;
        _defaultEnvironment = TNServiceAPIEnvironmentDevelop;
        _enableDebugLog = YES;
        _enableNetworkActivityIndicator = YES;
        
        // 缓存配置
        _maxMemoryCacheSize = 20 * 1024 * 1024; // 20MB
        _maxDiskCacheSize = 100 * 1024 * 1024;  // 100MB
        _diskCachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"TNNetworkCache"];
        
        // 重试配置
        _defaultMaxRetryCount = 3;
        _defaultRetryInterval = 2.0;
        _defaultRetryPolicy = TNAPIManagerRetryPolicyOnNetworkError | TNAPIManagerRetryPolicyOnTimeout;
        
        // 安全配置
        _validatesDomainName = YES;
        _pinnedCertificates = nil;
        
        // 用户信息
        _userAgent = [NSString stringWithFormat:@"TNNetworking/%@", @"1.0.0"];
        _tokenProvider = nil;
    }
    return self;
}

- (void)clearAllCache {
    [[TNCacheCenter sharedInstance] cleanAllCache];
}

- (void)clearMemoryCache {
    [[TNCacheCenter sharedInstance] cleanMemoryCache];
}

- (void)clearDiskCache {
    [[TNCacheCenter sharedInstance] cleanDiskCache];
}

@end
