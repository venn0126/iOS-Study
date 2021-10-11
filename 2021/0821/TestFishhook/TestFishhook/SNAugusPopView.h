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
    // Top
    SNAugusPopViewDirectionTop = 1 << 0,
    // Bottom
    SNAugusPopViewDirectionBottom = 1 << 1,
    // Left
    SNAugusPopViewDirectionLeft = 1 << 2,
    // Right
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
/// The attributes about show anmiaton duration
@property (nonatomic, assign) NSTimeInterval showDuration;
/// The attributes about dismiss anmiaton duration
@property (nonatomic, assign) NSTimeInterval dismissDuration;


/// The attributes about arrow
@property (nonatomic, assign) CGFloat horizontalLabelPadding;
@property (nonatomic, assign) CGFloat verticalLabelPadding;
@property (nonatomic, assign) SNAugusPopViewDirection direction;

/// TODO: The attibutes about popView of shadow



/// The attibutes about popView of arrow
@property (nonatomic, assign) CGFloat arrowHorizontalPadding;
/// No working
@property (nonatomic, assign) CGFloat arrowVerticalPadding;
@property (nonatomic, assign) CGFloat arrowWidth;
@property (nonatomic, assign) CGFloat arrowHeight;

/// Mul lines attributes
@property (nonatomic, assign) CGFloat mulLineWidth;
/// Close button attributes
@property (nonatomic, assign) CGFloat closeButtonleading;
@property (nonatomic, assign) CGFloat closeButtonWidth;
/// If mul lines top padding
@property (nonatomic, assign) CGFloat closeButtonTopPadding;







@property (nonatomic, weak) id<SNAugusPopViewDelagate> delegate;

/// A pop view  designated initalzation
/// @param frame A origin of pop view and size is auto calucate
/// @param text  A text of pop View
/// @param direction A text of popView's arrow direction
/// @param singleLine YES is 1 line, and NO is mul lines
/// @param closeButtonName A button in top and right show,if name = @"" stand for not show
/// @param leftImageName A imageView in centerY and left ,if name = @"" stand for not show
- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction
                   singleLine:(BOOL)singleLine
              closeButtonName:(NSString *)closeButtonName
                leftImageName:(NSString *)leftImageName NS_DESIGNATED_INITIALIZER;


- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction
                   singleLine:(BOOL)singleLine
              closeButtonName:(NSString *)closeButtonName;


- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction
                   singleLine:(BOOL)singleLine
                leftImageName:(NSString *)leftImageName;


- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction
                   singleLine:(BOOL)singleLine;


- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction;


/// A popView show method.
- (void)show;


/// A popView dismiss method.
- (void)dismiss;


/// Show popView to super view.
/// @param toView A super view.
- (void)showToView:(UIView *)toView;


// TODO: The multiple lines show
// TODO: The right and top close btn,width and height, left,default width=height
// TODO: The left and centerY of imageView

@end

NS_ASSUME_NONNULL_END
