//
//  FSProcessBarView.m
//  TestGuideLayout
//
//  Created by Augus on 2021/1/4.
//

#import "FSProcessBarView.h"

@interface FSProcessBarView ()

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, strong) CADisplayLink *playLink;


@end

@implementation FSProcessBarView{
    
    CGFloat _ringWidth;
    CAShapeLayer *_backgroundMask;
    NSString *_baseStr;
    
}

#pragma mark - Init

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = UIColor.grayColor;
        _progress = 0.0;
        _ringWidth = 10.f;
        _baseStr = @"0.33";
        [self setupSubLayers];
        
    }
    return self;
}


- (void)setupSubLayers {
    
    _backgroundMask = [CAShapeLayer layer];
    _backgroundMask.path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.frame, _ringWidth * 0.5, _ringWidth * 0.5)].CGPath;
    _backgroundMask.lineWidth = _ringWidth;
    _backgroundMask.fillColor = nil;
    _backgroundMask.strokeColor = UIColor.blackColor.CGColor;
    self.layer.mask = _backgroundMask;
    
    [self progressLayer];
    self.progressLayer.lineWidth = _ringWidth;
    self.progressLayer.fillColor = nil;
    
    
    self.layer.transform = CATransform3DMakeRotation(90 * M_PI / 180.0, 0, 0, -1);
}


#pragma mark - Setter

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
    
}


#pragma mark - About UI


- (void)drawRect:(CGRect)rect {
    
//    CAShapeLayer *backgroundMask = [CAShapeLayer layer];
//    backgroundMask.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.height * 0.25].CGPath;
//    self.layer.mask = backgroundMask;
//
//
//    CGRect progessRect = CGRectMake(0, 0, rect.size.width * self.progress, rect.size.height);
//    [self progress];
//    self.progressLayer.frame = progessRect;
//    self.progressLayer.backgroundColor = UIColor.greenColor.CGColor;
    
    
    // oval
//    CAShapeLayer *backgroundMask = [CAShapeLayer layer];
//    backgroundMask.path = [UIBezierPath bezierPathWithOvalInRect:rect].CGPath;
//    self.layer.mask = backgroundMask;
    
    // ring
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(rect, _ringWidth * 0.5, _ringWidth * 0.5)];
    _backgroundMask.path = circlePath.CGPath;
    
    self.progressLayer.path = circlePath.CGPath;
    self.progressLayer.strokeStart = 0.0f;
    self.progressLayer.strokeEnd = _progress;
    self.progressLayer.strokeColor = UIColor.greenColor.CGColor;
    

    
}


#pragma mark - CADisplayLink

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

#pragma mark - Lazy load

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        CAShapeLayer *progress = [CAShapeLayer layer];
        [self.layer addSublayer:progress];
        _progressLayer = progress;
    }
    return _progressLayer;
}

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
