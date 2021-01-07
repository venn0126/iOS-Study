//
//  FSProcessView.m
//  TestGuideLayout
//
//  Created by Augus on 2020/12/29.
//

#import "FSProcessView.h"


static const CGFloat kDefaultLineWidth = 15.0f;

@interface FSProcessView ()

/** 进度显示 */
@property (nonatomic, strong) UILabel *progressLabel;
/** 底层显示层 */
@property (nonatomic, strong) CAShapeLayer *bottomLayer;
/** 顶层显示层 */
@property (nonatomic, strong) CAShapeLayer *topLayer;

@property (nonatomic, strong) CADisplayLink *playLink;


@end

@implementation FSProcessView{
    
    /** 原点 */
    CGPoint _origin;
    /** 半径 */
    CGFloat _radius;
    /** 起始 */
    CGFloat _startAngle;
    /** 结束 */
    CGFloat _endAngle;
    NSString *_baseStr;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame progress:0];
}

- (instancetype)initWithFrame:(CGRect)frame progress:(CGFloat)progress {
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
        _progress = progress;
        // about 1/3 animation
        _baseStr = @"0.33";

    }
    return self;
}

#pragma mark - Init subviews

- (void)setUI {
    
    [self.layer addSublayer:self.bottomLayer];
    [self.layer addSublayer:self.topLayer];
    [self addSubview:self.progressLabel];
    
    _origin = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    _radius = self.bounds.size.width / 2;
    
    UIBezierPath *bottomPath = [UIBezierPath bezierPathWithArcCenter:_origin radius:_radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    _bottomLayer.path = bottomPath.CGPath;
}

#pragma mark - Setter Method

- (void)setProgress:(CGFloat)progress {
    
    if (progress > 1) {
        return;
    }
    _progress = progress;
    _progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    
    _startAngle = - M_PI_2;
    _endAngle = _startAngle + _progress * M_PI * 2;
    
//    _topLayer.transform = CATransform3DMakeRotation(progress * 180.0 / M_PI , 0, 0, -1);
    
    
    UIBezierPath *topPath = [UIBezierPath bezierPathWithArcCenter:_origin radius:_radius startAngle:_startAngle endAngle:_endAngle clockwise:YES];
    _topLayer.path = topPath.CGPath;

}

- (void)setBottomColor:(UIColor *)bottomColor {
    _bottomColor = bottomColor;
    _bottomLayer.strokeColor = _bottomColor.CGColor;
}

- (void)setTopColor:(UIColor *)topColor {
    _topColor = topColor;
    _topLayer.strokeColor = _topColor.CGColor;
}

- (void)setProgressWidth:(CGFloat)progressWidth {
    
    _progressWidth = progressWidth;
    _topLayer.lineWidth = progressWidth;
    _bottomLayer.lineWidth = progressWidth;
}


#pragma mark - Privacy action

- (void)fos_updateProcess:(CADisplayLink *)sender {
    
    
    NSLog(@"fos_updateProcess---ssss");
    self.progress += 1/100.0f;
    // 保留两位小数
    
    if (self.playLink.paused) {
        self.playLink.paused = NO;
    }
    
    NSString *pro = [NSString stringWithFormat:@"%.2f",self.progress];
    if ([pro isEqualToString:_baseStr]) {
        self.playLink.paused = YES;
        if ([_baseStr isEqualToString:@"0.33"]) {
            _baseStr = @"0.66";
        }else {
            _baseStr = @"1.00";

        }
        if ([pro isEqualToString:@"1.00"]) {
            NSLog(@"stop---");
            [self stopProcessAnimation];
        }
    }
}


#pragma mark - Public action

- (void)startProcessAnimation {
    
    if (!_playLink) {
        _playLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(fos_updateProcess:)];
        [_playLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    _playLink.paused = NO;
}

- (void)stopProcessAnimation {
    
    if (_playLink) {
        _playLink.paused = YES;
        [_playLink invalidate];
        _playLink = nil;
        NSLog(@"stop link");
    }
}


#pragma mark - lazy load

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];
        _progressLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.textColor = [UIColor blackColor];
    }
    return _progressLabel;
}

- (CAShapeLayer *)bottomLayer {
    if (!_bottomLayer) {
        _bottomLayer = [CAShapeLayer layer];
        _bottomLayer.fillColor = [UIColor clearColor].CGColor;
        _bottomLayer.strokeColor = UIColor.redColor.CGColor;
        _bottomLayer.lineWidth = kDefaultLineWidth;
    }
    return _bottomLayer;
}

- (CAShapeLayer *)topLayer {
    if (!_topLayer) {
        _topLayer = [CAShapeLayer layer];
        _topLayer.lineCap = kCALineCapRound;
        _topLayer.fillColor = [UIColor clearColor].CGColor;
        _topLayer.strokeColor = [UIColor blueColor].CGColor;
        _topLayer.lineWidth = kDefaultLineWidth;

    }
    return _topLayer;
}


//- (CADisplayLink *)playLink {
//    if (!_playLink) {
//        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(fos_updateProcess:)];
//        [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//
//        _playLink = link;
//
//    }
//    return _playLink;
//}

- (void)dealloc {
    
    NSLog(@"dealloc link");
    [self stopProcessAnimation];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
