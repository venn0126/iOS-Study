//
//  SNAugusPopView.h
//  TestFishhook
//
//  Created by Augus on 2021/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SNAugusPopViewDirection) {
    // up
    SNAugusPopViewDirectionTop = 1 << 0,
    // down
    SNAugusPopViewDirectionBottom = 1 << 1,
    // right
    SNAugusPopViewDirectionLeft = 1 << 2,
    // left
    SNAugusPopViewDirectionRight = 1 << 3,
    // All
    SNAugusPopViewDirectionAll = SNAugusPopViewDirectionTop | SNAugusPopViewDirectionBottom | SNAugusPopViewDirectionLeft | SNAugusPopViewDirectionRight,
    
};

@interface SNAugusPopView : UIView

/// The attibutes about text
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, assign) NSTextAlignment textAlignment;

/// The attributes about popView
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *aBackgroundColor;
/// The attibutes about popView of border
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;


/// The attributes about show anmiaton
@property (nonatomic, assign) NSTimeInterval animationDuration;

/// The attributes about arrow
@property (nonatomic, assign) CGFloat horizontalLabelPadding;
@property (nonatomic, assign) SNAugusPopViewDirection direction;

/// The attibutes about popView of shadow



- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text;

- (void)show;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
