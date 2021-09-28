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
static NSTimeInterval kAugusPopViewAnimationDuration = 0.54;
static CGFloat kAugusPopViewLabelHorizontalPadding = 10.0;
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
    _direction = SNAugusPopViewDirectionUp;
    _borderWidth = 1.0;
    _borderColor = UIColor.yellowColor;
    
    
    _text = text;
    
    // set up ui
    [self setupUI];
    
    // draw background mask
//    [self drawBackGroundLayerWithAnglePoint:CGPointMake(kAugusPopViewArrowWidth * 0.5 + kAugusPopViewMargin, -kAugusPopViewArrowHeight)];
    
    [self addArrowBorderoffset:(kAugusPopViewMargin + kAugusPopViewArrowWidth * 0.5) width:kAugusPopViewArrowWidth height:kAugusPopViewArrowHeight cornerRadius:kAugusPopViewCornerRadius direction:SNAugusPopViewDirectionUp];
    
    return self;
    
}

#pragma mark - Set up UI

- (void)setupUI {
    
    self.backgroundColor = self.aBackgroundColor;
    
//    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    self.textLabel.text = self.text;
//    CGFloat x =
    self.textLabel.frame = CGRectMake(kAugusPopViewLabelHorizontalPadding, 0,self.textWidth, height);
    [self addSubview:self.textLabel];
    // update self frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, kAugusPopViewLabelHorizontalPadding * 2 + self.textWidth, height);
    
    self.alpha = 0.6;
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

- (void)drawBackGroundLayerWithAnglePoint:(CGPoint)anglePoint {
    
    
    // BezierPath
    
    // CAShapeLayer
    
    // self.layer.mask = CAShapeLayer
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    switch (_direction) {
        case SNAugusPopViewDirectionUp:{
            
            // add origin point
            [path moveToPoint:CGPointMake(0, 0)];
            // add left 1
            [path addLineToPoint:CGPointMake(kAugusPopViewMargin, 0)];
            // add top points
            [path addLineToPoint:CGPointMake(kAugusPopViewMargin + kAugusPopViewArrowWidth * 0.5, -kAugusPopViewArrowHeight)];
            //
            [path addLineToPoint:CGPointMake(kAugusPopViewMargin + kAugusPopViewArrowWidth, 0)];
//            [path addArcWithCenter:CGPointMake(width - kAugusPopViewCornerRadius, kAugusPopViewCornerRadius) radius:kAugusPopViewCornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
            
            [path addLineToPoint:CGPointMake(width, 0)];
            [path addLineToPoint:CGPointMake(width, height)];
            [path addLineToPoint:CGPointMake(0, height)];
            [path addLineToPoint:CGPointMake(0, 0)];
            [path closePath];
            
        }break;
        case SNAugusPopViewDirectionDown:{
            
        }break;
        default:
            break;
    }
    
 
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    shape.lineWidth = 2.0;
    shape.fillColor = [UIColor blackColor].CGColor;
//    shape.strokeColor = UIColor.redColor.CGColor;
    [self.layer insertSublayer:shape atIndex:0];

}

-(void)addArrowBorderoffset:(CGFloat)offset
                      width:(CGFloat)width
                     height:(CGFloat)height
               cornerRadius:(CGFloat)cornerRadius direction:(SNAugusPopViewDirection)direction{
    
    [self removeFCBorder];
    
    //只有一个mask层
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    mask.frame = self.bounds;
    mask.name = SNAugusBorderMaskName;
    self.layer.mask = mask;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    CGFloat minX = 0, minY = 0, maxX = self.bounds.size.width, maxY = self.bounds.size.height;
    if (direction == SNAugusPopViewDirectionUp) {
        minY = height;
    }else if (_direction == SNAugusPopViewDirectionRight){
        maxX -= height;
    }else if (_direction == SNAugusPopViewDirectionLeft){
        minX += height;
    }else if (_direction == SNAugusPopViewDirectionDown){
        maxY -= height;
    }
    
    //上边
    [path moveToPoint:CGPointMake(minX+cornerRadius, minY)];
    if (direction == SNAugusPopViewDirectionUp) {
        [path addLineToPoint:CGPointMake(offset-width/2, minY)];
        [path addLineToPoint:CGPointMake(offset, minY-height)];
        [path addLineToPoint:CGPointMake(offset+width/2, minY)];
    }
    [path addLineToPoint:CGPointMake(maxX-cornerRadius, minY)];
    
    //右上角
    if (cornerRadius>0) {
        [path addArcWithCenter:CGPointMake(maxX-cornerRadius, minY+cornerRadius) radius:cornerRadius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    }
    
    
    
    //右边
    if (direction == SNAugusPopViewDirectionRight) {
        [path addLineToPoint:CGPointMake(maxX, offset-width/2)];
        [path addLineToPoint:CGPointMake(maxX+height, offset)];
        [path addLineToPoint:CGPointMake(maxX, offset+width/2)];
    }
    [path addLineToPoint:CGPointMake(maxX, maxY-cornerRadius)];
    
    //右下角
    if (cornerRadius>0) {
        [path addArcWithCenter:CGPointMake(maxX-cornerRadius, maxY-cornerRadius) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    }
    
    
    
    //下边
    if (direction == SNAugusPopViewDirectionDown) {
        [path addLineToPoint:CGPointMake(offset-width/2, maxY)];
        [path addLineToPoint:CGPointMake(offset, maxY+height)];
        [path addLineToPoint:CGPointMake(offset+width/2, maxY)];
    }
    [path addLineToPoint:CGPointMake(minX+cornerRadius, maxY)];
    
    //左下角
    if (cornerRadius>0) {
        [path addArcWithCenter:CGPointMake(minX+cornerRadius, maxY-cornerRadius) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
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
//        CAShapeLayer *border = [[CAShapeLayer alloc] init];
//        border.path = [path CGPath];
//        border.strokeColor = borderColor.CGColor;
//        border.lineWidth = borderWidth*2;
//        border.fillColor = [UIColor clearColor].CGColor;
//        [self.layer addSublayer:border];
//
//        [self markFCBorder:border];
//    }
}

-(void)markFCBorder:(CALayer *)layer{
    
    objc_setAssociatedObject(self, &SNAugusBorderLayerKey, layer, OBJC_ASSOCIATION_RETAIN);
}

-(void)removeFCBorder{
    if ([self.layer.mask.name isEqualToString:SNAugusBorderMaskName]) {
        self.layer.mask = nil;
    }
    
    CAShapeLayer *oldLayer = objc_getAssociatedObject(self, &SNAugusBorderLayerKey);
    if (oldLayer) [oldLayer removeFromSuperlayer];
}


#pragma mark - Lazy Load

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:16];
        _textLabel.textColor = UIColor.whiteColor;
        _textLabel.textAlignment = NSTextAlignmentCenter;
//        _textLabel.backgroundColor = UIColor.redColor;
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
