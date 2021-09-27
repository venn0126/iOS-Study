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
static CGFloat kAugusPopViewHorizontalMargin = 10.0;
static CGFloat kAugusPopViewArrowWidth = 12.0;
static CGFloat kAugusPopViewArrowHeight = 12.0;


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
    _horizontalMargin = kAugusPopViewHorizontalMargin;
    _text = text;
    
    // UIView(maskLayer) + label
    
    [self setupUI];
    
    return self;
}

#pragma mark - Set up UI

- (void)setupUI {
    
    CGRect rect = self.bounds;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    if (width == 0 || height == 0) {
        width = [UIScreen mainScreen].bounds.size.width;
        height = 20;
    }
    
    [self addSubview:self.textLabel];
    
    
}

- (void)drawBackGroundLayerWithAnglePoint:(CGPoint)anglePoint {
    
    
    // BezierPath
    
    // CAShapeLayer
    
    // self.layer.mask = CAShapeLayer
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    switch (_direction) {
        case SNAugusPopViewDirectionUp:{
            
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
