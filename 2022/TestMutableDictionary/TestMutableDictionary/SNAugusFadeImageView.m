//
//  SNAugusFadeImageView.m
//  TestMutableDictionary
//
//  Created by Augus on 2022/8/5.
//

#import "SNAugusFadeImageView.h"


#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

static NSTimeInterval const kAugusFadeAnimationDuration = 1.6;
static CGFloat const kAugusMoveLayerWidth = 20.0;
static NSString * const kAugusFadeAnimationDefaultImageName = @"sohu_loading_1";
static NSString * const kAugusFadeAnimationLayerKey = @"kAugusFadeAnimationLayerKey";

//static NSString * const kAugusFadeAnimationDefaultImageName = @"night_sohu_loading_1";



@interface SNAugusFadeImageView ()

/// 需要渲染的背景图
@property (nonatomic, strong) UIImageView *showImageView;

/// 游标图层
@property (nonatomic, strong) CAShapeLayer *moveLayer;

/// 是否正在动画的标识符
@property (nonatomic, assign) BOOL isAnimationing;

@end

@implementation SNAugusFadeImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    
    self.backgroundColor = [UIColor colorNamed:@"fadeDA"];
//    self.backgroundColor = [UIColor colorNamed:@"fade34"];

    
    _animationDuration = kAugusFadeAnimationDuration;
    _imageName = kAugusFadeAnimationDefaultImageName;
    _isAnimationing = NO;
    
    
    [self setupSubviews];
    
    
    return self;
}


#pragma mark - UI

- (void)setupSubviews {
    
    // 设置当前承载视图的遮挡视图
    self.maskView = self.showImageView;

}

#pragma mark - Public Methods

- (void)startAnimation {
    
    if (self.isAnimationing) {
        return;
    }
    
    
    if (![self.layer.sublayers containsObject:self.moveLayer]) {
        [self.layer insertSublayer:self.moveLayer atIndex:0];
    }
    self.moveLayer.hidden = NO;

    // 移动动画
    CABasicAnimation *gradientAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    gradientAnimation.fromValue = @(-kAugusMoveLayerWidth);

    gradientAnimation.toValue = @(self.showImageView.bounds.size.width + kAugusMoveLayerWidth);
    
    // 动画完成后不删除动画
    gradientAnimation.removedOnCompletion = NO;
    gradientAnimation.duration = _animationDuration;
    gradientAnimation.fillMode = kCAMediaTimingFunctionEaseInEaseOut;
    gradientAnimation.repeatCount = MAXFLOAT;
    [self.moveLayer addAnimation:gradientAnimation forKey:kAugusFadeAnimationLayerKey];
    
    self.isAnimationing = YES;
}


- (void)stopAnimation {
    
    if (!self.isAnimationing) {
        return;
    }
    [self.moveLayer removeAnimationForKey:kAugusFadeAnimationLayerKey];
    self.moveLayer.hidden = YES;
    self.isAnimationing = NO;
}


#pragma mark - Setter

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
}


- (void)setAnimationDuration:(NSTimeInterval)animationDuration {
    _animationDuration = animationDuration;
}


#pragma mark - Lazy Load

- (UIImageView *)showImageView {
    if (!_showImageView) {
        _showImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _showImageView.image = [UIImage imageNamed:self.imageName];
        [_showImageView sizeToFit];
    }
    return _showImageView;
}


- (CAShapeLayer *)moveLayer {
    if (!_moveLayer) {
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, kAugusMoveLayerWidth, self.showImageView.frame.size.height)];
        
        // 创建带形状的图层
        _moveLayer = [CAShapeLayer layer];
        _moveLayer.frame = CGRectMake(0, 0, kAugusMoveLayerWidth, self.showImageView.frame.size.height);
        _moveLayer.fillColor = [UIColor colorNamed:@"fadeC4"].CGColor;
//        _moveLayer.fillColor = [UIColor colorNamed:@"fade45"].CGColor;

//        _moveLayer.fillColor = [UIColor greenColor].CGColor;

        _moveLayer.path = bezierPath.CGPath;
        // 当x,y,z值为0时,代表在该轴方向上不进行旋转,当值为1时,代表在该轴方向上进行逆时针旋转,当值为-1时,代表在该轴方向上进行顺时针旋转
        _moveLayer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(40), 0, 0, 1);
        _moveLayer.opacity = 0.7;
        _moveLayer.masksToBounds = YES;
    }
    return _moveLayer;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
