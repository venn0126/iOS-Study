//
//  TNCacheCenter.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import <Foundation/Foundation.h>
#import "TNURLResponse.h"


NS_ASSUME_NONNULL_BEGIN

@interface TNCacheCenter : NSObject

+ (instancetype)sharedInstance;

// 内存缓存
- (void)saveMemoryCacheWithResponse:(TNURLResponse *)response
                 serviceIdentifier:(NSString *)serviceIdentifier
                        methodName:(NSString *)methodName
                            params:(NSDictionary *)params;

- (nullable TNURLResponse *)fetchMemoryCacheWithServiceIdentifier:(NSString *)serviceIdentifier
                                                      methodName:(NSString *)methodName
                                                         params:(NSDictionary *)params;

// 磁盘缓存
- (void)saveDiskCacheWithResponse:(TNURLResponse *)response
               serviceIdentifier:(NSString *)serviceIdentifier
                      methodName:(NSString *)methodName
                          params:(NSDictionary *)params;

- (nullable TNURLResponse *)fetchDiskCacheWithServiceIdentifier:(NSString *)serviceIdentifier
                                                    methodName:(NSString *)methodName
                                                       params:(NSDictionary *)params;

// 清除缓存
- (void)cleanAllCache;
- (void)cleanMemoryCache;
- (void)cleanDiskCache;

@end

NS_ASSUME_NONNULL_END
