//
//  SNAugusPopView.m
//  TestFishhook
//
//  Created by Augus on 2021/9/27.
//

#import "SNAugusPopView.h"
#import <objc/runtime.h>

#pragma mark - Some Constans

static CGFloat kAugusPopViewCornerRadius = 5.0;
static NSTimeInterval kAugusPopViewAnimationDuration = 0.5;

static CGFloat kAugusPopViewLabelHorizontalPadding = 10.0;
static CGFloat kAugusPopViewLabelVerticalPadding = 6;

static CGFloat kAugusPopViewArrowWidth = 12.0;
static CGFloat kAugusPopViewArrowHeight = 7.0;
// (0,12]
static CGFloat kAugusPopViewMargin = 12.0;


static NSString *SNAugusBorderLayerKey = @"SNAugusBorderLayerKey";
static NSString *SNAugusBorderMaskName = @"SNAugusBorderMaskName";


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface SNAugusPopView ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, assign) BOOL isPopViewShow;

@end

@implementation SNAugusPopView

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text {
   
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    // set defalut params
    _cornerRadius = kAugusPopViewCornerRadius;
    _animationDuration = kAugusPopViewAnimationDuration;
    _aBackgroundColor = UIColor.blackColor;
    _direction = SNAugusPopViewDirectionTop;
    _textFont = [UIFont systemFontOfSize:18];
    _isPopViewShow = NO;
    
    
    _text = text;
    
    // set up ui
    [self setupUI];
    
    // draw background mask
    [self addArrowBorderoffset:(kAugusPopViewMargin + kAugusPopViewArrowWidth * 0.5) width:kAugusPopViewArrowWidth height:kAugusPopViewArrowHeight cornerRadius:kAugusPopViewCornerRadius direction:SNAugusPopViewDirectionTop];
    
    
    // add gesture to view
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    
    return self;
    
}

#pragma mark - Set up UI

- (void)setupUI {
    
    self.backgroundColor = self.aBackgroundColor;
    
//    CGFloat width = self.bounds.size.width;
//    CGFloat height = self.bounds.size.height;
    
    self.textLabel.text = self.text;
    self.textLabel.font = self.textFont;
//    CGFloat textY = (height - self.textHeight) * 0.5;
    self.textLabel.frame = CGRectMake(0, 0,self.textWidth, self.textHeight);
    [self addSubview:self.textLabel];
    
   
    // update self frame
    self.bounds = CGRectMake(0, 0, kAugusPopViewLabelHorizontalPadding * 2 + self.textWidth, self.textHeight);
    
    // update textlable center
    
    self.textLabel.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5 + 3.5);
    
    self.alpha = 0.01;
    
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
    return self.bounds.size.width <= 0 ? (kScreenWidth - 2 * 25) : self.bounds.size.width;
}


 #pragma mark - Draw Background Layer


/**
 给view添加一个带箭头的边框
 
 @param direction 箭头朝向
 @param offset 箭头的坐标，如果是在左右朝向，传箭头中心位置的y值；如果是上下朝向，传箭头中心位置x值
 @param width 箭头的宽度
 @param height 箭头的高度
 @param cornerRadius 圆角半径，<=0不设圆角

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
    }else if (_direction == SNAugusPopViewDirectionRight){
        maxX -= height;
    }else if (_direction == SNAugusPopViewDirectionLeft){
        minX += height;
    }else if (_direction == SNAugusPopViewDirectionBottom){
        maxY -= height;
    }
    
    //上边
    [path moveToPoint:CGPointMake(minX + cornerRadius, minY)];
    if (direction == SNAugusPopViewDirectionTop) {
        [path addLineToPoint:CGPointMake(offset- width * 0.5, minY)];
        [path addLineToPoint:CGPointMake(offset, minY - height)];
        [path addLineToPoint:CGPointMake(offset + width * 0.5, minY)];
    }
    [path addLineToPoint:CGPointMake(maxX-cornerRadius, minY)];
    
    //右上角
    if (cornerRadius > 0) {
        [path addArcWithCenter:CGPointMake(maxX - cornerRadius, minY + cornerRadius) radius:cornerRadius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    }
    
    
    //右边
    if (direction == SNAugusPopViewDirectionRight) {
        [path addLineToPoint:CGPointMake(maxX, offset - width * 0.5)];
        [path addLineToPoint:CGPointMake(maxX + height, offset)];
        [path addLineToPoint:CGPointMake(maxX, offset + width * 0.5)];
    }
    [path addLineToPoint:CGPointMake(maxX, maxY - cornerRadius)];
    
    //右下角
    if (cornerRadius > 0) {
        [path addArcWithCenter:CGPointMake(maxX - cornerRadius, maxY - cornerRadius) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    }
    
    
    
    //下边
    if (direction == SNAugusPopViewDirectionBottom) {
        [path addLineToPoint:CGPointMake(offset - width  * 0.5, maxY)];
        [path addLineToPoint:CGPointMake(offset, maxY + height)];
        [path addLineToPoint:CGPointMake(offset + width * 0.5, maxY)];
    }
    [path addLineToPoint:CGPointMake(minX + cornerRadius, maxY)];
    
    //左下角
    if (cornerRadius>0) {
        [path addArcWithCenter:CGPointMake(minX + cornerRadius, maxY - cornerRadius) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    }
    
    
    //右边
    if (direction == SNAugusPopViewDirectionLeft) {
        [path addLineToPoint:CGPointMake(minX, offset-width/2)];
        [path addLineToPoint:CGPointMake(minX-height, offset)];
        [path addLineToPoint:CGPointMake(minX, offset+width/2)];
    }
    [path addLineToPoint:CGPointMake(minX, minY+cornerRadius)];
    
    //右下角
    if (cornerRadius>0) {
        [path addArcWithCenter:CGPointMake(minX+cornerRadius, minY+cornerRadius) radius:cornerRadius startAngle:M_PI endAngle:M_PI_2*3 clockwise:YES];
    }
    
    mask.path = [path CGPath];
    
//    if (borderWidth>0) {
        CAShapeLayer *border = [[CAShapeLayer alloc] init];
        border.path = [path CGPath];
//        border.strokeColor = borderColor.CGColor;
//        border.lineWidth = borderWidth*2;
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


#pragma mark - Animation

- (void)show {
    
    self.transform = CGAffineTransformMakeScale(0.01,0.01);
    self.alpha = 0.01;
    
    if (self.direction == SNAugusPopViewDirectionTop) {
        self.layer.anchorPoint = CGPointMake(0.1, 0.1);
    }
    
//    NSLog(@"00000");
    
//    if (self.isPopViewShow || self.alpha == 0.6) {
//        NSLog(@"1111");
//
//        return;
//    }
//    NSLog(@"222");

    
    self.isPopViewShow = YES;
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.alpha = 0.6;
        self.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (self.alpha > 0.01) {
                [self dismiss];
            }
        });
        
    }];
    
    
    
}


- (void)dismiss {
    
    self.isPopViewShow = NO;
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.alpha = 0.01;
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
//        [self removeAugusBorder];
        
    }];
}

#pragma mark - Tap Action

- (void)tapAction {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapGesturePopView)]) {
        
        [self.delegate tapGesturePopView];
    }
}




#pragma mark - Lazy Load

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:16];
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
