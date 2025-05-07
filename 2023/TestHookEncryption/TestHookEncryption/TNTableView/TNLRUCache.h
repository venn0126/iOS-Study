//
//  TNLRUCache.h
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// LRU 缓存实现
@interface TNLRUCache : NSObject

@property (nonatomic, assign) NSUInteger countLimit;  // 缓存对象数量限制
@property (nonatomic, assign) NSUInteger costLimit;   // 缓存成本限制

+ (instancetype)sharedCache;

- (id)objectForKey:(id)key;
- (void)setObject:(id)object forKey:(id)key cost:(NSUInteger)cost;
- (void)removeObjectForKey:(id)key;
- (void)removeAllObjects;

@end

NS_ASSUME_NONNULL_END
