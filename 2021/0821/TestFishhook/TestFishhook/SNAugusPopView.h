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

@protocol SNAugusPopViewDelagate <NSObject>

@optional

- (void)tapGesturePopView;

@end

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


/// The attributes about show anmiaton duration
@property (nonatomic, assign) NSTimeInterval animationDuration;
/// The attributes about dismiss anmiaton duration
@property (nonatomic, assign) NSTimeInterval dismissDuration;


/// The attributes about arrow
@property (nonatomic, assign) CGFloat horizontalLabelPadding;
@property (nonatomic, assign) CGFloat verticalLabelPadding;
@property (nonatomic, assign) SNAugusPopViewDirection direction;

/// The attibutes about popView of shadow



/// The attibutes about popView of arrow
@property (nonatomic, assign) CGFloat arrowPadding;
@property (nonatomic, assign) CGFloat arrowWidth;
@property (nonatomic, assign) CGFloat arrowHeight;

@property (nonatomic, weak) id<SNAugusPopViewDelagate> delegate;



/// A pop view initalzation,default direction is top.
/// @param frame A origin of pop view and size is auto calucate
/// @param text A text of pop View
/// @param direction A text of popView's arrow direction
- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction;


/// A popView show method.
- (void)show;


/// A popView dismiss method.
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
