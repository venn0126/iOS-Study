//
//  UITapGestureRecognizer+Mock.h
//  TestHookEncryption
//
//  Created by Augus on 2024/1/10.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UITapGestureRecognizer (Mock)


- (void)performTapWithView:(UIView *)view andPoint:(CGPoint)point;


@end

NS_ASSUME_NONNULL_END
