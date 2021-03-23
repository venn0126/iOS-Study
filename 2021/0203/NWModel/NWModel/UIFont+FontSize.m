//
//  UIFont+FontSize.m
//  NWModel
//
//  Created by Augus on 2021/3/1.
//

#import "UIFont+FontSize.h"
#import <objc/runtime.h>


#define kScale MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) / 375

@implementation UIFont (FontSize)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        // 当你替换一个类方法的时候调用 获取class
        Class cls = object_getClass((id)self);
        
        // 当你替换一个实例方法的时候使用 [self class]
//        Class cls = [self class];
        
        // SEL
        SEL systemSel = @selector(systemFontOfSize:);
        SEL nwSel = @selector(nw_systemFontSize:);
        
        // origin method
        Method orignalMethod = class_getClassMethod(cls, systemSel);
        // nw method
        Method nwMethod = class_getClassMethod(cls, nwSel);
        
        // 如果子类没有实现fontofsize方法，而是在父类实现， 首先进行该方法的添加 原始方法sel和自定义的实现imp以及参数和返回值编码
        
        BOOL didAddMethod = class_addMethod(cls, systemSel, method_getImplementation(nwMethod), method_getTypeEncoding(nwMethod));
        if (didAddMethod) {
            class_replaceMethod(cls, nwSel, method_getImplementation(orignalMethod), method_getTypeEncoding(orignalMethod));
        } else {
            // 如果子类已经存在 直接进行方法的替换
            // exchange
            method_exchangeImplementations(orignalMethod, nwMethod);
        }
    });
}

+ (UIFont *)nw_systemFontSize:(CGFloat)fontSize {
    return [UIFont nw_systemFontSize:fontSize * kScale];
}


@end
