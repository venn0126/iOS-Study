//
//  FSCircleView.m
//  TestGuideLayout
//
//  Created by Augus on 2020/12/26.
//

#import "FSCircleView.h"


@interface FSCircleView ()

@property (nonatomic, weak) UILabel *cLabel;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;


@end

@implementation FSCircleView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, 200, 200);
        //默认颜色
        self.progerssBackgroundColor=[UIColor lightGrayColor];
        self.progerssColor=[UIColor blueColor];
        self.percentFontColor=[UIColor blueColor];
        //默认进度条宽度
        self.progerWidth=15;
        //默认百分比字体大小
        self.percentageFontSize=22;
        
        //百分比标签
        UILabel *cLabel = [[UILabel alloc] initWithFrame:self.bounds];
        cLabel.font = [UIFont boldSystemFontOfSize:self.percentageFontSize];
        cLabel.textColor = self.percentFontColor;
        cLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:cLabel];
        self.cLabel = cLabel;
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    _cLabel.text = [NSString stringWithFormat:@"%d%%", (int)floor(progress * 100)];
//    [self setNeedsDisplay];
    [self drawProgressInRect];
}


- (void)drawProgressInRect {
    
    
    
//    _startAngle = - M_PI_2;
//    _endAngle = _startAngle + _progress * M_PI * 2;
//
//    UIBezierPath *topPath = [UIBezierPath bezierPathWithArcCenter:_origin radius:_radius - _topWidth startAngle:_startAngle endAngle:_endAngle clockwise:YES];
//    _topLayer.path = topPath.CGPath;
    CGFloat startAngel = -M_PI_2;
    CGFloat endAngele = startAngel + self.progress * M_PI * 2;
    UIBezierPath *topPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:50 startAngle:startAngel endAngle:endAngele clockwise:YES];
    
    self.shapeLayer.path = (__bridge CGPathRef _Nullable)(topPath);


    
//    UIBezierPath *backgroundPath = [[UIBezierPath alloc] init];
//    //线宽
//    backgroundPath.lineWidth = self.progerWidth;
//    //颜色
//    [self.progerssBackgroundColor set];
//    //拐角
//    backgroundPath.lineCapStyle = kCGLineCapRound;
//    backgroundPath.lineJoinStyle = kCGLineJoinRound;
//    //半径
//    CGFloat radius = (MIN(self.bounds.size.width, self.bounds.size.height) - self.progerWidth) * 0.5;
//    //画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
//    [backgroundPath addArcWithCenter:(CGPoint){self.bounds.size.width * 0.5, self.bounds.size.height * 0.5} radius:radius startAngle:M_PI * 1.5 endAngle:M_PI * 1.5 + M_PI * 2  clockwise:YES];
//    //连线
//    [backgroundPath stroke];
    
    
}

/*
 

- (void)drawRect:(CGRect)rect
{
    
    //路径
    UIBezierPath *backgroundPath = [[UIBezierPath alloc] init];
    //线宽
    backgroundPath.lineWidth = self.progerWidth;
    //颜色
    [self.progerssBackgroundColor set];
    //拐角
    backgroundPath.lineCapStyle = kCGLineCapRound;
    backgroundPath.lineJoinStyle = kCGLineJoinRound;
    //半径
    CGFloat radius = (MIN(rect.size.width, rect.size.height) - self.progerWidth) * 0.5;
    //画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
    [backgroundPath addArcWithCenter:(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5} radius:radius startAngle:M_PI * 1.5 endAngle:M_PI * 1.5 + M_PI * 2  clockwise:YES];
    //连线
    [backgroundPath stroke];
    
    
    //路径
    UIBezierPath *progressPath = [[UIBezierPath alloc] init];
    //线宽
    progressPath.lineWidth = self.progerWidth;
    //颜色
    [self.progerssColor set];
    //拐角
    progressPath.lineCapStyle = kCGLineCapRound;
    progressPath.lineJoinStyle = kCGLineJoinRound;
    
    //画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
    [progressPath addArcWithCenter:(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5} radius:radius startAngle:M_PI * 1.5 endAngle:M_PI * 1.5 + M_PI * 2 * _progress clockwise:YES];
    //连线
    [progressPath stroke];
}
 
 */


#pragma mark - Lazy load

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        CAShapeLayer *shape = [CAShapeLayer layer];
        shape.lineWidth = 15;
        [self.layer addSublayer:shape];
        
        _shapeLayer = shape;
    }
    return _shapeLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
