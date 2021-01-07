//
//  IGuideTomAnnotationView.m
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/12.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "IGuideTomAnnotationView.h"
#import "UIColor+Guide.h"
#import "UIView+Guide.h"

@interface IGuideTomAnnotationView ()
@property(nonatomic, strong) UIView *circleView;
@property(nonatomic, strong) UIImageView *iconView_protocol;
@property(nonatomic, strong) UILabel *titleLabel_protocol;
@property(nonatomic, strong) UILabel *textLabel_protocol;
@property(nonatomic, strong) UIButton *previousButton_protocol;
@property(nonatomic, strong) UIButton *nextButton_protocol;
@end

@implementation IGuideTomAnnotationView

//MARK: - Life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.igThemeColor;
        self.layer.cornerRadius = 8.0;

        // add subviews
        [self addSubview:self.circleView];
        [self addSubview:self.iconView_protocol];
        [self addSubview:self.titleLabel_protocol];
        [self addSubview:self.textLabel_protocol];
        [self addSubview:self.previousButton_protocol];
        [self addSubview:self.nextButton_protocol];

        // make constraints
        CGFloat circleH = 60.0;
        [self.circleView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        [self.circleView.centerYAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [self.circleView.widthAnchor constraintEqualToConstant:circleH].active = YES;
        [self.circleView.heightAnchor constraintEqualToConstant:circleH].active = YES;
   
        [self.iconView_protocol.centerXAnchor constraintEqualToAnchor:self.circleView.centerXAnchor].active = YES;
        [self.iconView_protocol.centerYAnchor constraintEqualToAnchor:self.circleView.centerYAnchor].active = YES;
        [self.iconView_protocol.widthAnchor constraintEqualToConstant:circleH * 0.7].active = YES;
        [self.iconView_protocol.heightAnchor constraintEqualToConstant:circleH * 0.7].active = YES;

        [self.titleLabel_protocol.topAnchor constraintEqualToAnchor:self.circleView.bottomAnchor].active = YES;
        [self.titleLabel_protocol.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20.0].active = YES;
        [self.titleLabel_protocol.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-20.0].active = YES;
        [self.titleLabel_protocol.heightAnchor constraintEqualToConstant:40.0].active = YES;
        
        [self.textLabel_protocol.topAnchor constraintEqualToAnchor:self.titleLabel_protocol.bottomAnchor].active = YES;
        [self.textLabel_protocol.leadingAnchor constraintEqualToAnchor:self.titleLabel_protocol.leadingAnchor].active = YES;
        [self.textLabel_protocol.trailingAnchor constraintEqualToAnchor:self.titleLabel_protocol.trailingAnchor].active = YES;
        [self.textLabel_protocol.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-40.0].active = YES;
    
        CGFloat buttonH = 40.0;
        [self.previousButton_protocol.centerYAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        [self.previousButton_protocol.widthAnchor constraintEqualToConstant:100.0].active = YES;
        [self.previousButton_protocol.heightAnchor constraintEqualToConstant:buttonH].active = YES;
        [self.previousButton_protocol.trailingAnchor constraintEqualToAnchor:self.centerXAnchor constant:-10].active = YES;
        [self.previousButton_protocol.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.leadingAnchor constant:30].active = YES;
        
        [self.nextButton_protocol.centerYAnchor constraintEqualToAnchor:self.previousButton_protocol.centerYAnchor].active = YES;
        [self.nextButton_protocol.widthAnchor constraintEqualToAnchor:self.previousButton_protocol.widthAnchor].active = YES;
        [self.nextButton_protocol.heightAnchor constraintEqualToAnchor:self.previousButton_protocol.heightAnchor].active = YES;
        [self.nextButton_protocol.leadingAnchor constraintEqualToAnchor:self.centerXAnchor constant:10].active = YES;
        [self.nextButton_protocol.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor constant:-30].active = YES;
        
        // cornerRadius
        self.circleView.layer.cornerRadius = circleH * 0.5;
        self.previousButton_protocol.layer.cornerRadius = buttonH * 0.5;
        self.nextButton_protocol.layer.cornerRadius = buttonH * 0.5;
    }
    return self;
}

//MARK: - Override
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (!view) {
        for (UIView *subview in self.subviews) {
            if (CGRectContainsPoint(subview.frame, point)) {
                view = subview;
                break;
            }
        }
    }
    return view;
}

//MARK: - Getter & Setter
- (void)setModel:(id<IGuideAnnotationViewModelProtocol>)model {
    _model = model;
    
    CGFloat lineHeight = self.textLabel_protocol.font.lineHeight;
    CGFloat pointSize = self.textLabel_protocol.font.pointSize;
    CGFloat lineSpacing = 8 - (lineHeight - pointSize);
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
    self.textLabel_protocol.attributedText = [[NSAttributedString alloc] initWithString:model.annotationText attributes:attributes];

    self.titleLabel_protocol.text = model.annotationTitle;
    
    if (model.iconImageName) {
        self.iconView_protocol.image = [UIImage imageNamed:model.iconImageName];
    }
    if (model.previousButtonTitle) {
        [self.previousButton_protocol setTitle:model.previousButtonTitle forState:UIControlStateNormal];
    }
    if (model.nextButtonTitle) {
        [self.nextButton_protocol setTitle:model.nextButtonTitle forState:UIControlStateNormal];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    [self.circleView setBackgroundColor:backgroundColor];
}

- (UIView *)circleView {
    if (!_circleView) {
        UIView *view = UIView.new;
        _circleView = view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _circleView;
}

- (UIImageView *)iconView_protocol {
    if (!_iconView_protocol) {
        UIImageView *imageView = UIImageView.new;
        _iconView_protocol = imageView;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconView_protocol;
}

- (UILabel *)titleLabel_protocol {
    if (!_titleLabel_protocol) {
        UILabel *label = UILabel.new;
        _titleLabel_protocol = label;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.numberOfLines = 0;
        label.textColor = UIColor.blackColor;
        label.font = [UIFont systemFontOfSize:17.0];
        label.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel_protocol;
}

- (UILabel *)textLabel_protocol {
    if (!_textLabel_protocol) {
        UILabel *label = UILabel.new;
        _textLabel_protocol = label;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.numberOfLines = 0;
        label.textColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        label.font = [UIFont systemFontOfSize:15.0];
    }
    return _textLabel_protocol;
}

- (UIButton *)nextButton_protocol {
    if (!_nextButton_protocol) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        _nextButton_protocol = button;
        button.layer.backgroundColor = UIColor.systemGreenColor.CGColor;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setTitle:@"知道了" forState:UIControlStateNormal];
        [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [button setTitleColor:UIColor.whiteColor.igDisabledColor forState:UIControlStateDisabled];
        [button.titleLabel setFont:self.textLabel_protocol.font];
        [button drawsShadowWithColor:UIColor.systemGreenColor];
    }
    return _nextButton_protocol;
}

- (UIButton *)previousButton_protocol {
    if (!_previousButton_protocol) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        _previousButton_protocol = button;
        button.layer.backgroundColor = UIColor.systemGreenColor.CGColor;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setTitle:@"上一条" forState:UIControlStateNormal];
        [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [button setTitleColor:UIColor.whiteColor.igDisabledColor forState:UIControlStateDisabled];
        [button.titleLabel setFont:self.textLabel_protocol.font];
        [button drawsShadowWithColor:UIColor.systemGreenColor];
    }
    return _previousButton_protocol;
}

@end
