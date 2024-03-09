//
//  GTCustomButton.h
//  TestHookEncryption
//
//  Created by Augus on 2024/3/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface GTCustomButton : UIView

@property(nonatomic, strong) UILabel *buttonLabel;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image frame:(CGRect)frame;

- (void)addTarget:(id)target action:(SEL)sel;


@end

NS_ASSUME_NONNULL_END
