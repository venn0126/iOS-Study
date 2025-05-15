//
//  TNLRUCache.m
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import "TNLRUCache.h"
#import <UIKit/UIKit.h>

@implementation TNLRUCache{
    NSCache *_cache;
    dispatch_queue_t _queue;
}

+ (instancetype)sharedCache {
    static TNLRUCache *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = 100;  // 默认限制100个对象
        _cache.totalCostLimit = 1024 * 1024 * 10;  // 默认10MB
        
        _queue = dispatch_queue_create("com.tn.lrucache", DISPATCH_QUEUE_CONCURRENT);
        
        // 监听内存警告
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMemoryWarning)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setCountLimit:(NSUInteger)countLimit {
    _countLimit = countLimit;
    _cache.countLimit = countLimit;
}

- (void)setCostLimit:(NSUInteger)costLimit {
    _costLimit = costLimit;
    _cache.totalCostLimit = costLimit;
}

- (id)objectForKey:(id)key {
    __block id object = nil;
    dispatch_sync(_queue, ^{
        object = [self->_cache objectForKey:key];
    });
    return object;
}

- (void)setObject:(id)object forKey:(id)key cost:(NSUInteger)cost {
    if (!object || !key) return;
    
    dispatch_barrier_async(_queue, ^{
        [self->_cache setObject:object forKey:key cost:cost];
    });
}

- (void)removeObjectForKey:(id)key {
    if (!key) return;
    
    dispatch_barrier_async(_queue, ^{
        [self->_cache removeObjectForKey:key];
    });
}

- (void)removeAllObjects {
    dispatch_barrier_async(_queue, ^{
        [self->_cache removeAllObjects];
    });
}

- (void)didReceiveMemoryWarning {
    [self removeAllObjects];
}


@end
