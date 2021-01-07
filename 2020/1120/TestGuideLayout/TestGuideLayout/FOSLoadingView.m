//
//  FOSLoadingView.m
//  TestGuideLayout
//
//  Created by Augus on 2020/12/24.
//

#import "FOSLoadingView.h"

@interface FOSLoadingView ()

@property (nonatomic, strong) CALayer *backLayer;

@end

@implementation FOSLoadingView

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor greenColor];
        [self backLayer];
    }
    return self;
}



#pragma mark - Public

- (void)fos_startLoading {
    
    
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basic.fromValue = [NSNumber numberWithFloat:0];
    basic.toValue = [NSNumber numberWithFloat:6 * M_PI];
//    basic.autoreverses = YES;
    basic.repeatCount = MAXFLOAT;
    basic.duration = 2;
    basic.removedOnCompletion = NO;

    [self.backLayer addAnimation:basic forKey:nil];
    
}

- (void)fos_stopLoading {
    
    [self.backLayer removeAllAnimations];
}

#pragma mark - Lazy

- (CALayer *)backLayer {
    if (!_backLayer) {
        CALayer *back = [CALayer layer];
        back.backgroundColor = UIColor.lightGrayColor.CGColor;
        CGFloat backW = 110.f;
        CGFloat backRadius = 50;
        CGFloat backX = (self.bounds.size.width - 2 * backRadius) * 0.5;
        back.frame = CGRectMake(backX, backX, backW, backW);
        [self.layer addSublayer:back];
        _backLayer = back;
        
        
        //创建一个圆环
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(backW * 0.5, backW * 0.5) radius:backRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        
        //圆环遮罩
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        shapeLayer.lineWidth = 5;
        shapeLayer.strokeStart = 0;
        shapeLayer.strokeEnd = 0.8;
        shapeLayer.lineCap = @"round";
        shapeLayer.lineDashPhase = 0.8;
        shapeLayer.path = bezierPath.CGPath;
        
        //颜色渐变
        NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)[UIColor lightGrayColor].CGColor,(id)[UIColor whiteColor].CGColor,nil];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.shadowPath = bezierPath.CGPath;
        gradientLayer.frame = CGRectMake(50, 50, 60, 60);
        gradientLayer.startPoint = CGPointMake(0, 1);
        gradientLayer.endPoint = CGPointMake(1, 0);
        [gradientLayer setColors:[NSArray arrayWithArray:colors]];
        
        [back addSublayer:gradientLayer]; //设置颜色渐变
        [back setMask:shapeLayer]; //设置圆环遮罩
    }
    return _backLayer;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
