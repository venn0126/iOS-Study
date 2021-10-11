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
static NSTimeInterval kAugusPopViewAnimationDuration = 0.5;
static NSTimeInterval kAugusPopViewDismissDuration = 2.0;

static CGFloat kAugusPopViewLabelHorizontalPadding = 8.0;
static CGFloat kAugusPopViewLabelVerticalPadding = 8.0;

static CGFloat kAugusPopViewArrowWidth = 12.0;
static CGFloat kAugusPopViewArrowHeight = 7.0;
// (0,12]
static CGFloat kAugusArrowHorizontalPadding = 12.0;
//static CGFloat kAugusArrowVerticalPadding = 3.0;



static NSString *SNAugusBorderLayerKey = @"SNAugusBorderLayerKey";
static NSString *SNAugusBorderMaskName = @"SNAugusBorderMaskName";


@interface SNAugusPopView ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, assign) BOOL showing;

@end

@implementation SNAugusPopView

#pragma mark - Initalzation

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text direction:(SNAugusPopViewDirection)direction {
    
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    // set defalut params
    _cornerRadius = kAugusPopViewCornerRadius;
    _animationDuration = kAugusPopViewAnimationDuration;
    
    _aBackgroundColor = UIColor.blackColor;
    _direction = SNAugusPopViewDirectionTop;
    // Default font 18
    _textFont = [UIFont systemFontOfSize:13];
    
    _direction = direction;
    _text = text;
    _showing = NO;
    
    // set up ui
    [self configurePopView];
    
    // add gesture to view
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    
    return self;
    
}

#pragma mark - Setter

- (void)setTextFont:(UIFont *)textFont {
    
    _textFont = textFont;
    self.textLabel.font = _textFont;
    [self configurePopView];
}


- (void)setVerticalLabelPadding:(CGFloat)verticalLabelPadding {
    
    _verticalLabelPadding = verticalLabelPadding;
    [self configurePopView];
}


- (void)setHorizontalLabelPadding:(CGFloat)horizontalLabelPadding {
    _horizontalLabelPadding = horizontalLabelPadding;
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


- (void)setDismissDuration:(NSTimeInterval)dismissDuration {
    _dismissDuration = dismissDuration;
}

#pragma mark - Set up UI

- (void)configurePopView {
    
    self.backgroundColor = self.aBackgroundColor;
    
    self.textLabel.text = self.text;
    self.textLabel.font = self.textFont;
    
    CGFloat horizontalPadding = self.horizontalLabelPadding > 0 ? self.horizontalLabelPadding : kAugusPopViewLabelHorizontalPadding;
    CGFloat verticalPadding = self.verticalLabelPadding > 0 ? self.verticalLabelPadding : kAugusPopViewLabelVerticalPadding;
    
    CGFloat cornerRadius = self.cornerRadius > 0 ? self.cornerRadius : kAugusPopViewCornerRadius;
    
    CGFloat arrowHorizontalPadding = self.arrowHorizontalPadding > 0 ? self.arrowHorizontalPadding : kAugusArrowHorizontalPadding;
    CGFloat arrowVerticalPadding = self.arrowVerticalPadding > 0 ? self.arrowVerticalPadding : kAugusPopViewLabelVerticalPadding;
    
    CGFloat arrowWidth = self.arrowWidth > 0 ? self.arrowWidth : kAugusPopViewArrowWidth;
    CGFloat arrowHeight = self.arrowHeight > 0 ? self.arrowHeight : kAugusPopViewArrowHeight;
    
    CGFloat cWidth = self.textWidth + 2 * horizontalPadding;
    CGFloat cHeight = self.textHeight + 2 * verticalPadding;
    
    if (self.direction == SNAugusPopViewDirectionTop || self.direction == SNAugusPopViewDirectionBottom) {
        cHeight = cHeight + arrowHeight;
    } else if(self.direction == SNAugusPopViewDirectionLeft || self.direction == SNAugusPopViewDirectionRight) {
        cWidth = cWidth + arrowHeight;
    }
    
    
    self.textLabel.frame = CGRectMake(horizontalPadding, verticalPadding,self.textWidth, self.textHeight);
    [self addSubview:self.textLabel];
    
   
    // update self frame
    self.bounds = CGRectMake(0, 0, cWidth,cHeight);
    self.alpha = 0.01;
    
    
    // draw background mask
    CGFloat offset = 0;
    if (self.direction == SNAugusPopViewDirectionTop || self.direction == SNAugusPopViewDirectionBottom) {
        offset = arrowHorizontalPadding + arrowWidth * 0.5;
    } else if(self.direction == SNAugusPopViewDirectionLeft || self.direction == SNAugusPopViewDirectionRight) {
        offset = arrowVerticalPadding + arrowWidth * 0.5;
    }
    [self addArrowBorderoffset:offset width:arrowWidth height:arrowHeight cornerRadius:cornerRadius direction:self.direction];
    
}


#pragma mark - Size For Subview


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


/**
 Add border with arrow for view
 
 @param direction direction of arrow
 @param offset 箭头的坐标，如果是在左右朝向，传箭头中心位置的y值；如果是上下朝向，传箭头中心位置x值
 @param width The width of arrow.
 @param height The height of arrow.
 @param cornerRadius The corner radius, if cornerRadius <= 0 is none.

 */

-(void)addArrowBorderoffset:(CGFloat)offset
                      width:(CGFloat)width
                     height:(CGFloat)height
               cornerRadius:(CGFloat)cornerRadius direction:(SNAugusPopViewDirection)direction{
    
    [self removeAugusBorder];
    
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
    
    
    // right line
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
    
    
    // left line
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
    
    // shap layer
//    if (borderWidth>0) {
        CAShapeLayer *border = [[CAShapeLayer alloc] init];
        border.path = [path CGPath];
//        border.strokeColor = borderColor.CGColor;
//        border.lineWidth = 5;
        border.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:border];
//
        [self markFCBorder:border];
//    }
}

-(void)markFCBorder:(CALayer *)layer{
    
    objc_setAssociatedObject(self, &SNAugusBorderLayerKey, layer, OBJC_ASSOCIATION_RETAIN);
}

-(void)removeAugusBorder {
    if ([self.layer.mask.name isEqualToString:SNAugusBorderMaskName]) {
        self.layer.mask = nil;
    }
    
    CAShapeLayer *oldLayer = objc_getAssociatedObject(self, &SNAugusBorderLayerKey);
    if (oldLayer) [oldLayer removeFromSuperlayer];
}


#pragma mark - Animation Methods

- (void)show {
    
    if (self.showing) {
        return;
    }
    
    self.transform = CGAffineTransformMakeScale(0.01,0.01);
    self.alpha = 0.01;
    
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
    CGFloat dismissDuration = self.dismissDuration > 0 ? self.dismissDuration : kAugusPopViewDismissDuration;
        
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.6;
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.showing = YES;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(dismissDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

//            [self dismiss];
            NSLog(@"finish show");
        });
        
    }];

}


- (void)dismiss {
    
    self.showing = NO;
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.alpha = 0.01;
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




#pragma mark - Lazy Load

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:13];
        _textLabel.textColor = UIColor.whiteColor;
        _textLabel.textAlignment = NSTextAlignmentCenter;
//        _textLabel.backgroundColor = UIColor.whiteColor;
        [_textLabel sizeToFit];
        
    }
    return _textLabel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
