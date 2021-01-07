//
//  FSRCAnimation.m
//  TestGuideLayout
//
//  Created by Augus on 2020/12/28.
//

#import "FSRCAnimation.h"

#define screen_w [UIScreen mainScreen].bounds.size.width
#define screen_h [UIScreen mainScreen].bounds.size.height

static const CGFloat square_w = 288.0;
static const CGFloat kSquareTop = 135.0f;

@interface FSRCAnimation ()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *rectShapeLayer;
// 提示文本底层layer
@property (nonatomic, strong) CAShapeLayer *tipMaskLayer;


@end

@implementation FSRCAnimation{
    
    CAShapeLayer *_scanWindowLayer;
    CAShapeLayer *_fillLayer;
    UIBezierPath *_outMaskPath;
    
    // 转动外圈layer
    CAShapeLayer *_outClockLayer;
    // 转动内圈
    CAShapeLayer *_interClockLayer;
    
}

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.bounds = CGRectMake(0, 0,screen_w,screen_h);
        self.backgroundColor = UIColor.clearColor;
        [self setupSubviews];
    }
    return self;
}

// set up ui
- (void)setupSubviews {
    
    
    CGFloat x = (screen_w - square_w) * 0.5;
//
//    _scanWindowLayer = [CAShapeLayer layer];
////    _scanWindowLayer.position = self.layer.position;
//
//    _scanWindowLayer.frame = CGRectMake(x, kSquareTop, square_w, square_w);
//    _scanWindowLayer.cornerRadius = 15;
//    _scanWindowLayer.borderColor = [UIColor greenColor].CGColor;
//    _scanWindowLayer.borderWidth = 1.5;
//    [self.layer addSublayer:_scanWindowLayer];
    
        
    // 最里面镂空
    UIBezierPath *transparentRoundedRectPath = [UIBezierPath bezierPathWithRect:CGRectMake(x, kSquareTop, square_w, square_w)];
//
//    //最外层背景
    if (!_outMaskPath) {
        _outMaskPath = [UIBezierPath bezierPathWithRect:self.frame];
        [_outMaskPath setUsesEvenOddFillRule:YES];
    }
    [_outMaskPath appendPath:transparentRoundedRectPath];

    if (!_fillLayer) {
        _fillLayer = [CAShapeLayer layer];
        _fillLayer.fillRule = kCAFillRuleEvenOdd;
        _fillLayer.fillColor = [UIColor blackColor].CGColor;
        _fillLayer.opacity = .6f;
    }
    _fillLayer.path = _outMaskPath.CGPath;
    [self.layer addSublayer:_fillLayer];
    
}

- (void)fos_startAnmaiton {
    [self fosStartConverset];
        
    
}

- (void)fosStartConverset {
    
    CFTimeInterval duration = 1.0f;
    
    //  一边切圆角一边修改bouse
//    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
//    animation1.toValue = @(square_w * 0.5);
//    animation1.duration = duration;
//    animation1.removedOnCompletion = NO;
//    animation1.fillMode = kCAFillModeForwards;
//    [_scanWindowLayer addAnimation:animation1 forKey:nil];
    
    UIBezierPath *transparentRoundedRectPath2 = [UIBezierPath bezierPathWithRect:_scanWindowLayer.frame];
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRect:self.frame];
    [path2 setUsesEvenOddFillRule:YES];
    [path2 appendPath:transparentRoundedRectPath2];
    _fillLayer.path = path2.CGPath;
    
    UIBezierPath *transparentRoundedRectPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(screen_w * 0.5,square_w) radius:square_w * 0.5 startAngle:0 endAngle:2 * M_PI clockwise:YES];

    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.frame];
    [path setUsesEvenOddFillRule:YES];
    [path appendPath:transparentRoundedRectPath];
    _fillLayer.path = path.CGPath;

    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation3.fromValue = path2;
    animation3.toValue = path;
//    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animation3.duration = duration;
    animation3.delegate = self;

    [_fillLayer addAnimation:animation3 forKey:nil];
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        
        // 完成
        NSLog(@"finish aaaa");
        
        [self fos_startClockAnimation];
        
    }
}


- (void)fos_startClockAnimation {
    
    
    /*
     position.x = frame.origin.x + 0.5 * bounds.size.width；
     position.y = frame.origin.y + 0.5 * bounds.size.height；
     */
    
    [self tipMaskLayer];
    
    // 已知内圆的中心点
    CGFloat fillX = screen_w * 0.5;
    CGFloat fillY = square_w * 0.5 + kSquareTop;

    CGFloat kOutHeight = 350.f;
    CFTimeInterval time = 3;
    if (!_outClockLayer) {
        _outClockLayer = [CAShapeLayer layer];
        _outClockLayer.frame = CGRectMake(0, 0, kOutHeight, kOutHeight);
        _outClockLayer.position = CGPointMake(fillX, fillY + 8);
        _outClockLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"detect_process_out_circle"].CGImage);
    }

    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basic.fromValue = [NSNumber numberWithFloat:0.f];
    basic.toValue = [NSNumber numberWithFloat:M_PI * 2];
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    basic.duration = time;
    basic.fillMode = kCAFillModeForwards;
    basic.removedOnCompletion = NO; //动画后是否回到最初状态（配合kCAFillModeForwards使用）
    basic.repeatCount = MAXFLOAT;

    [_outClockLayer addAnimation:basic forKey:nil];


    if (!_interClockLayer) {
        _interClockLayer = [CAShapeLayer layer];
        _interClockLayer.position = _fillLayer.position;
        // 521
        // 266
        CGFloat kInterHeight = 266.f;
        _interClockLayer.frame = CGRectMake(0, 0, kInterHeight, kInterHeight);
        _interClockLayer.position = CGPointMake(fillX, fillY + 10);
        _interClockLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"detect_process_face_ok"].CGImage);
    }

    CABasicAnimation *basic1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basic1.fromValue = [NSNumber numberWithFloat:M_PI * 2];
    basic1.toValue = [NSNumber numberWithFloat:0.f];
    basic1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    basic1.duration = time;
    basic1.fillMode = kCAFillModeForwards;
    basic1.removedOnCompletion = NO; //动画后是否回到最初状态（配合kCAFillModeForwards使用）
    basic1.repeatCount = MAXFLOAT;
    [_interClockLayer addAnimation:basic1 forKey:nil];
    
    [self.layer addSublayer:_outClockLayer];
    [self.layer addSublayer:_interClockLayer];
}

- (void)setAnimationHighlighted:(BOOL)animationHighlighted {
    _animationHighlighted = animationHighlighted;
    NSLog(@"set high");
    if (animationHighlighted) {
        _interClockLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"detect_process_face_error"].CGImage);
    } else {
        _interClockLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"detect_process_face_ok"].CGImage);
    }
    
}

#pragma mark - Lazy load

- (CAShapeLayer *)tipMaskLayer {
  
    
    // 添加提示文本底层色
    if (!_tipMaskLayer) {
        // 已知内圆的中心点
        CGFloat fillX = screen_w * 0.5;
        CGFloat fillY = square_w * 0.5 + kSquareTop;
        CAShapeLayer *shape  = [CAShapeLayer layer];
        //圆环的颜色
    //    layer.strokeColor = [UIColor clearColor].CGColor;
        //背景填充色 183 204 229
        shape.fillColor = [UIColor colorWithRed:183/255.0 green:204/255.0 blue:229/225.0 alpha:0.4].CGColor;
        CGFloat radius = 288 * 0.5;
        //初始化一个路径
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(fillX, fillY + 10) radius:radius startAngle:(1.2 * M_PI) endAngle:1.8 * M_PI clockwise:YES];
        
        shape.path = [path CGPath];
        [self.layer addSublayer:shape];
        
        _tipMaskLayer = shape;
    }
    return _tipMaskLayer;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
