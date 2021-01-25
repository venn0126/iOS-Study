//
//  NSDictionary+NilSafe.m
//  TestDictNil
//
//  Created by Augus on 2021/1/8.
//

#import "NSDictionary+NilSafe.h"
#import <objc/runtime.h>


@implementation NSObject (Swizzing)

+ (BOOL)nw_swizzleMethod:(SEL)origSel withMethod:(SEL)aSel {
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method aMethod = class_getInstanceMethod(self, aSel);
    if (!origMethod || !aMethod) {
        return NO;
    }
    
    class_addMethod(self, origSel, class_getMethodImplementation(self, origSel), method_getTypeEncoding(origMethod));
    class_addMethod(self, aSel, class_getMethodImplementation(self, aSel), method_getTypeEncoding(aMethod));
    
    method_exchangeImplementations(origMethod, aMethod);
    return YES;
}

+ (BOOL)nw_swizzleClassMethod:(SEL)origSel withMethod:(SEL)aSel {
    
    return [object_getClass((id)self) nw_swizzleMethod:origSel withMethod:aSel];
}

@end

@implementation NSDictionary (NilSafe)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self nw_swizzleMethod:@selector(initWithObjects:forKeys:count:) withMethod:@selector(nw_initWithObjects:forKeys:count:)];
        [self nw_swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) withMethod:@selector(nw_dictionaryWithObjects:forKeys:conut:)];
    });
}

+ (instancetype)nw_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys conut:(NSUInteger)cnt {
    
    id safeObjs[cnt];
    id safeKeys[cnt];
    
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj) {
            continue;
        }
        
        safeKeys[j] = key;
        safeObjs[j] = obj;
        j++;
    }
    return [self nw_dictionaryWithObjects:safeObjs forKeys:safeKeys conut:j];
}

- (instancetype)nw_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    
    id safeObjs[cnt];
    id safeKeys[cnt];
    
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        
        if (!key) {
            continue;
        }
        
        if (!obj) {
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjs[j] = obj;
        j++;
        
    }
    return [self nw_initWithObjects:safeObjs forKeys:safeKeys count:cnt];
}

@end


@implementation NSMutableDictionary (NilSafe)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class clazz = NSClassFromString(@"__NSDictionaryM");
//        [clazz nw_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(nw_setObject:forKey:)];
//        [clazz nw_swizzleMethod:@selector(setObject:forKeyedSubscript:) withMethod:@selector(nw_setObject:forKeyedSubscript:)];
//        
//    });
//}
//
//- (void)nw_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
//    
//    if (!anObject || !aKey) {
//        return;
//    }
//    [self nw_setObject:anObject forKey:aKey];
//}
//
//- (void)nw_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
//    if (!obj || !key) {
//        return;
//    }
//    [self nw_setObject:obj forKeyedSubscript:key];
//}

@end
