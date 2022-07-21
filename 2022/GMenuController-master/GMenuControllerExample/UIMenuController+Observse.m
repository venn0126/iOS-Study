//
//  UIMenuController+Observse.m
//  GMenuControllerExample
//
//  Created by Augus on 2022/7/21.
//  Copyright © 2022 GIKI. All rights reserved.
//

#import "UIMenuController+Observse.h"
#import "objc/runtime.h"

@implementation UIMenuController (Observse)

/**
 
 
 - (void)setMenuVisible:(BOOL)menuVisible API_DEPRECATED("Use showMenuFromView:rect: or hideMenuFromView: instead.", ios(3.0, 13.0));
 - (void)setMenuVisible:(BOOL)menuVisible animated:(BOOL)animated API_DEPRECATED("Use showMenuFromView:rect: or hideMenuFromView: instead.", ios(3.0, 13.0));

 - (void)setTargetRect:(CGRect)targetRect inView:(UIView *)targetView API_DEPRECATED("Use showMenuFromView:rect: instead.", ios(3.0, 13.0));

 - (void)showMenuFromView:(UIView *)targetView rect:(CGRect)targetRect API_AVAILABLE(ios(13.0));
 
 sharedMenuController
 
 */

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error = nil;
        
        [UIMenuController jr_swizzleMethod:@selector(setMenuItems:) withMethod:@selector(sn_setMenuItems:) error:&error];
        [UIMenuController jr_swizzleMethod:@selector(setMenuVisible:) withMethod:@selector(sn_setMenuVisible:) error:&error];
        [UIMenuController jr_swizzleMethod:@selector(setTargetRect:inView:) withMethod:@selector(sn_setTargetRect:inView:) error:&error];
        [UIMenuController jr_swizzleMethod:@selector(showMenuFromView:rect:) withMethod:@selector(sn_showMenuFromView:rect:) error:&error];

        [UIMenuController jr_swizzleMethod:@selector(sharedMenuController) withMethod:@selector(sn_sharedMenuController) error:&error];

    });
}


- (void)sn_setMenuVisible:(BOOL)menuVisible {
    NSLog(@"%@ ---%@",@(__func__), @(__LINE__));

    [self sn_setMenuVisible:menuVisible];
}


- (void)sn_setTargetRect:(CGRect)targetRect inView:(UIView *)targetView {
    NSLog(@"%@ ---%@",@(__func__), @(__LINE__));

    [self sn_setTargetRect:targetRect inView:targetView];
}

- (void)sn_showMenuFromView:(CGRect)targetView rect:(UIView *)targetRect {
    NSLog(@"%@ ---%@",@(__func__), @(__LINE__));

    [self sn_showMenuFromView:targetView rect:targetRect];
}


- (void)sn_sharedMenuController {
    NSLog(@"%@ ---%@",@(__func__), @(__LINE__));

    [self sn_sharedMenuController];
}

- (void)sn_setMenuItems:(NSArray *)items
{
    NSLog(@"%@ ---%@",@(__func__), @(__LINE__));
    [self sn_setMenuItems:items];
    
}

+ (BOOL)jr_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_ {
#if OBJC_API_VERSION >= 2
    Method origMethod = class_getInstanceMethod(self, origSel_);
    if (!origMethod) {

        return NO;
    }
    
    Method altMethod = class_getInstanceMethod(self, altSel_);
    if (!altMethod) {
        return NO;
    }
    
    class_addMethod(self,
                    origSel_,
                    class_getMethodImplementation(self, origSel_),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel_,
                    class_getMethodImplementation(self, altSel_),
                    method_getTypeEncoding(altMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, origSel_), class_getInstanceMethod(self, altSel_));
    return YES;
#else
    //    Scan for non-inherited methods.
    Method directOriginalMethod = NULL, directAlternateMethod = NULL;
    
    void *iterator = NULL;
    struct objc_method_list *mlist = class_nextMethodList(self, &iterator);
    while (mlist) {
        int method_index = 0;
        for (; method_index < mlist->method_count; method_index++) {
            if (mlist->method_list[method_index].method_name == origSel_) {
                assert(!directOriginalMethod);
                directOriginalMethod = &mlist->method_list[method_index];
            }
            if (mlist->method_list[method_index].method_name == altSel_) {
                assert(!directAlternateMethod);
                directAlternateMethod = &mlist->method_list[method_index];
            }
        }
        mlist = class_nextMethodList(self, &iterator);
    }
    
    //    If either method is inherited, copy it up to the target class to make it non-inherited.
    if (!directOriginalMethod || !directAlternateMethod) {
        Method inheritedOriginalMethod = NULL, inheritedAlternateMethod = NULL;
        if (!directOriginalMethod) {
            inheritedOriginalMethod = class_getInstanceMethod(self, origSel_);
            if (!inheritedOriginalMethod) {
                return NO;
            }
        }
        if (!directAlternateMethod) {
            inheritedAlternateMethod = class_getInstanceMethod(self, altSel_);
            if (!inheritedAlternateMethod) {
                return NO;
            }
        }
        
        int hoisted_method_count = !directOriginalMethod && !directAlternateMethod ? 2 : 1;
        struct objc_method_list *hoisted_method_list = malloc(sizeof(struct objc_method_list) + (sizeof(struct objc_method)*(hoisted_method_count-1)));
        hoisted_method_list->obsolete = NULL;    // soothe valgrind - apparently ObjC runtime accesses this value and it shows as uninitialized in valgrind
        hoisted_method_list->method_count = hoisted_method_count;
        Method hoisted_method = hoisted_method_list->method_list;
        
        if (!directOriginalMethod) {
            bcopy(inheritedOriginalMethod, hoisted_method, sizeof(struct objc_method));
            directOriginalMethod = hoisted_method++;
        }
        if (!directAlternateMethod) {
            bcopy(inheritedAlternateMethod, hoisted_method, sizeof(struct objc_method));
            directAlternateMethod = hoisted_method;
        }
        class_addMethods(self, hoisted_method_list);
    }
    
    //    Swizzle.
    IMP temp = directOriginalMethod->method_imp;
    directOriginalMethod->method_imp = directAlternateMethod->method_imp;
    directAlternateMethod->method_imp = temp;
    
    return YES;
#endif
}

@end
