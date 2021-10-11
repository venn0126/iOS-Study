//
//  SNAugusPopView.h
//  com.sohu.news
//
//  Created by Augus on 2021/9/27.
//

/// Use Example
///
/// The class to show toast text that you want to any text,and define  arrow that direction for top left right bottom and none.
/// The class uses run-time to mark the instance avoid show some duplicates instances.
/// The class shows corner radius used to be bezierPath
/// You can custome some attributes,eg animation duration,arrow width and height and so on.
/// And you can touch popView to respond a tap action that only you need to conform the SNAugusPopViewDelagate
/// For example, this show use a top popView, and set  and text font
///
///     self.topPopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(160, 160, 0, 0) text:@"请阅读并勾选以下协议Top" direction:SNAugusPopViewDirectionTop];
///     self.topPopView.delegate = self;
///     self.topPopView.textFont = [UIFont systemFontOfSize:13];
///     self.topPopView.verticalLabelPadding = 10;
///     [self.view addSubview:self.topPopView];
///
///     [self.topPopView show];
///


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


@class SNAugusPopView;
@protocol SNAugusPopViewDelagate <NSObject>

@optional

- (void)augusPopViewClick:(SNAugusPopView *)popView;

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

/// TODO: The attibutes about popView of shadow



/// The attibutes about popView of arrow
@property (nonatomic, assign) CGFloat arrowHorizontalPadding;
@property (nonatomic, assign) CGFloat arrowVerticalPadding;
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

- (void)showToView:(UIView *)toView;

@end

NS_ASSUME_NONNULL_END
