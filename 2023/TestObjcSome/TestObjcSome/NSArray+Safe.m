//
//  NSArray+Safe.m
//  TestObjcSome
//
//  Created by Augus on 2023/3/3.
//

#import "NSArray+Safe.h"
#import <objc/runtime.h>

@implementation NSArray (Safe)


static void swizzle(Class class, SEL originalSEL, SEL newSEL)
{
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, newSEL);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}


+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class NSArrayM = NSClassFromString(@"__NSArrayM");

        
//        swizzle(NSArrayM, @selector(objectAtIndex:), @selector(objectAtSafeIndex_M:));
//        swizzle(NSArrayM, @selector(objectAtIndexedSubscript:), @selector(objectAtIndexedSubscript_M:));
        swizzle(NSArrayM, @selector(insertObject:atIndex:), @selector(insertObject:atIndex_M:));
        
    });
}


- (id)objectAtSafeIndex_M:(NSUInteger)index
{
    
    if(!self ||  index > self.count) {
        return nil;
    }
        
    return [self objectAtSafeIndex_M:index];
    
}


//- (id)objectAtIndexedSubscript_M:(NSUInteger)index
//{
//    if ( index >= self.count || index >= -1)
//    {
//        NSLog(@"objectAtIndexedSubscript_M");
//        return nil;
//    }
//    return [self objectAtIndexedSubscript_M:index];
//}


- (void)insertObject:(id)anObject atIndex_M:(NSUInteger)index {
   
//    NSLog(@"augus index %d",(index > self.count));
    if(!anObject || index > self.count) return;
    
    [self insertObject:anObject atIndex_M:index];
}


@end
