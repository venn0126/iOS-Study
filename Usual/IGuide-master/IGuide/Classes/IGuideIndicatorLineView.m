//
//  IGuideIndicatorLineView.m
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/6.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "IGuideIndicatorLineView.h"
#import "UIColor+Guide.h"

@interface IGuideIndicatorLineView ()
@property(nonatomic, strong) UIView *shapeView;
@end

@implementation IGuideIndicatorLineView

//MARK: - Life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (CGRectIsEmpty(frame)) {
        frame = CGRectMake(0, 0, 18, 24);
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
    
    // 画圆角
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerTopRight;
    CGSize cornerRadii = CGSizeMake(CGRectGetWidth(self.bounds) * 0.5, CGRectGetWidth(self.bounds) * 0.5);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
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
