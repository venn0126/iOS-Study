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
@end
