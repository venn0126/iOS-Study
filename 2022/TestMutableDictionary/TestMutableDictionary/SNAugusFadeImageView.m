//
//  SNAugusFadeImageView.m
//  TestMutableDictionary
//
//  Created by Augus on 2022/8/5.
//

#import "SNAugusFadeImageView.h"


static NSTimeInterval const kAugusFadeAnimationDuration = 2.0;
static NSString * const kAugusFadeAnimationDefaultImageName = @"sohu_loading_1";
static NSString * const kAugusFadeAnimationLayerKey = @"kAugusFadeAnimationLayerKey";


@interface SNAugusFadeImageView ()

@property (nonatomic, strong) UIImageView *showImageView;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, assign) BOOL isAnimationing;

@end

@implementation SNAugusFadeImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    
//    self.backgroundColor = UIColor.darkGrayColor;
    
    _animationDuration = kAugusFadeAnimationDuration;
    _imageName = kAugusFadeAnimationDefaultImageName;
    _isAnimationing = NO;
    
    
    [self setupSubviews];
    
    
    return self;
}


#pragma mark - UI

- (void)setupSubviews {
    
    [self addSubview:self.showImageView];
    
}


#pragma mark - Private Methods



#pragma mark - Public Methods

- (void)startAnimation {
    
    if (self.isAnimationing) {
        return;
    }
    
    if (![self.layer.sublayers containsObject:self.gradientLayer]) {
        [self.layer insertSublayer:self.gradientLayer atIndex:0];
    }
    self.gradientLayer.hidden = NO;

    // 移动动画
    CABasicAnimation *gradientAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    gradientAnimation.fromValue = @[@0, @0, @0];
    gradientAnimation.toValue = @[@0.8, @1, @1];
    gradientAnimation.duration = _animationDuration;
    gradientAnimation.repeatCount = MAXFLOAT;
    [self.gradientLayer addAnimation:gradientAnimation forKey:kAugusFadeAnimationLayerKey];
    self.maskView = self.showImageView;
    self.isAnimationing = YES;
}


- (void)stopAnimation {
    
    if (!self.isAnimationing) {
        return;
    }
    [self.gradientLayer removeAnimationForKey:kAugusFadeAnimationLayerKey];
    self.gradientLayer.hidden = YES;
    self.isAnimationing = NO;
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


- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        
        _gradientLayer = [CAGradientLayer layer];
        /**
         日间：
         字色#dadada，渐变色#c4c4c4（高斯模糊2.8PX，不透明度80%）
         夜间：
         字色#343434，渐变色#454545（高斯模糊2.8PX，不透明度80%）
         
         */
        // 设置渐变色
        
        
        UIColor *color1 = [UIColor colorNamed:@"fadeColor0"];
        UIColor *color2 = [UIColor colorNamed:@"fadeColor1"];
        _gradientLayer.colors = @[(id)(color1.CGColor),(id)(color1.CGColor),(id)color2.CGColor];
        // 设置影响的位置
        _gradientLayer.locations = @[@0, @0, @0.25];
        
        // 横向渐变
        _gradientLayer.startPoint = CGPointMake(0, 0.5);
        _gradientLayer.endPoint = CGPointMake(1, 0.5);
        
        // 设置渐变尺寸
        _gradientLayer.frame = self.showImageView.bounds;
//        [self.layer insertSublayer:_gradientLayer atIndex:0];
    }
    return _gradientLayer;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
