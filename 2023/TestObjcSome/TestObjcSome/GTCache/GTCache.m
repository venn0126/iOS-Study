//
//  GTCache.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/7.
//

#import "GTCache.h"


@interface GTCache ()

///缓存工具
@property (nonatomic,strong) NSCache *augusCache;

@end

@implementation GTCache

+(instancetype)shareInstance
{
    
    static GTCache *_instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[GTCache alloc] init];
        [_instance initCache];
    });
    return _instance;
}

- (void)initCache
{
    self.augusCache = [[NSCache alloc] init];
    
    self.augusCache = [[NSCache alloc] init];
    self.augusCache.countLimit = 300; // 限制个数，默认是0，无限空间
    self.augusCache.totalCostLimit = 5*1024*1024; // 设置大小设置，默认是0，无限空间
    self.augusCache.name = @"augus_cache";
    
}

- (void)gt_setObject:(id)obj forKey:(id)key {
    
    [self.augusCache setObject:obj forKey:key];
}


- (id)gt_objectForKey:(id)key {
    return [self.augusCache objectForKey:key];
}

@end
