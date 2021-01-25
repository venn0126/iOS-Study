//
//  DrawCircleProgressButton.m
//  DrawCircleProgress
//
//  Created by shlity on 16/7/13.
//  Copyright © 2016年 Moresing Inc. All rights reserved.
//

#import "DrawCircleProgressButton.h"

#define degreesToRadians(x) ((x) * M_PI / 180.0)

@interface DrawCircleProgressButton()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, copy)   DrawCircleProgressBlock myBlock;
@property (nonatomic, strong) NSTimer *timer;




@end

@implementation DrawCircleProgressButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self.layer addSublayer:self.trackLayer];
        self.countNumber = 10;
        
    }
    return self;
}

- (UIBezierPath *)bezierPath
{
    if (!_bezierPath) {
        
        CGFloat width = CGRectGetWidth(self.frame)/2.0f;
        CGFloat height = CGRectGetHeight(self.frame)/2.0f;
        CGPoint centerPoint = CGPointMake(width, height);
        float radius = CGRectGetWidth(self.frame)/2;
        
        _bezierPath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                     radius:radius
                                                 startAngle:degreesToRadians(-90)
                                                   endAngle:degreesToRadians(270)
                                                  clockwise:YES];
    }
    return _bezierPath;
}

- (CAShapeLayer *)trackLayer
{
    if (!_trackLayer) {
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.frame = self.bounds;
        _trackLayer.fillColor = self.fillColor.CGColor ? self.fillColor.CGColor : [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.3].CGColor ;
        _trackLayer.lineWidth = self.lineWidth ? self.lineWidth : 2.f;
        _trackLayer.strokeColor = self.trackColor.CGColor ? self.trackColor.CGColor : [UIColor redColor].CGColor ;
        _trackLayer.strokeStart = 0.f;
        _trackLayer.strokeEnd = 1.f;
        
        _trackLayer.path = self.bezierPath.CGPath;
    }
    return _trackLayer;
}

- (CAShapeLayer *)progressLayer
{
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.bounds;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.lineWidth = self.lineWidth ? self.lineWidth : 2.f;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.strokeColor = self.progressColor.CGColor ? self.progressColor.CGColor  : [UIColor grayColor].CGColor;
        _progressLayer.strokeStart = 0.f;
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = self.animationDuration;
        pathAnimation.fromValue = @(0.0);
        pathAnimation.toValue = @(1.0);
        pathAnimation.removedOnCompletion = YES;
        pathAnimation.delegate = self;
        [_progressLayer addAnimation:pathAnimation forKey:nil];

        _progressLayer.path = _bezierPath.CGPath;
    }
    return _progressLayer;
}

#pragma mark -- CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        self.myBlock();
    }
}


#pragma mark - Setter

- (void)setDetectState:(FSDetectState)detectState {
    _detectState = detectState;
    if (detectState == FSDetectStateProcess) {
        // 处理中超时----隐藏动画，并停止
        
        
        
        // 处理中未超时----不需要处理
        
        
        
    }else if(detectState == FSDetectStateProcessSuccess){
        
        // 单个成功 未超时----重新启动进入下个动作
        
        // 单个成功 超时 按成功算----重新启动进入下个动作
        
    }else if(detectState == FSDetectStateSuccess){
        
        // 成功 未超时 ---隐藏动画，并停止
        
        // 成功 超时 按成功算---- 隐藏动画，并停止
    }
}

#pragma mark --- Public Action

- (void)startAnimationDuration:(CGFloat)duration withBlock:(DrawCircleProgressBlock )block{
    self.myBlock = block;
    self.animationDuration = duration;
    [self.layer addSublayer:self.progressLayer];
}



- (void)fos_beginAnimation {
    
    self.countNumber = 10;
    __weak typeof(self)weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        // > 0 &
        if (weakSelf.countNumber <= 0) {
            return;
        }
        // 刷新标题数字
        weakSelf.countNumber--;
        NSLog(@"--%ld---%@",weakSelf.countNumber,[NSThread currentThread]);
        [weakSelf setTitle:[NSString stringWithFormat:@"%ld",weakSelf.countNumber] forState:UIControlStateNormal];
    }];
    
}


- (void)fos_restartAnimaton {
    [self fos_beginAnimation];
}

- (void)fos_stopAnimation {

    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if (!self.hidden) {
        self.hidden = YES;
    }
    
}

- (void)dealloc {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
