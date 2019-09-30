//
//  MTransitionButton.m
//  Test0929
//
//  Created by 牛威 on 2019/9/30.
//  Copyright © 2019 fosafer. All rights reserved.
//

#import "MTransitionButton.h"
#import "MSpinerLayer.h"
#import "UIView+Extension.h"

static CFTimeInterval srinkDuration = 0.1;

@interface MTransitionButton()<UIViewControllerTransitioningDelegate,CAAnimationDelegate>


@property (nonatomic, strong) MSpinerLayer *spinerLayer;



@end

@implementation MTransitionButton{
    
    NSString *_cachedTitle;
    UIImage *_cacheImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (instancetype)initWithColor:(UIColor *)color size:(CGSize)size {
//    if (self = [super init]) {
//        
//        CGSize msize = CGSizeMake(1, 1);
//        CGRect rect = CGRectMake(0, 0, msize.width, msize.height);
//        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
//        [color setFill];
//        UIRectFill(rect);
//        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        CGImageRef imageRef = image.CGImage;
////        
//        [self setup];
//    }
//    return self;
//

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}


- (void)setup {
    
    self.clipsToBounds = YES;
//    self.spinerLayer.
    
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.spinerLayer mSetToFrame:self.frame];
}

- (void)startAnimation {
    
    self.userInteractionEnabled = NO;
    
    _cachedTitle = [self titleForState:UIControlStateNormal];
    _cacheImage = [self imageForState:UIControlStateNormal];
    
    [self setTitle:@"" forState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.1 animations:^{
        self.layer.cornerRadius = self.frame.size.height * 0.5;
    } completion:^(BOOL finished) {
        [self shrink];
        [self.spinerLayer startAnimation];
    }];
    
}


- (void)stopAnimation:(MTransitionButtonStyle)style delay:(NSTimeInterval)delay completion:(void(^)(void))completion{
    
    NSTimeInterval maxDelay = MAX(delay, 0.2);
    if (style == MTransitionButtonNormal) {
        
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(maxDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               [self setOriginalState:completion];
            });
    } else if(style == MTransitionButtonShake){
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(maxDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self setOriginalState:nil];
                   [self shakeAnimation:completion];
        });
    }else if(style == MTransitionButtonExpand){
        [self.spinerLayer stopAnimation];
        [self expand:completion revertDelay:maxDelay];
    }
    
}


- (void)shakeAnimation:(void (^)(void))completion{
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint point = self.layer.position;
    
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)];
    NSValue *value6 = [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)];
    NSValue *value7 = [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)];
    NSValue *value8 = [NSValue valueWithCGPoint:point];
    
    keyAnimation.values = @[value1,value2,value3,value4,value5,value6,value7,value8];
    
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyAnimation.duration = 0.7;
    self.layer.position = point;
    [CATransaction setCompletionBlock:^{
        completion();
    }];
    
    [self.layer addAnimation:keyAnimation forKey:keyAnimation.keyPath];
    [CATransaction commit];

}

- (void)setOriginalState:(void (^)(void))completion {
    
//    self.ani
}

- (void)animateToOriginalWidth:(void(^)(void))completion {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    basicAnimation.fromValue = @(self.bounds.size.height);
    basicAnimation.toValue = @(self.bounds.size.width);
    basicAnimation.duration = srinkDuration;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    [CATransaction setCompletionBlock:^{
        completion();
    }];
    [self.layer addAnimation:basicAnimation forKey:basicAnimation.keyPath];
    [CATransaction commit];
}
- (void)shrink {
    
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    basicAnimation.fromValue = @(self.width);
    basicAnimation.toValue = @(self.height);
    basicAnimation.duration = srinkDuration;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:basicAnimation forKey:basicAnimation.keyPath];
    

}


- (void)expand:(void(^)(void))completion revertDelay:(NSTimeInterval)revertDelay {

    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    CGFloat expandScale = [UIScreen mainScreen].bounds.size.height / self.height * 2;
    basicAnimation.fromValue = @(1.0);
    basicAnimation.toValue = @(MAX(expandScale, 26.0));
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.95 :0.02 :1 :0.05];
    basicAnimation.duration = 0.4;
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    
    [CATransaction setCompletionBlock:^{
        completion();
            
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self setOriginalState:nil];
             [self.layer removeAllAnimations];
        });
    }];
    
    [self.layer addAnimation:basicAnimation forKey:basicAnimation.keyPath];
    [CATransaction commit];
}



#pragma mark - lazy load

- (MSpinerLayer *)spinerLayer {
    if (!_spinerLayer) {
        _spinerLayer = [[MSpinerLayer alloc] init];
        _spinerLayer.frame = self.frame;
    }
    return _spinerLayer;
}

@end
