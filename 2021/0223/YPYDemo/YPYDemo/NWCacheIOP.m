//
//  NWCacheIOP.m
//  YPYDemo
//
//  Created by Augus on 2021/3/6.
//

#import "NWCacheIOP.h"

@interface NWCacheIOP ()<NSCacheDelegate>

@end

@implementation NWCacheIOP

/// obj will evict
- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    
    NSLog(@"obj %@即将被销毁-%@",obj,cache);
}

@end
