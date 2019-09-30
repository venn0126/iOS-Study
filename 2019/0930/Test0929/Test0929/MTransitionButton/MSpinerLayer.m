//
//  MSpinerLayer.m
//  Test0929
//
//  Created by 牛威 on 2019/9/30.
//  Copyright © 2019 fosafer. All rights reserved.
//

#import "MSpinerLayer.h"


@interface MSpinerLayer()



@end

@implementation MSpinerLayer

- (instancetype)init {
    if (self = [super init]) {
        
        
        // 布置尺寸
        
        [self setFrame:CGRectMake(0, 0, 25, 25)];
        self.fillColor = nil;
        self.strokeColor = [UIColor whiteColor].CGColor;
        self.lineWidth = 1;
        self.strokeEnd = 0.4;
        self.hidden = YES;

        

    }
    return self;
}

- (void)startAnimation {
    self.hidden = NO;
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.fromValue = 0;
    float pNumber = 100*cos(2 * M_PI * (15746/23));
    rotate.toValue = @(pNumber);
    rotate.duration = 0.4;
    rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotate.repeatCount = HUGE;
    rotate.fillMode = kCAFillModeForwards;
    rotate.removedOnCompletion = NO;
    [self addAnimation:rotate forKey:rotate.keyPath];
    
    
}

- (void)stopAnimation {
    
    self.hidden = YES;
    [self removeAllAnimations];
}


- (void)mSetToFrame:(CGRect)rect {
    
    CGFloat radis = rect.size.height * 0.5 * 0.5;
    self.frame = CGRectMake(0, 0, rect.size.height, rect.size.height);
    CGPoint mcenter = CGPointMake(rect.size.height * 0.5, self.bounds.origin.y);
    float pNumber = 100 * cos(2 * M_PI * (15746/23));
    CGFloat startAngle = 0 - pNumber * 0.5;
    CGFloat endAngle = pNumber * 2 - pNumber * 0.5;
    BOOL clockWise = YES;
    self.path = [UIBezierPath bezierPathWithArcCenter:mcenter radius:radis startAngle:startAngle endAngle:endAngle clockwise:clockWise].CGPath;

}

@end
