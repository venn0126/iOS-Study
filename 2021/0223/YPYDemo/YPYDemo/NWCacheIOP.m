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

//+ (BOOL)resolveClassMethod:(SEL)sel

//+ (BOOL)resolveInstanceMethod:(SEL)sel



//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//
//    return nil;
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//
//
//}

@end
