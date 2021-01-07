//
//  FOSBottomView.m
//  TestGuideLayout
//
//  Created by Augus on 2020/12/21.
//

#import "FOSBottomView.h"


static const CGFloat kImageViewWidth = 100.f;

@interface FOSBottomView ()

@property (nonatomic, strong) UIImageView *oneImageView;
@property (nonatomic, strong) UIImageView *twoImageView;



@end

@implementation FOSBottomView


- (instancetype)init{
    return [super init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        
//        [self class];
//        [super class];
        
    
    }
    return self;
}

- (void)setupSubviews {
    
    
    // init
    _oneImageView = [[UIImageView alloc] init];
    _oneImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _oneImageView.backgroundColor = [UIColor redColor];
    [self addSubview:_oneImageView];
    
    // layout
    [_oneImageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_oneImageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [_oneImageView.widthAnchor constraintEqualToConstant:kImageViewWidth].active = YES;
    [_oneImageView.heightAnchor constraintEqualToConstant:kImageViewWidth].active = YES;
    
    
    
    // init
    _twoImageView = [[UIImageView alloc] init];
    _twoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _twoImageView.backgroundColor = [UIColor greenColor];
    [self addSubview:_twoImageView];
    
    // layout
    [_twoImageView.leadingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = YES;
    [_twoImageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [_twoImageView.widthAnchor constraintEqualToConstant:kImageViewWidth].active = YES;
    [_twoImageView.heightAnchor constraintEqualToConstant:kImageViewWidth].active = YES;
    
    
    NSLog(@"x-%f--%f",_oneImageView.layer.position.x,_twoImageView.layer.position.x);


}

- (void)fosStartAnimation {
    
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"position.x"];
//    basic.fillMode = kCAFillModeForwards;
//    basic.removedOnCompletion = NO;
    basic.duration = self.fosDuration ? self.fosDuration : 0.8f;
    NSLog(@"ddd---%f",basic.duration);
    CGFloat padding = (self.bounds.size.width - kImageViewWidth) * 0.5;
    // position.x = frame.origin.x + 0.5 * bounds.size.width；
    //
    basic.toValue = [NSNumber numberWithFloat:-0.5 * kImageViewWidth];
    [_oneImageView.layer addAnimation: basic forKey:nil];

    basic.toValue = [NSNumber numberWithFloat:padding + 0.5 * kImageViewWidth];
    [_twoImageView.layer addAnimation: basic forKey:nil];

}

- (void)fosStopAnimation {
    
    [_oneImageView.layer removeAllAnimations];
    [_twoImageView.layer removeAllAnimations];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
