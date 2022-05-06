//
//  SNGradientLabel.m
//  CADisplayLinkTest
//
//  Created by Augus on 2022/5/6.
//

#import "SNGradientLabel.h"

@implementation SNGradientLabel

+ (Class)layerClass {
    
    return [CAGradientLayer class];
}


- (void)drawRect:(CGRect)rect {
    
    if (!_highColor) {
        _highColor = UIColor.redColor;
    }
    
    if (!_lowColor) {
        _lowColor = UIColor.greenColor;
    }
    
    if (_startPoint.x == 0 && _startPoint.y == 0) {
        _startPoint = CGPointMake(0, 0);
    }
    
    if (_endPoint.x == 0 && _endPoint.y == 0) {
        _endPoint = CGPointMake(1, 1);
    }
    
    CAGradientLayer *gLayer = (CAGradientLayer *)self.layer;
    gLayer.startPoint = _startPoint;
    gLayer.endPoint = _endPoint;
    gLayer.colors = @[(id)_highColor.CGColor, (id)_lowColor.CGColor];
    
    
    [super drawRect:rect];
}


- (void)setHighColor:(UIColor *)highColor {
    _highColor = highColor;
    [self.layer setNeedsDisplay];
}


- (void)setLowColor:(UIColor *)lowColor {
    _lowColor = lowColor;
    [self.layer setNeedsDisplay];
}


- (void)setStartPoint:(CGPoint)startPoint {
    _startPoint = startPoint;
    [self.layer setNeedsDisplay];
}


- (void)setEndPoint:(CGPoint)endPoint {
    _endPoint = endPoint;
    [self.layer setNeedsDisplay];
}


@end
