//
//  IGuideIndicatorTriangleView.m
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/6.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "IGuideIndicatorTriangleView.h"
#import "UIColor+Guide.h"

@interface IGuideIndicatorTriangleView ()
@property(nonatomic, strong) UIView *shapeView;
@end

@implementation IGuideIndicatorTriangleView

//MARK: - Life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (CGRectIsEmpty(frame)) {
        frame = CGRectMake(0, 0, 24, 16);
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.shapeView];
    }
    return self;
}

//MARK: - Override
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.shapeView.frame = self.bounds;
    
    // 画三角形
    CGPoint topMidPoint = CGPointMake(CGRectGetMidX(self.bounds), 0);
    CGPoint bottomLeftPoint = CGPointMake(0, CGRectGetMaxY(self.bounds));
    CGPoint bottomRightPoint = CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds));
    
    UIBezierPath *path = UIBezierPath.bezierPath;
    [path moveToPoint:topMidPoint];
    [path addLineToPoint:bottomLeftPoint];
    [path addLineToPoint:bottomRightPoint];
    [path closePath];
    
    CAShapeLayer *layer = CAShapeLayer.new;
    layer.path = path.CGPath;
    self.shapeView.layer.mask = layer;
}

//MARK: - Getter & Setter
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:UIColor.clearColor];
    [self.shapeView setBackgroundColor:backgroundColor];
}

- (UIColor *)backgroundColor {
    return self.shapeView.backgroundColor;
}

- (UIView *)shapeView {
    if (!_shapeView) {
        UIView *view = UIView.new;
        _shapeView = view;
        view.backgroundColor = UIColor.igThemeColor;
    }
    return _shapeView;
}

@end
