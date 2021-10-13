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
/// The alpha of popView not effect text alpha
/// You can custom some fantasy grandient or border effect
/// And you can touch popView to respond a tap action that only you need to conform the SNAugusPopViewDelagate
/// For example, this show use a top popView, and set  and text font
///
///     self.topPopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(150, 200, 0, 0) text:@"请阅读并勾选以下协议勾选以下协议All" direction:SNAugusPopViewDirectionBottom singleLine:YES closeButtonName:@"close" leftImageName:@"left" gradient:YES];
///     self.allPopView.textFont = [UIFont systemFontOfSize:16];
///     self.allPopView.gradientColors = @[(id)(UIColor.orangeColor.CGColor),(id)UIColor.redColor.CGColor];
///     self.allPopView.gradientStartPoint = CGPointMake(1.0, 0.5);
///     self.allPopView.gradientEndPoint = CGPointMake(0.0, 0.5);
///     self.allPopView.gradientLocations = @[@0.5,@1.0];

///     self.leftImagePopView.leftImageWidth = 30;
///     self.leftImagePopView.leftImageHeight = 15;
///     self.leftImagePopView.leftImageLabelPadding = 20;
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


@property (nonatomic, assign) SNAugusPopViewDirection direction;
/// The distance about arrow for top and bottom
@property (nonatomic, assign) CGFloat horizontalLabelPadding;
/// The distance about arrow for left and right
@property (nonatomic, assign) CGFloat verticalLabelPadding;

/// The distance about arrow from self leading for SNAugusPopViewDirection bottom and top
@property (nonatomic, assign) CGFloat arrowHorizontalPadding;
/// The distance about arrow from self top for SNAugusPopViewDirection and right
@property (nonatomic, assign) CGFloat arrowVerticalPadding;
/// The bottom edge of the arrow
@property (nonatomic, assign) CGFloat arrowWidth;
/// The height of the arrow
@property (nonatomic, assign) CGFloat arrowHeight;

/// The text width of multiple lines
@property (nonatomic, assign) CGFloat mulLineWidth;
/// Close button attributes
@property (nonatomic, assign) CGFloat closeButtonleading;
@property (nonatomic, assign) CGFloat closeButtonWidth;
@property (nonatomic, assign) CGFloat closeButtonHeight;
/// The attibutes for multiple lines include close button
@property (nonatomic, assign) CGFloat closeButtonTopPadding;

/// LeftImageView
@property (nonatomic, copy) NSString *leftImageName;
@property (nonatomic, assign) CGFloat leftImageWidth;
@property (nonatomic, assign) CGFloat leftImageHeight;
/// The distance of lable horizontal
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
/// @param gradient The popView has gradient effect or not,you need to set about gradient attributes,eg gradientColors, or no working
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

@end

NS_ASSUME_NONNULL_END
