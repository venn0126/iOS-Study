//
//  UILabel+Extension.m
//  TestGuideLayout
//
//  Created by Augus on 2020/12/30.
//

#import "UILabel+Extension.h"
#import <objc/runtime.h>

#define kScale MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) / 375


@implementation UILabel (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 系统方法
        
//        SEL afx = @selector(awakeFromNib);
//        Class cls = [self class];
//        Method afxMethod = class_getInstanceMethod(cls, afx);
//        
//        SEL mytest = @selector(testFontAwakeFromXib);
//        Method myMethod = class_getInstanceMethod(cls, mytest);
//        
//        BOOL isAdd = class_addMethod(cls, mytest, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
//        
//        if (isAdd) {
//            // 添加方法
//            class_replaceMethod(cls, mytest, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
//            
//        }else {
//            // 替换方法
//            method_exchangeImplementations(afxMethod, myMethod);
//        }
    });
}

- (void)testFontAwakeFromXib {
    
    self.font = [UIFont systemFontOfSize:self.font.pointSize * kScale];

}

@end
