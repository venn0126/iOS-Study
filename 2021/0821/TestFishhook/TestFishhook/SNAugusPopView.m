//
//  SNAugusPopView.m
//  com.sohu.news
//
//  Created by Augus on 2021/9/27.
//

#import "SNAugusPopView.h"
#import <objc/runtime.h>

#pragma mark - Some Constans

static CGFloat kAugusPopViewCornerRadius = 5.0;

static CGFloat kAugusBackgroundRed = 0.0;
static CGFloat kAugusBackgroundGreen = 0.0;
static CGFloat kAugusBackgroundBlue = 0.0;
static CGFloat kAugusBackgroundShowAlpha = 0.7;

static NSTimeInterval kAugusPopViewAnimationDuration = 3.0;
static NSTimeInterval kAugusPopViewDismissDuration = 0.3;
static NSTimeInterval kAugusPopViewShowDuration = 0.3;

static CGFloat kAugusPopViewLabelHorizontalPadding = 8.0;
static CGFloat kAugusPopViewLabelVerticalPadding = 8.0;

static CGFloat kAugusPopViewArrowWidth = 12.0;
static CGFloat kAugusPopViewArrowHeight = 7.0;
// (0,12]
static CGFloat kAugusArrowHorizontalPadding = 12.0;
static CGFloat kAugusArrowVerticalPadding = 3.0;

static CGFloat kAugusPopViewMulLineForWidth = 200.0;

static CGFloat kAugusCloseButtonLeading = 5.0;
static CGFloat kAugusCloseButtonWidth = 15.0;
static CGFloat kAugusCloseButtonHeight = 15.0;
static CGFloat kAugusCloseButtonTopPadding = 8.0;

static CGFloat kAugusLeftImageWidth = 15.0;
static CGFloat kAugusLeftImageHeight = 15.0;
static CGFloat kAugusLeftImageLabelPadding = 10.0;

static NSString *SNAugusBorderLayerKey = @"SNAugusBorderLayerKey";
static NSString *SNAugusBorderMaskName = @"SNAugusBorderMaskName";

@interface SNAugusPopView ()


/// The label show text.
@property (nonatomic, strong) UILabel *textLabel;
/// The popView is showing or not.
@property (nonatomic, assign) BOOL showing;
/// The popView's text is single or multiple.
@property (nonatomic, assign) BOOL singleLine;
/// The closeButton's name.
@property (nonatomic, copy) NSString *closeButtonName;
/// The closeButton custom.
@property (nonatomic, strong) UIButton *closeButton;
/// The leftImageView custom.
@property (nonatomic, strong) UIImageView *leftImageView;
/// The popView's gradient is effect or not.
@property (nonatomic, assign) BOOL gradient;


@end

@implementation SNAugusPopView

#pragma mark - Initalzation

- (instancetype)init {
    return [self initWithFrame:CGRectZero text:@"请阅读并勾选以下协议" direction:SNAugusPopViewDirectionTop singleLine:YES closeButtonName:@"" leftImageName:@"" gradient:NO];
}


- (instancetype)initWithCoder:(NSCoder *)coder {
    return [self initWithFrame:CGRectZero text:@"请阅读并勾选以下协议" direction:SNAugusPopViewDirectionTop singleLine:YES closeButtonName:@"" leftImageName:@"" gradient:NO];
}


- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame text:@"请阅读并勾选以下协议" direction:SNAugusPopViewDirectionTop singleLine:YES closeButtonName:@"" leftImageName:@"" gradient:NO];;
}


- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction
                   singleLine:(BOOL)singleLine
              closeButtonName:(NSString *)closeButtonName
                leftImageName:(NSString *)leftImageName
                     gradient:(BOOL)gradient{
    
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    // set defalut params
    _cornerRadius = kAugusPopViewCornerRadius;
    
    _animationDuration = kAugusPopViewAnimationDuration;
    _showDuration = kAugusPopViewShowDuration;
    _dismissDuration = kAugusPopViewDismissDuration;
    
    _labelHorizontalPadding = kAugusPopViewLabelHorizontalPadding;
    _labelVerticalPadding = kAugusPopViewLabelVerticalPadding;
    
    _arrowWidth = kAugusPopViewArrowWidth;
    _arrowHeight = kAugusPopViewArrowHeight;
    _arrowHorizontalPadding = kAugusArrowHorizontalPadding;
    _arrowVerticalPadding = kAugusArrowVerticalPadding;
    
    _mulLineWidth = kAugusPopViewMulLineForWidth;
    _closeButtonleading = kAugusCloseButtonLeading;
    _closeButtonWidth = kAugusCloseButtonWidth;
    _closeButtonTopPadding = kAugusCloseButtonTopPadding;
    _closeButtonHeight = kAugusCloseButtonHeight;
    _closeButtonBackgroundColor = UIColor.greenColor;
    
    _leftImageName = leftImageName;
    _leftImageWidth = kAugusLeftImageWidth;
    _leftImageHeight = kAugusLeftImageHeight;
    _leftImageLabelPadding = kAugusLeftImageLabelPadding;
    _leftImageBackgroundColor = UIColor.blueColor;
    
    // gradient
    _gradientColors = nil;
    _gradientStartPoint = CGPointMake(0, 0.5);
    _gradientEndPoint = CGPointMake(1, 0.5);
    _gradientLocations = @[@0.0,@1.0];
    _gradient = gradient;
    
    // border
    _borderWidth = 0.0;
    _borderColor = UIColor.clearColor;

    // background color
    _aBackgroundRed = kAugusBackgroundRed;
    _aBackgroundGreen = kAugusBackgroundGreen;
    _aBackgroundBlue = kAugusBackgroundBlue;
    _aBackgroundShowAlpha = kAugusBackgroundShowAlpha;
    
    // Text
    _textFont = [UIFont systemFontOfSize:13];
    _textAlignment = NSTextAlignmentCenter;
    _textColor = UIColor.whiteColor;
    
    
    _direction = direction;
    _text = text;
    _showing = NO;
    _singleLine = singleLine;
    _closeButtonName = closeButtonName;
    _leftImageName = leftImageName;
    
    // set up ui
    [self configurePopView];
    
    // add gesture to view
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction
                   singleLine:(BOOL)singleLine
              closeButtonName:(NSString *)closeButtonName
                     gradient:(BOOL)gradient {
    
    return [self initWithFrame:frame text:text direction:direction singleLine:singleLine closeButtonName:closeButtonName leftImageName:@"" gradient:gradient];
}


- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction
                   singleLine:(BOOL)singleLine
                leftImageName:(NSString *)leftImageName
                     gradient:(BOOL)gradient {
    
    return [self initWithFrame:frame text:text direction:direction singleLine:singleLine closeButtonName:@"" leftImageName:leftImageName gradient:gradient];
}


- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction
                   singleLine:(BOOL)singleLine
                     gradient:(BOOL)gradient {
    
    return [self initWithFrame:frame text:text direction:direction singleLine:singleLine closeButtonName:@"" leftImageName:@"" gradient:gradient];
}


- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    direction:(SNAugusPopViewDirection)direction
                     gradient:(BOOL)gradient {

    return [self initWithFrame:frame text:text direction:direction singleLine:YES closeButtonName:@"" leftImageName:@"" gradient:gradient];
    
}

#pragma mark - Setter

- (void)setTextFont:(UIFont *)textFont {
    
    _textFont = textFont;
    [self configurePopView];
}


- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.textLabel.textColor = _textColor;
}


- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    self.textLabel.textAlignment = _textAlignment;
}


- (void)setLabelHorizontalPadding:(CGFloat)labelHorizontalPadding {
    _labelHorizontalPadding = labelHorizontalPadding;
    [self configurePopView];

}


- (void)setLabelVerticalPadding:(CGFloat)labelVerticalPadding {
    _labelVerticalPadding = labelVerticalPadding;
    [self configurePopView];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self configurePopView];
}


- (void)setArrowWidth:(CGFloat)arrowWidth {
    _arrowWidth = arrowWidth;
    [self configurePopView];
}


- (void)setArrowHeight:(CGFloat)arrowHeight {
    _arrowHeight = arrowHeight;
    [self configurePopView];
}


- (void)setArrowHorizontalPadding:(CGFloat)arrowHorizontalPadding {
    _arrowHorizontalPadding = arrowHorizontalPadding;
    [self configurePopView];
}


- (void)setArrowVerticalPadding:(CGFloat)arrowVerticalPadding {
    _arrowVerticalPadding = arrowVerticalPadding;
    [self configurePopView];
}


- (void)setAnimationDuration:(NSTimeInterval)animationDuration {
    _animationDuration = animationDuration;
}


- (void)setShowDuration:(NSTimeInterval)showDuration {
    _showDuration = showDuration;
}


- (void)setDismissDuration:(NSTimeInterval)dismissDuration {
    _dismissDuration = dismissDuration;
}


- (void)setMulLineWidth:(CGFloat)mulLineWidth {
    _mulLineWidth = mulLineWidth;
    [self configurePopView];
}


- (void)setCloseButtonTopPadding:(CGFloat)closeButtonTopPadding {
    _closeButtonTopPadding = closeButtonTopPadding;
    [self configurePopView];
}


- (void)setCloseButtonHeight:(CGFloat)closeButtonHeight {
    _closeButtonHeight = closeButtonHeight;
    [self configurePopView];
}


- (void)setLeftImageName:(NSString *)leftImageName {
    _leftImageName = leftImageName;
    [self configurePopView];
}


- (void)setLeftImageWidth:(CGFloat)leftImageWidth {
    _leftImageWidth = leftImageWidth;
    [self configurePopView];
}


- (void)setLeftImageHeight:(CGFloat)leftImageHeight {
    _leftImageHeight = leftImageHeight;
    [self configurePopView];
}


- (void)setABackgroundRed:(CGFloat)aBackgroundRed {
    _aBackgroundRed = aBackgroundRed;
}


- (void)setABackgroundGreen:(CGFloat)aBackgroundGreen {
    _aBackgroundGreen = aBackgroundGreen;
}


- (void)setABackgroundBlue:(CGFloat)aBackgroundBlue {
    _aBackgroundBlue = aBackgroundBlue;
}

- (void)setABackgroundShowAlpha:(CGFloat)aBackgroundShowAlpha {
    _aBackgroundShowAlpha = aBackgroundShowAlpha;
}


- (void)setLeftImageLabelPadding:(CGFloat)leftImageLabelPadding {
    _leftImageLabelPadding = leftImageLabelPadding;
    [self configurePopView];
}


- (void)setGradientColors:(NSArray *)gradientColors {
    _gradientColors = gradientColors;
    [self configurePopView];
}


- (void)setGradientStartPoint:(CGPoint)gradientStartPoint {
    _gradientStartPoint = CGPointMake(gradientStartPoint.x, gradientStartPoint.y);
    [self configurePopView];
}


- (void)setGradientEndPoint:(CGPoint)gradientEndPoint {
    _gradientEndPoint = CGPointMake(gradientEndPoint.x, gradientEndPoint.y);
    [self configurePopView];
}


- (void)setGradientLocations:(NSArray<NSNumber *> *)gradientLocations {
    _gradientLocations = gradientLocations;
    [self configurePopView];
}


- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self configurePopView];
}


- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self configurePopView];
}


- (void)setCloseButtonBackgroundColor:(UIColor *)closeButtonBackgroundColor {
    _closeButtonBackgroundColor = closeButtonBackgroundColor;
    self.closeButton.backgroundColor = _closeButtonBackgroundColor;
}


- (void)setLeftImageBackgroundColor:(UIColor *)leftImageBackgroundColor {
    
    _leftImageBackgroundColor = leftImageBackgroundColor;
    self.leftImageView.backgroundColor = _leftImageBackgroundColor;
}

#pragma mark - Set up UI

- (void)configurePopView {
    
    self.textLabel.text = self.text;
    self.textLabel.font = self.textFont;
    self.textLabel.textAlignment = self.textAlignment;
    self.textLabel.textColor = self.textColor;
  
    // cwidth depend on text and font
    CGFloat cWidth = self.textWidth + 2 * self.labelHorizontalPadding;
    CGFloat cHeight = self.textHeight + 2 * self.labelVerticalPadding;
    
    
    // left image name
    // default support single line + left image
    if (self.leftImageName.length > 0 && self.singleLine) {
        self.leftImageView.image = [UIImage imageNamed:self.leftImageName];
        CGFloat y = (cHeight - self.leftImageHeight) * 0.5;
        self.leftImageView.frame = CGRectMake(self.labelHorizontalPadding, y, self.leftImageWidth, self.leftImageHeight);
        
        cWidth += self.leftImageView.frame.size.width + self.leftImageLabelPadding;
        [self addSubview:self.leftImageView];
    }
    
    // add textLabel depend on leftImageView
    [self addSubview:self.textLabel];
    
    if (self.direction == SNAugusPopViewDirectionTop || self.direction == SNAugusPopViewDirectionBottom) {
        cHeight = cHeight + self.arrowHeight;
    } else if(self.direction == SNAugusPopViewDirectionLeft || self.direction == SNAugusPopViewDirectionRight) {
        cWidth = cWidth + self.arrowHeight;
    }
    
    // single line & mul line
    if (self.singleLine) { // single line
        CGFloat x = self.labelHorizontalPadding;
        if (self.leftImageView.frame.origin.x > 0) {
            x = self.leftImageView.frame.origin.x + self.leftImageView.frame.size.width + self.leftImageLabelPadding;
        }
        self.textLabel.frame = CGRectMake(x, self.labelVerticalPadding,self.textWidth, self.textHeight);
    } else {// mul lines
        // set width
        self.textLabel.numberOfLines = 0;
        self.textLabel.frame = CGRectMake(self.labelHorizontalPadding, self.labelVerticalPadding * 0.5, self.mulLineWidth, self.mulLineTextHeight);
        cWidth = self.mulLineWidth + 2 * self.labelHorizontalPadding;
        cHeight = self.mulLineTextHeight + 2 * self.labelVerticalPadding;
        
    }
    
    
    // close button
    if (self.closeButtonName.length > 0) {
        
        if (self.singleLine) {
            CGFloat y = (cHeight - self.closeButtonWidth - self.arrowHeight) * 0.5;
            self.closeButton.frame = CGRectMake(self.textLabel.frame.origin.x + self.textLabel.frame.size.width + self.closeButtonleading, y, self.closeButtonWidth, self.closeButtonHeight);

        } else {
            CGFloat mulY = (cHeight - self.mulLineTextHeight - self.arrowHeight) * 0.5;
            self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, mulY, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
            self.closeButton.frame = CGRectMake(self.textLabel.frame.origin.x + self.textLabel.frame.size.width + self.closeButtonleading, self.closeButtonTopPadding, self.closeButtonWidth, self.closeButtonHeight);
        }
        
        cWidth += self.closeButton.frame.size.width + self.closeButtonleading;
        [self addSubview:self.closeButton];
    }
    
    // update self frame
    self.bounds = CGRectMake(0, 0, cWidth,cHeight);
    self.hidden = YES;
    
    // draw background mask
    CGFloat offset = 0;
    if (self.direction == SNAugusPopViewDirectionTop || self.direction == SNAugusPopViewDirectionBottom) {
        offset = self.arrowHorizontalPadding + self.arrowWidth * 0.5;
    } else if(self.direction == SNAugusPopViewDirectionLeft || self.direction == SNAugusPopViewDirectionRight) {
        offset = self.arrowVerticalPadding + self.arrowWidth * 0.5;
    }
    [self addArrowBorderoffset:offset width:self.arrowWidth height:self.arrowHeight cornerRadius:self.cornerRadius direction:self.direction];
    
}


#pragma mark - Size For Subview


- (CGFloat)mulLineTextHeight {
    
    if (self.text.length <= 0) {
        return 0;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:self.textLabel.font, NSParagraphStyleAttributeName:paragraphStyle};
    
    CGSize maxSize = CGSizeMake(self.mulLineWidth, CGFLOAT_MAX);
    CGSize size = [self.text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    return  ceil(size.height);
}


- (CGFloat)textHeight {
    
    if (self.text.length <= 0) {
        return 0;
    }
    
    CGSize maxSize = CGSizeMake(self.maxWidth - kAugusPopViewLabelHorizontalPadding * 2, CGFLOAT_MAX);
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.textLabel.font,NSFontAttributeName, nil];
    CGSize size = [self.text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    return size.height;
}

- (CGFloat)textWidth {
    
    if (self.text.length <= 0) {
        return 0;
    }
    
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, self.bounds.size.height);
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.textLabel.font,NSFontAttributeName, nil];
    CGSize size = [self.text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    return size.width;
}

-(CGFloat)maxWidth {
    return self.bounds.size.width;
}


 #pragma mark - Draw Background Layer

/// Add border with arrow for view
/// @param offset arrow's origin,if left and right pass y of center,or pass x of center
/// @param width  The width of arrow.
/// @param height The height of arrow.
/// @param cornerRadius  The corner radius, if cornerRadius <= 0 is none.
/// @param direction direction of arrow
-(void)addArrowBorderoffset:(CGFloat)offset
                      width:(CGFloat)width
                     height:(CGFloat)height
               cornerRadius:(CGFloat)cornerRadius direction:(SNAugusPopViewDirection)direction{
    
    [self removeSomeLayer];
    
    // Only a mask layer
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    mask.frame = self.bounds;
    mask.name = SNAugusBorderMaskName;
    self.layer.mask = mask;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    CGFloat minX = 0, minY = 0, maxX = self.bounds.size.width, maxY = self.bounds.size.height;
    if (direction == SNAugusPopViewDirectionTop) {
        minY = height;
        self.textLabel.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5 + height * 0.5);
    }else if (_direction == SNAugusPopViewDirectionRight){
        maxX -= height;
        self.textLabel.center = CGPointMake(self.bounds.size.width * 0.5 - height * 0.5, self.bounds.size.height * 0.5);
    }else if (_direction == SNAugusPopViewDirectionLeft){
        minX += height;
        self.textLabel.center = CGPointMake(self.bounds.size.width * 0.5 + height * 0.5, self.bounds.size.height * 0.5);
    }else if (_direction == SNAugusPopViewDirectionBottom){
        maxY -= height;
    } else {
        self.textLabel.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    }
    
    // top line
    [path moveToPoint:CGPointMake(minX + cornerRadius, minY)];

    // top arrow
    if (direction == SNAugusPopViewDirectionTop) {
        [path addLineToPoint:CGPointMake(offset- width * 0.5, minY)];
        [path addLineToPoint:CGPointMake(offset, minY - height)];
        [path addLineToPoint:CGPointMake(offset + width * 0.5, minY)];
        
    }
    [path addLineToPoint:CGPointMake(maxX-cornerRadius, minY)];

    
    // right and top corner radius
    if (cornerRadius > 0) {
        [path addArcWithCenter:CGPointMake(maxX - cornerRadius, minY + cornerRadius) radius:cornerRadius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    }
    
    
    // right arrow
    if (direction == SNAugusPopViewDirectionRight) {
        [path addLineToPoint:CGPointMake(maxX, offset - width * 0.5)];
        [path addLineToPoint:CGPointMake(maxX + height, offset)];
        [path addLineToPoint:CGPointMake(maxX, offset + width * 0.5)];
    }
    [path addLineToPoint:CGPointMake(maxX, maxY - cornerRadius)];
    
    // right and bottom corner radius
    if (cornerRadius > 0) {
        [path addArcWithCenter:CGPointMake(maxX - cornerRadius, maxY - cornerRadius) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    }
    
    // bottom arrow
    if (direction == SNAugusPopViewDirectionBottom) {
        [path addLineToPoint:CGPointMake(offset + width * 0.5, maxY)];
        [path addLineToPoint:CGPointMake(offset, maxY + height)];
        [path addLineToPoint:CGPointMake(offset - width * 0.5, maxY)];
    }
    [path addLineToPoint:CGPointMake(minX + cornerRadius, maxY)];
    
    // left and bottom corner radius
    if (cornerRadius > 0) {
        [path addArcWithCenter:CGPointMake(minX + cornerRadius, maxY - cornerRadius) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    }
    
    
    // left arrow
    if (direction == SNAugusPopViewDirectionLeft) {
        [path addLineToPoint:CGPointMake(minX, offset + width * 0.5)];
        [path addLineToPoint:CGPointMake(minX-height, offset)];
        [path addLineToPoint:CGPointMake(minX, offset - width * 0.5)];
    }
    [path addLineToPoint:CGPointMake(minX, minY+cornerRadius)];
    
    // left and top corner radius
    if (cornerRadius > 0) {
        [path addArcWithCenter:CGPointMake(minX+cornerRadius, minY+cornerRadius) radius:cornerRadius startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    }
    
    mask.path = [path CGPath];
    
    // Shadow attributes
    if (self.borderWidth > 0) {
        CAShapeLayer *border = [[CAShapeLayer alloc] init];
        border.path = [path CGPath];
        border.strokeColor = self.borderColor.CGColor;
        border.lineWidth = self.borderWidth;
        border.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:border];
        [self markSomeLayer:border];
    }
    
    // Gradient effect
    if (self.gradient) {
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.bounds;
        gradient.colors = self.gradientColors;
        // gradient line from start to end
        gradient.startPoint = CGPointMake(self.gradientStartPoint.x, self.gradientStartPoint.y);

        gradient.endPoint = CGPointMake(self.gradientEndPoint.x, self.gradientEndPoint.y);
        // gradient location area,default 0-1
        gradient.locations = self.gradientLocations;
        
        //    gradient.locations = @[@(0.5f), @(1.0f)];
        //    [self.layer addSublayer:gradient];
        [self.layer insertSublayer:gradient atIndex:0];
        [self markSomeLayer:gradient];
    }
    
}

-(void)markSomeLayer:(CALayer *)layer{
    
    objc_setAssociatedObject(self, &SNAugusBorderLayerKey, layer, OBJC_ASSOCIATION_RETAIN);
}

-(void)removeSomeLayer {
    if ([self.layer.mask.name isEqualToString:SNAugusBorderMaskName]) {
        self.layer.mask = nil;
    }
    
    CAShapeLayer *oldLayer = objc_getAssociatedObject(self, &SNAugusBorderLayerKey);
    if (oldLayer) [oldLayer removeFromSuperlayer];
    
}


#pragma mark - Animation Methods

- (void)show {
    
//    if (self.showing) {
//        return;
//    }
    
    self.transform = CGAffineTransformMakeScale(0.01,0.01);
//    self.alpha = 0.01;
    self.backgroundColor = [UIColor colorWithRed:self.aBackgroundRed green:self.aBackgroundGreen blue:self.aBackgroundBlue alpha:0.01];

    
    if (self.direction == SNAugusPopViewDirectionTop) {
        self.layer.anchorPoint = CGPointMake(0.1, 0.1);
    }else if(self.direction == SNAugusPopViewDirectionBottom) {
        self.layer.anchorPoint = CGPointMake(0.1, 0.8);
    }else if(self.direction == SNAugusPopViewDirectionRight) {
        self.layer.anchorPoint = CGPointMake(1, 0.5);
    }else if(self.direction == SNAugusPopViewDirectionLeft) {
        self.layer.anchorPoint = CGPointMake(0.0, 0.5);
    } else {
        self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    }
    
    CGFloat duration = self.animationDuration > 0 ? self.animationDuration : kAugusPopViewAnimationDuration;
    CGFloat showDuration = self.showDuration > 0 ? self.showDuration : kAugusPopViewShowDuration;
        
    [UIView animateWithDuration:showDuration animations:^{
//        self.alpha = 0.7;
        self.backgroundColor = [UIColor colorWithRed:self.aBackgroundRed green:self.aBackgroundGreen blue:self.aBackgroundBlue alpha:self.aBackgroundShowAlpha];
        self.hidden = NO;

        self.transform = CGAffineTransformMakeScale(1, 1);
        self.showing = YES;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

//            [self dismiss];
            NSLog(@"finish show");
        });
        
    }];

}


- (void)dismiss {
    
    self.showing = NO;
    [UIView animateWithDuration:self.dismissDuration animations:^{
//        self.alpha = 0.01;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.01];

        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
//        [self removeAugusBorder];
//        [self removeFromSuperview];
        NSLog(@"finish dismiss");
    }];
}

- (void)showToView:(UIView *)toView {
    if (!toView) {
        return;
    }
    
    BOOL isContained = NO;
    for (UIView *subView in toView.subviews) {
        if ([subView isKindOfClass:[SNAugusPopView class]]) {
            isContained = YES;
        }
    }
    
    if (isContained) {
        return;
    }
    
    [toView addSubview:self];
    [self show];
}

#pragma mark - Tap Action

- (void)tapAction {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(augusPopViewClick:)]) {
        [self.delegate augusPopViewClick:self];
    }
}

- (void)closeButtonAction:(UIButton *)sender {
    [self dismiss];
}



#pragma mark - Lazy Load

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:13];
        _textLabel.textColor = UIColor.whiteColor;
        _textLabel.textAlignment = NSTextAlignmentCenter;
//        _textLabel.backgroundColor = UIColor.blackColor;
        [_textLabel sizeToFit];
        
    }
    return _textLabel;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _closeButton.backgroundColor = UIColor.greenColor;
    }
    return _closeButton;
}


- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.backgroundColor = UIColor.blueColor;
    }
    return _leftImageView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
