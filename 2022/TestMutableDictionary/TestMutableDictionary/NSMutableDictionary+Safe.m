//
//  NSMutableDictionary+Safe.m
//  sohunews
//
//  Created by wang shun on 2018/12/21.
//  Copyright © 2018 Sohu.com. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import <objc/runtime.h>

static void swizzle(Class class, SEL originalSEL, SEL newSEL)
{
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, newSEL);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@implementation NSMutableDictionary (Safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class NSDictionaryM = NSClassFromString(@"__NSDictionaryM");
        swizzle(NSDictionaryM, @selector(setObject:forKey:), @selector(snnews_setObject:forKey:));
        swizzle(NSDictionaryM, @selector(setObject:forKeyedSubscript:), @selector(snnews_setObject:forKeyedSubscript:));
        
        Class NSPlaceholderDictionary = NSClassFromString(@"__NSPlaceholderDictionary");
        swizzle(NSPlaceholderDictionary, @selector(initWithObjects:forKeys:count:), @selector(initWithNullObjects:forKeys:count:));
    });
}

- (void)snnews_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    @synchronized (self) {
        if (self && anObject && aKey) {
            [self snnews_setObject:anObject forKey:aKey];
        }
    }
}

- (void)snnews_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    @synchronized (self) {
        if (self && obj && key) {
            [self snnews_setObject:obj forKeyedSubscript:key];
        }
    }
}

- (instancetype)initWithNullObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)count
{
    for (NSUInteger i = 0; i < count; i++) {
        if (objects[i] == nil || keys[i] == nil) {
            return nil;
        }
    }
    
    return [self initWithNullObjects:objects forKeys:keys count:count];
}

@end
