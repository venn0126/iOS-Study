//
//  TNHeightManager.m
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import "TNHeightManager.h"
#import <UIKit/UIKit.h>
#import "TNLRUCache.h"

@implementation TNHeightManager {
    NSMutableDictionary *_heightCache;  // 模型 -> 高度的映射
    NSLock *_cacheLock;                 // 线程安全锁
    TNHeightCacheLevel _cacheLevel;     // 缓存级别
    dispatch_queue_t _calculateQueue;   // 计算队列
}


+ (instancetype)sharedManager {
    static TNHeightManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TNHeightManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _heightCache = [NSMutableDictionary dictionary];
        _cacheLock = [[NSLock alloc] init];
        _cacheLevel = TNHeightCacheLevelMemory;
        _calculateQueue = dispatch_queue_create("com.tn.heightcalculate", DISPATCH_QUEUE_CONCURRENT);
        
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

- (void)setCacheLevel:(TNHeightCacheLevel)level {
    _cacheLevel = level;
}

- (CGFloat)heightForModel:(TNCellModel *)model withContainerWidth:(CGFloat)width {
    // 1. 检查模型是否已有高度
    if (model.cellHeight > 0) {
        return model.cellHeight;
    }
    
    // 2. 检查缓存
    if (_cacheLevel >= TNHeightCacheLevelMemory) {
        NSString *cacheKey = [self cacheKeyForModel:model width:width];
        [_cacheLock lock];
        NSNumber *cachedHeight = _heightCache[cacheKey];
        [_cacheLock unlock];
        
        if (cachedHeight) {
            // 更新模型高度并返回
            model.cellHeight = [cachedHeight floatValue];
            return model.cellHeight;
        }
        
        // 检查LRU缓存
        cachedHeight = [[TNLRUCache sharedCache] objectForKey:cacheKey];
        if (cachedHeight) {
            model.cellHeight = [cachedHeight floatValue];
            return model.cellHeight;
        }
    }
    
    // 3. 计算高度
    CGFloat height = [model calculateHeightWithContainerWidth:width];
    
    // 4. 缓存高度
    if (_cacheLevel >= TNHeightCacheLevelMemory) {
        NSString *cacheKey = [self cacheKeyForModel:model width:width];
        [_cacheLock lock];
        _heightCache[cacheKey] = @(height);
        [_cacheLock unlock];
        
        // 同时存入LRU缓存
        [[TNLRUCache sharedCache] setObject:@(height) forKey:cacheKey cost:sizeof(CGFloat)];
    }
    
    return height;
}

- (void)asyncCalculateHeightForModel:(TNCellModel *)model
                 withContainerWidth:(CGFloat)width
                         completion:(void(^)(CGFloat height))completion {
    // 先检查缓存
    if (model.cellHeight > 0) {
        if (completion) {
            completion(model.cellHeight);
        }
        return;
    }
    
    NSString *cacheKey = [self cacheKeyForModel:model width:width];
    [_cacheLock lock];
    NSNumber *cachedHeight = _heightCache[cacheKey];
    [_cacheLock unlock];
    
    if (cachedHeight) {
        model.cellHeight = [cachedHeight floatValue];
        if (completion) {
            completion(model.cellHeight);
        }
        return;
    }
    
    // 异步计算
    dispatch_async(_calculateQueue, ^{
        CGFloat height = [model calculateHeightWithContainerWidth:width];
        
        // 缓存结果
        if (self->_cacheLevel >= TNHeightCacheLevelMemory) {
            [self->_cacheLock lock];
            self->_heightCache[cacheKey] = @(height);
            [self->_cacheLock unlock];
            
            [[TNLRUCache sharedCache] setObject:@(height) forKey:cacheKey cost:sizeof(CGFloat)];
        }
        
        model.cellHeight = height;
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(height);
            });
        }
    });
}

- (void)asyncCalculateHeightForModels:(NSArray<TNCellModel *> *)models
                  withContainerWidth:(CGFloat)width
                          completion:(void(^)(void))completion {
    if (models.count == 0) {
        if (completion) {
            completion();
        }
        return;
    }
    
    // 创建一个调度组
    dispatch_group_t group = dispatch_group_create();
    
    // 对每个模型异步计算高度
    for (TNCellModel *model in models) {
        dispatch_group_enter(group);
        [self asyncCalculateHeightForModel:model withContainerWidth:width completion:^(CGFloat height) {
            dispatch_group_leave(group);
        }];
    }
    
    // 所有计算完成后回调
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}

- (void)invalidateHeightForModel:(TNCellModel *)model {
    if (!model) return;
    
    model.cellHeight = -1;
    
    NSString *cacheKey = [self cacheKeyForModel:model width:0]; // 宽度为0表示所有宽度的缓存
    
    [_cacheLock lock];
    // 移除所有包含该模型唯一键的缓存项
    NSArray *allKeys = [_heightCache allKeys];
    for (NSString *key in allKeys) {
        if ([key hasPrefix:cacheKey]) {
            [_heightCache removeObjectForKey:key];
        }
    }
    [_cacheLock unlock];
    
    // 从LRU缓存中移除
    [[TNLRUCache sharedCache] removeObjectForKey:cacheKey];
}

- (void)invalidateAllHeightCache {
    [_cacheLock lock];
    [_heightCache removeAllObjects];
    [_cacheLock unlock];
    
    [[TNLRUCache sharedCache] removeAllObjects];
}

- (NSString *)cacheKeyForModel:(TNCellModel *)model width:(CGFloat)width {
    return [NSString stringWithFormat:@"%@_%.1f", model.uniqueKey, width];
}

- (void)didReceiveMemoryWarning {
    [self invalidateAllHeightCache];
}




@end
