//
//  FSRectScale.m
//  TestGuideLayout
//
//  Created by Augus on 2020/12/29.
//

#import "FSRectScale.h"

#define screen_w [UIScreen mainScreen].bounds.size.width
#define screen_h [UIScreen mainScreen].bounds.size.height

static const CGFloat kRectScaleWidth = 288.0f;
static const CGFloat kRectScaleTop = 135.0f;


@interface FSRectScale()<CAAnimationDelegate>

@property (nonatomic, strong) CALayer *scaleLayer;
@property (nonatomic, assign)  BOOL isAnimation;
@property (nonatomic, copy) animationBlock block;



@end

@implementation FSRectScale



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, screen_w, screen_h);
//        self.backgroundColor = UIColor.lightGrayColor;
        _isAnimation = NO;
        [self scaleLayer];
    }
    return self;
}

- (void)rs_startAnimation {
    
    if (self.isAnimation) {
        NSLog(@"rs already animation");
        return;
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    // 动画选项设定
    animation.duration = 1.5; // 动画持续时间
    animation.repeatCount = MAXFLOAT; // 重复次数
    animation.values = @[@0.5, @0.6, @0.7, @0.8, @0.9, @1, @0.9, @0.8, @0.7, @0.6, @0.5];
    animation.additive = YES;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    
    [self.scaleLayer addAnimation:animation forKey:nil];
    self.isAnimation = YES;
}

- (void)rs_stopAnimation:(animationBlock)block {

    [self.scaleLayer removeAllAnimations];
    [self.scaleLayer removeFromSuperlayer];
    self.scaleLayer = nil;
    self.isAnimation = NO;
    
    self.block = block;

}

#pragma mark - CAAnimation Delegate


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    self.block(flag);
}


#pragma mark - Laze load

- (CALayer *)scaleLayer {
    
    if (!_scaleLayer) {
        CALayer *rect = [CALayer layer];
        rect.contents = (__bridge id _Nullable)([UIImage imageNamed:@"detect_rect_scale"].CGImage);
        // 594 600
        rect.frame = CGRectMake(0, 0, 150, 150);
        CGFloat fillX = screen_w * 0.5;
        CGFloat fillY = kRectScaleWidth * 0.5 + kRectScaleTop;
        rect.position = CGPointMake(fillX, fillY);
        
        [self.layer addSublayer:rect];
        
        _scaleLayer = rect;
        
    }
    return _scaleLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
