//
//  TNCacheCenter.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import "TNCacheCenter.h"
#import "TNNetworkConfig.h"
#import "NSString+TNAdditions.h"
#import <YYCache/YYCache.h>

@interface TNCacheCenter ()

@property (nonatomic, strong) YYMemoryCache *memoryCache;
@property (nonatomic, strong) YYDiskCache *diskCache;

@end

@implementation TNCacheCenter

+ (instancetype)sharedInstance {
   static TNCacheCenter *instance = nil;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       instance = [[self alloc] init];
   });
   return instance;
}

- (instancetype)init {
   self = [super init];
   if (self) {
       // 初始化内存缓存
       _memoryCache = [YYMemoryCache new];
       _memoryCache.name = @"TNNetworkMemoryCache";
       _memoryCache.countLimit = 100;
       _memoryCache.costLimit = [TNNetworkConfig sharedConfig].maxMemoryCacheSize;
       
       // 初始化磁盘缓存
       NSString *cachePath = [TNNetworkConfig sharedConfig].diskCachePath;
       _diskCache = [[YYDiskCache alloc] initWithPath:cachePath];
       _diskCache.name = @"TNNetworkDiskCache";
       _diskCache.costLimit = [TNNetworkConfig sharedConfig].maxDiskCacheSize;
   }
   return self;
}

#pragma mark - 内存缓存
- (void)saveMemoryCacheWithResponse:(TNURLResponse *)response
                 serviceIdentifier:(NSString *)serviceIdentifier
                        methodName:(NSString *)methodName
                            params:(NSDictionary *)params {
   NSString *cacheKey = [self keyWithServiceIdentifier:serviceIdentifier methodName:methodName params:params];
   [self.memoryCache setObject:response forKey:cacheKey withCost:0];
}

- (TNURLResponse *)fetchMemoryCacheWithServiceIdentifier:(NSString *)serviceIdentifier
                                            methodName:(NSString *)methodName
                                               params:(NSDictionary *)params {
   NSString *cacheKey = [self keyWithServiceIdentifier:serviceIdentifier methodName:methodName params:params];
   return [self.memoryCache objectForKey:cacheKey];
}

#pragma mark - 磁盘缓存
- (void)saveDiskCacheWithResponse:(TNURLResponse *)response
               serviceIdentifier:(NSString *)serviceIdentifier
                      methodName:(NSString *)methodName
                          params:(NSDictionary *)params {
   NSString *cacheKey = [self keyWithServiceIdentifier:serviceIdentifier methodName:methodName params:params];
   [self.diskCache setObject:response forKey:cacheKey];
}

- (TNURLResponse *)fetchDiskCacheWithServiceIdentifier:(NSString *)serviceIdentifier
                                          methodName:(NSString *)methodName
                                             params:(NSDictionary *)params {
   NSString *cacheKey = [self keyWithServiceIdentifier:serviceIdentifier methodName:methodName params:params];
   return [self.diskCache objectForKey:cacheKey];
}

#pragma mark - 清除缓存
- (void)cleanAllCache {
   [self cleanMemoryCache];
   [self cleanDiskCache];
}

- (void)cleanMemoryCache {
   [self.memoryCache removeAllObjects];
}

- (void)cleanDiskCache {
   [self.diskCache removeAllObjects];
}

#pragma mark - 辅助方法
- (NSString *)keyWithServiceIdentifier:(NSString *)serviceIdentifier
                           methodName:(NSString *)methodName
                               params:(NSDictionary *)params {
   NSMutableString *key = [NSMutableString string];
   [key appendFormat:@"%@_%@", serviceIdentifier, methodName];
   
   if (params.count > 0) {
       // 将参数按照键排序
       NSArray *sortedKeys = [[params allKeys] sortedArrayUsingSelector:@selector(compare:)];
       NSMutableString *paramsString = [NSMutableString string];
       
       for (NSString *sortedKey in sortedKeys) {
           id value = params[sortedKey];
           if ([value isKindOfClass:[NSString class]]) {
               [paramsString appendFormat:@"%@=%@&", sortedKey, value];
           } else if ([value isKindOfClass:[NSNumber class]]) {
               [paramsString appendFormat:@"%@=%@&", sortedKey, [value stringValue]];
           }
       }
       
       if (paramsString.length > 0) {
           [paramsString deleteCharactersInRange:NSMakeRange(paramsString.length - 1, 1)];
           [key appendFormat:@"_%@", [paramsString tn_md5]];
       }
   }
   
   return key;
}


@end
