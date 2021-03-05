//
//  UILabel+Extension.m
//  NWModel
//
//  Created by Augus on 2021/3/1.
//

#import "UILabel+Extension.h"
#import <objc/runtime.h>


#define kScale MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) / 375


@implementation UILabel (Extension)

+ (void)load {
    
    // 保证只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 获取类对象
        Class cls = [self class];
        // 拿到系统方法
        SEL orignalSEL = @selector(awakeFromNib);
        Method orignalMethod = class_getInstanceMethod(cls, @selector(awakeFromNib));
        // 自定义SEL和method
        SEL nwMethodSEL = @selector(nwAwakeFromNib);
        Method nwMethod = class_getInstanceMethod(cls, nwMethodSEL);
        
        BOOL isAdded = class_addMethod(cls, orignalSEL, method_getImplementation(nwMethod), method_getTypeEncoding(nwMethod));
        if (isAdded) {
            class_replaceMethod(cls, nwMethodSEL, method_getImplementation(orignalMethod), method_getTypeEncoding(orignalMethod));
        } else {
            method_exchangeImplementations(orignalMethod, nwMethod);
            
        }
    });
}

//- (void)awakeFromNib
- (void)nwAwakeFromNib {
    [self nwAwakeFromNib];
    self.font = [UIFont systemFontOfSize:self.font.pointSize];
}



@end
