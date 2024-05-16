//
//  NSObject+MethodSwizzling.m
//  TestHookEncryption
//
//  Created by Augus on 2023/8/3.
//

#import "NSObject+MethodSwizzling.h"
#import <objc/runtime.h>
#import <AppTrackingTransparency/ATTrackingManager.h>
#import "UIKit/UIKit.h"

@implementation NSObject (MethodSwizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (@available(iOS 14, *)) {
            //TODO: 注意注意注意
            //TODO: 注意注意注意
            //TODO: 注意注意注意
            // 想要给类添加类方法的target是元类对象而不是类对象
            [NSObject yscDefenderSwizzlingClassMethod:@selector(requestTrackingAuthorizationWithCompletionHandler:)
                                          withMethod:@selector(pm_return_2_with_completion_handler:)
                                            withClass:object_getClass([ATTrackingManager class])];
            
            
            [NSObject yscDefenderSwizzlingClassMethod:@selector(alertControllerWithTitle:message:preferredStyle:)
                                           withMethod:@selector(sn_alertControllerWithTitle:message:preferredStyle:)
                                           withClass: [UIAlertController class]];
            
            
            /*
             // 类继承关系
             // __NSDictionaryI              继承于 NSDictionary
             // __NSSingleEntryDictionaryI   继承于 NSDictionary
             // __NSDictionary0              继承于 NSDictionary
             // __NSFrozenDictionaryM        继承于 NSDictionary
             // __NSDictionaryM              继承于 NSMutableDictionary
             // __NSCFDictionary             继承于 NSMutableDictionary
             // NSMutableDictionary          继承于 NSDictionary
             // NSDictionary                 继承于 NSObject

             */
            
            
            // 对NSMutableDict做拷贝，拷贝之后字典添加元素会crash.   //待定
               Class frozenDictClass = objc_getClass("__NSFrozenDictionaryM");
//               [self miSwizzleInstanceMethod:frozenDictClass
//                                    swizzSel:@selector(setObject:forKey:)
//                               toSwizzledSel:@selector(miFrozenDictSetObject:forKey:)];
//               [self miSwizzleInstanceMethod:frozenDictClass
//                                    swizzSel:@selector(setObject:forKeyedSubscript:)
//                               toSwizzledSel:@selector(miSetFrozenDictSetObject:forKeyedSubscript:)];
            
            
            [NSObject yscDefenderSwizzlingInstanceMethod:@selector(setObject:forKey:) withMethod:@selector(zhu_setObject:forKey:) withClass:frozenDictClass];
            [NSObject yscDefenderSwizzlingInstanceMethod:@selector(setObject:forKeyedSubscript:) withMethod:@selector(zhu_setObject:forKeyedSubscript:) withClass:frozenDictClass];

            
        } else {
            // Fallback on earlier versions
        }
    });
}

// 交换两个类方法的实现
+ (void)yscDefenderSwizzlingClassMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector withClass:(Class)targetClass {
    swizzlingClassMethod(targetClass, originalSelector, swizzledSelector);
}

// 交换两个对象方法的实现
+ (void)yscDefenderSwizzlingInstanceMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector withClass:(Class)targetClass {
    swizzlingInstanceMethod(targetClass, originalSelector, swizzledSelector);
}

// 交换两个类方法的实现 C 函数
void swizzlingClassMethod(Class class, SEL originalSelector, SEL swizzledSelector) {

    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);

    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

// 交换两个对象方法的实现 C 函数
void swizzlingInstanceMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


+ (void)pm_return_2_with_completion_handler:(void(^)(ATTrackingManagerAuthorizationStatus status))completionHandler  API_AVAILABLE(ios(14)){
     NSLog(@"pm_return_2_with_completion_handler0000");
    if (@available(iOS 14, *)) {
//        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:completionHandler];
        completionHandler(2);
    } else {
        // Fallback on earlier versions
    }
}



+ (id)sn_alertControllerWithTitle:(NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)style {
    
    id r = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    NSLog(@"sn_alertControllerWithTitle %@ %@ %ld",title, message,style);
    return r;
}


- (void)zhu_setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    
    NSLog(@"zhu_setObject %@ %@",anObject, aKey);
}

- (void)zhu_setObject:(id)anObject forKeyedSubscript:(id <NSCopying>)aKey {
    
    NSLog(@"zhu_setObject:forKeyedSubscript %@ %@",anObject, aKey);

}
@end
