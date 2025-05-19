//
//  TNReachability.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TNNetworkStatus) {
    TNNetworkStatusUnknown,
    TNNetworkStatusNotReachable,
    TNNetworkStatusReachableViaWWAN,
    TNNetworkStatusReachableViaWiFi
};

@interface TNReachability : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, readonly) BOOL isReachable;
@property (nonatomic, readonly) BOOL isReachableViaWWAN;
@property (nonatomic, readonly) BOOL isReachableViaWiFi;
@property (nonatomic, readonly) TNNetworkStatus networkStatus;

// 开始监听网络状态
- (void)startMonitoring;
- (void)stopMonitoring;

// 网络状态变化通知
extern NSString * const TNReachabilityDidChangeNotification;
extern NSString * const TNReachabilityNotificationStatusKey;


@end

NS_ASSUME_NONNULL_END
