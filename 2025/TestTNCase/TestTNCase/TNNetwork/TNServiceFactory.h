//
//  TNServiceFactory.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import <Foundation/Foundation.h>
#import "TNServiceProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface TNServiceFactory : NSObject

+ (instancetype)sharedInstance;

// 获取服务
- (nullable id<TNServiceProtocol>)serviceWithIdentifier:(NSString *)identifier;

// 注册服务
- (void)registerService:(id<TNServiceProtocol>)service withIdentifier:(NSString *)identifier;

// 移除服务
- (void)removeServiceWithIdentifier:(NSString *)identifier;


@end

NS_ASSUME_NONNULL_END
