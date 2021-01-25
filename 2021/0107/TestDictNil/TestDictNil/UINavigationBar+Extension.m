//
//  UINavigationBar+Extension.m
//  TestDictNil
//
//  Created by Augus on 2021/1/8.
//

#import "UINavigationBar+Extension.h"
#import <objc/runtime.h>


#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

const void *overlayKey;

@implementation UINavigationBar (Extension)

- (UIView *)overlayView {
    return objc_getAssociatedObject(self, overlayKey);
}

- (void)setOverlayView:(UIView *)overlayView {
    
    objc_setAssociatedObject(self, overlayKey, overlayView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (void)nw_setBackgroundColor:(UIColor *)backgroundColor {
    
    if (!self.overlayView) {
        [self setBackgroundImage:[UIImage imageNamed:@"bg.jpg"] forBarMetrics:UIBarMetricsDefault];
        self.overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20.0)];
        self.overlayView.userInteractionEnabled = NO;
        self.overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.overlayView.backgroundColor = UIColor.redColor;
        [[self.subviews firstObject] insertSubview:self.overlayView atIndex:0];
        
    }
    
    self.overlayView.backgroundColor = backgroundColor;
}

- (void)nw_setTranslationY:(CGFloat)translationY {
    
    self.transform = CGAffineTransformMakeTranslation(0, translationY);

}

- (void)nw_setElementsAlpha:(CGFloat)alpha {
    
//    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
//       
//        
//        view.alpha = alpha;
//        
//    }];
    
//    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
//        view.alpha = alpha;
//        
//    }];
    
    // when vc first load title view maybe is nil
//    UIView *titleView = [self valueForKey:@"_titleView"];
//    titleView.alpha = alpha;
    
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        
        if ([obj isKindOfClass:NSClassFromString(@"UINavgationItemView")]) {
            obj.alpha = alpha;
        }
        
        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {
            obj.alpha = alpha;
        }
    }];
}

- (void)nw_reset {
    
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlayView removeFromSuperview];
    self.overlayView = nil;
}

@end
