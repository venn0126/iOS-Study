//
//  SNAugusPopView.m
//  TestFishhook
//
//  Created by Augus on 2021/9/27.
//

#import "SNAugusPopView.h"

#pragma mark - Some Constans

static CGFloat kAugusPopViewCornerRadius = 10.0;
static NSTimeInterval kAugusPopViewAnimationDuration = 0.2;
static CGFloat kAugusPopViewHorizontalPadding = 10.0;
static CGFloat kAugusPopViewArrowWidth = 24.0;
static CGFloat kAugusPopViewArrowHeight = 24.0;


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface SNAugusPopView ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation SNAugusPopView


- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // set defalut params
    _cornerRadius = kAugusPopViewCornerRadius;
    _animationDuration = kAugusPopViewAnimationDuration;
    _horizontalPadding = kAugusPopViewHorizontalPadding;
    _aBackgroundColor = UIColor.greenColor;
    _text = text;
    
    // frame
    
    // set up ui
    [self setupUI];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text {
   
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    // set defalut params
    _cornerRadius = kAugusPopViewCornerRadius;
    _animationDuration = kAugusPopViewAnimationDuration;
    _horizontalPadding = kAugusPopViewHorizontalPadding;
    _aBackgroundColor = UIColor.greenColor;
    _direction = SNAugusPopViewDirectionUp;
    _text = text;
    
    // set up ui
    [self setupUI];
    
    // draw background mask
    [self drawBackGroundLayerWithAnglePoint:CGPointMake(kAugusPopViewArrowWidth, -kAugusPopViewArrowHeight)];
    
    return self;
    
}

#pragma mark - Set up UI

- (void)setupUI {
    
    self.backgroundColor = self.aBackgroundColor;
    
//    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    self.textLabel.text = self.text;
//    CGFloat x =
    self.textLabel.frame = CGRectMake(kAugusPopViewHorizontalPadding, 0,self.textWidth, height);
    [self addSubview:self.textLabel];
    // update self frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, kAugusPopViewHorizontalPadding * 2 + self.textWidth, height);
    
}


#pragma mark - Size For Subview


- (CGFloat)textHeight {
    
    if (self.text.length <= 0) {
        return 0;
    }
    
    CGSize maxSize = CGSizeMake(self.maxWidth - kAugusPopViewHorizontalPadding * 2, CGFLOAT_MAX);
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
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    switch (_direction) {
        case SNAugusPopViewDirectionUp:{
            
            [path moveToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(kAugusPopViewArrowWidth, 0)];
            
        }break;
        case SNAugusPopViewDirectionDown:{
            
        }break;
        default:
            break;
    }
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = (__bridge CGPathRef _Nullable)(path);
    
    self.layer.mask = shape;
}

#pragma mark - Lazy Load

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:16];
        _textLabel.textColor = UIColor.whiteColor;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.backgroundColor = UIColor.redColor;
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
