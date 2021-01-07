//
//  UIFont+Extension.m
//  TestGuideLayout
//
//  Created by Augus on 2020/12/30.
//

#import "UIFont+Extension.h"
#import <objc/runtime.h>

#define kScale MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) / 375


@implementation UIFont (Extension)

//只执行一次的方法，在这个地方 替换方法
+(void)load{
    
    //保证线程安全
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        //拿到系统方法
//        Method orignalMethod = class_getClassMethod(class, @selector(systemFontOfSize:));
//        //拿到自己定义的方法
//        Method myMethod = class_getClassMethod(class, @selector(test_systemFontOfSize:));
//        //交换方法
//        method_exchangeImplementations(orignalMethod, myMethod);
//    });
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls = [self class];
        // get system func
        Method orginalMethod = class_getClassMethod(cls, @selector(systemFontOfSize:));
        // get my func
        Method myMethod = class_getClassMethod(cls, @selector(test_systemFontOfSize:));
        // change method
        method_exchangeImplementations(orginalMethod, myMethod);

    });
}

+ (UIFont *)test_systemFontOfSize:(CGFloat)fontSize{
    NSLog(@"fff---%f",kScale);
    UIFont *font = [UIFont test_systemFontOfSize:fontSize*kScale];
    return font;
}

@end
