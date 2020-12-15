//
//  FSGuideIndicatorLineView.m
//  fosFloatView
//
//  Created by Augus on 2020/11/18.
//

#import "FSGuideIndicatorLineView.h"
#import "UIColor+Guide.h"

@interface FSGuideIndicatorLineView ()

@property(nonatomic, strong) UIView *shapeView;

@end

@implementation FSGuideIndicatorLineView

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
        view.backgroundColor = UIColor.fsThemeColor;
    }
    return _shapeView;
}


@end
