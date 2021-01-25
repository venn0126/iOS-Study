//
//  UINavigationBar+Extension.h
//  TestDictNil
//
//  Created by Augus on 2021/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (Extension)


- (void)nw_setBackgroundColor:(UIColor *)backgroundColor;
- (void)nw_setTranslationY:(CGFloat)translationY;
- (void)nw_setElementsAlpha:(CGFloat)alpha;
- (void)nw_reset;

@end

NS_ASSUME_NONNULL_END
