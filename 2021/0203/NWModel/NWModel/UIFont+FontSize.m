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
       
        
        Class cls = [self class];
        // get origin method
        Method orignalMethod = class_getClassMethod(cls, @selector(systemFontOfSize:));
        // get self iml method
        Method nwMethod = class_getClassMethod(cls, @selector(nw_systemFontSize:));
        // exchange
        method_exchangeImplementations(orignalMethod, nwMethod);

    });
}

+ (UIFont *)nw_systemFontSize:(CGFloat)fontSize {
    return [UIFont nw_systemFontSize:fontSize * kScale];
}


@end
