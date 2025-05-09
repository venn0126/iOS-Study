//
//  TNReachability.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import "TNReachability.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>

NSString * const TNReachabilityDidChangeNotification = @"TNReachabilityDidChangeNotification";
NSString * const TNReachabilityNotificationStatusKey = @"TNReachabilityNotificationStatusKey";

@interface TNReachability ()

@property (nonatomic, strong) AFNetworkReachabilityManager *reachabilityManager;
@property (nonatomic, assign) TNNetworkStatus networkStatus;

@end

@implementation TNReachability

+ (instancetype)sharedInstance {
    static TNReachability *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _reachabilityManager = [AFNetworkReachabilityManager manager];
        _networkStatus = TNNetworkStatusUnknown;
        
        __weak typeof(self) weakSelf = self;
        [_reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            [weakSelf updateNetworkStatus:status];
        }];
    }
    return self;
}

- (void)startMonitoring {
    [self.reachabilityManager startMonitoring];
}

- (void)stopMonitoring {
    [self.reachabilityManager stopMonitoring];
}

- (BOOL)isReachable {
    return self.reachabilityManager.isReachable;
}

- (BOOL)isReachableViaWWAN {
    return self.reachabilityManager.isReachableViaWWAN;
}

- (BOOL)isReachableViaWiFi {
    return self.reachabilityManager.isReachableViaWiFi;
}

#pragma mark - 私有方法
- (void)updateNetworkStatus:(AFNetworkReachabilityStatus)status {
    TNNetworkStatus networkStatus;
    switch (status) {
        case AFNetworkReachabilityStatusUnknown:
            networkStatus = TNNetworkStatusUnknown;
            break;
        case AFNetworkReachabilityStatusNotReachable:
            networkStatus = TNNetworkStatusNotReachable;
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            networkStatus = TNNetworkStatusReachableViaWWAN;
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            networkStatus = TNNetworkStatusReachableViaWiFi;
            break;
    }
    
    _networkStatus = networkStatus;
    
    // 发送网络状态变化通知
    [[NSNotificationCenter defaultCenter] postNotificationName:TNReachabilityDidChangeNotification
                                                        object:nil
                                                      userInfo:@{TNReachabilityNotificationStatusKey: @(networkStatus)}];
}



@end
