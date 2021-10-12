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

/// The attributes of cornerRadius
@property (nonatomic, assign) CGFloat cornerRadius;
/// The attributes of backgroundColor
@property (nonatomic, strong) UIColor *aBackgroundColor;
/// The attributes of backgroundColor alpha
@property (nonatomic, assign) CGFloat aBackgroundShowAlpha;
/// The attributes of popView's backgroundColor default black (0,0,0)
/// You only set backgroundColor by `colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha`,others methods  no working
/// The number for red ,blue,green number[0,1]
@property (nonatomic, assign) CGFloat aBackgroundRed;
@property (nonatomic, assign) CGFloat aBackgroundGreen;
@property (nonatomic, assign) CGFloat aBackgroundBlue;

/// The attibutes about popView of border
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;


/// The attributes about show anmiaton duration
@property (nonatomic, assign) NSTimeInterval animationDuration;
/// The attributes about show anmiaton duration
@property (nonatomic, assign) NSTimeInterval showDuration;
/// The attributes about dismiss anmiaton duration
@property (nonatomic, assign) NSTimeInterval dismissDuration;


/// The distance about arrow of top and bottom
@property (nonatomic, assign) CGFloat horizontalLabelPadding;
/// The distance about arrow of left and right
@property (nonatomic, assign) CGFloat verticalLabelPadding;
@property (nonatomic, assign) SNAugusPopViewDirection direction;


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
@property (nonatomic, assign) CGFloat closeButtonHeight;
/// If mul lines top padding
@property (nonatomic, assign) CGFloat closeButtonTopPadding;

/// LeftImageView
@property (nonatomic, copy) NSString *leftImageName;
@property (nonatomic, assign) CGFloat leftImageWidth;
@property (nonatomic, assign) CGFloat leftImageHeight;
@property (nonatomic, assign) CGFloat leftImageLabelPadding;

/// Gradient Effect attributes
// The array of CGColorRef objects defining the color of each gradient
// stop. Defaults to nil. Animatable.
@property (nonatomic, copy) NSArray *gradientColors;
/* The start and end points of the gradient when drawn into the layer's
 * coordinate space. The start point corresponds to the first gradient
 * stop, the end point to the last gradient stop. Both points are
 * defined in a unit coordinate space that is then mapped to the
 * layer's bounds rectangle when drawn. (I.e. [0,0] is the bottom-left
 * corner of the layer, [1,1] is the top-right corner.) The default values
 * are [.5,0] and [.5,1] respectively. Both are animatable. */
@property (nonatomic, assign) CGPoint gradientStartPoint;
@property (nonatomic, assign) CGPoint gradientEndPoint;
/* An optional array of NSNumber objects defining the location of each
 * gradient stop as a value in the range [0,1]. The values must be
 * monotonically increasing. If a nil array is given, the stops are
 * assumed to spread uniformly across the [0,1] range. When rendered,
 * the colors are mapped to the output colorspace before being
 * interpolated. Defaults to nil. Animatable. */
@property(nonatomic, copy) NSArray<NSNumber *> *gradientLocations;


@property (nonatomic, weak) id<SNAugusPopViewDelagate> delegate;

/// A pop view  designated initalzation
/// @param frame A origin of pop view and size is auto calucate
/// @param text  A text of pop View
/// @param direction A text of popView's arrow direction
/// @param singleLine YES is 1 line, and NO is mul lines
/// @param closeButtonName A button in top and right show,if name = @"" stand for not show
/// @param leftImageName A imageView in centerY and left ,if name = @"" stand for not show
/// @param gradient The popView has gradient effect or not,you need to set about gradient attributes,eg gradientColors
- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction
                   singleLine:(BOOL)singleLine
              closeButtonName:(NSString *)closeButtonName
                leftImageName:(NSString *)leftImageName
                     gradient:(BOOL)gradient NS_DESIGNATED_INITIALIZER;


- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction
                   singleLine:(BOOL)singleLine
              closeButtonName:(NSString *)closeButtonName
                     gradient:(BOOL)gradient;


- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction
                   singleLine:(BOOL)singleLine
                leftImageName:(NSString *)leftImageName
                     gradient:(BOOL)gradient;


- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction
                   singleLine:(BOOL)singleLine
                     gradient:(BOOL)gradient;


- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction
                     gradient:(BOOL)gradient;


/// A popView show method.
- (void)show;


/// A popView dismiss method.
- (void)dismiss;


/// Show popView to super view.
/// @param toView A super view.
- (void)showToView:(UIView *)toView;


// TODO: The customView for popView
// TODO: The self backgroundColor gradient

@end

NS_ASSUME_NONNULL_END
