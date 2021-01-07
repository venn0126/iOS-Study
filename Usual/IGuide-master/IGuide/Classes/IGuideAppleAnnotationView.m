//
//  IGuideAppleAnnotationView.m
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/9.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "IGuideAppleAnnotationView.h"
#import "UIColor+Guide.h"
#import "UIView+Guide.h"

@interface IGuideAppleAnnotationView ()
@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) UIView *redView;
@property(nonatomic, strong) UIView *yellowView;
@property(nonatomic, strong) UIView *greenView;
@property(nonatomic, strong) UIImageView *iconView_protocol;
@property(nonatomic, strong) UILabel *titleLabel_protocol;
@property(nonatomic, strong) UILabel *textLabel_protocol;
@property(nonatomic, strong) UIButton *previousButton_protocol;
@property(nonatomic, strong) UIButton *nextButton_protocol;
@end

@implementation IGuideAppleAnnotationView

//MARK: - Life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.igThemeColor;
        self.layer.cornerRadius = 8.0;
        
        // add subviews
        [self addSubview:self.topView];
        [self.topView addSubview:self.redView];
        [self.topView addSubview:self.yellowView];
        [self.topView addSubview:self.greenView];
        [self addSubview:self.iconView_protocol];
        [self addSubview:self.titleLabel_protocol];
        [self addSubview:self.textLabel_protocol];
        [self addSubview:self.previousButton_protocol];
        [self addSubview:self.nextButton_protocol];
        
        // make constraints
        [self.topView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [self.topView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
        [self.topView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
        [self.topView.heightAnchor constraintEqualToConstant:54.0].active = YES;
        
        CGFloat colorViewWH =  16.0;
        [self.redView.widthAnchor constraintEqualToConstant:colorViewWH].active = YES;
        [self.redView.heightAnchor constraintEqualToConstant:colorViewWH].active = YES;
        [self.redView.centerYAnchor constraintEqualToAnchor:self.topView.centerYAnchor].active = YES;
        [self.redView.leadingAnchor constraintEqualToAnchor:self.topView.leadingAnchor constant:24.0].active = YES;
        
        [self.yellowView.widthAnchor constraintEqualToConstant:colorViewWH].active = YES;
        [self.yellowView.heightAnchor constraintEqualToConstant:colorViewWH].active = YES;
        [self.yellowView.centerYAnchor constraintEqualToAnchor:self.topView.centerYAnchor].active = YES;
        [self.yellowView.leadingAnchor constraintEqualToAnchor:self.redView.trailingAnchor constant:8.0].active = YES;
        
        [self.greenView.widthAnchor constraintEqualToConstant:colorViewWH].active = YES;
        [self.greenView.heightAnchor constraintEqualToConstant:colorViewWH].active = YES;
        [self.greenView.centerYAnchor constraintEqualToAnchor:self.topView.centerYAnchor].active = YES;
        [self.greenView.leadingAnchor constraintEqualToAnchor:self.yellowView.trailingAnchor constant:8.0].active = YES;
        
        [self.iconView_protocol.topAnchor constraintEqualToAnchor:self.topView.bottomAnchor constant:6.0].active = YES;
        [self.iconView_protocol.widthAnchor constraintEqualToConstant:54.0].active = YES;
        [self.iconView_protocol.heightAnchor constraintEqualToConstant:54.0].active = YES;
        [self.iconView_protocol.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        
        [self.titleLabel_protocol.topAnchor constraintEqualToAnchor:self.iconView_protocol.bottomAnchor].active = YES;
        [self.titleLabel_protocol.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
        [self.titleLabel_protocol.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
        [self.titleLabel_protocol.heightAnchor constraintEqualToConstant:44.0].active = YES;
        
        [self.textLabel_protocol.topAnchor constraintEqualToAnchor:self.titleLabel_protocol.bottomAnchor].active = YES;
        [self.textLabel_protocol.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:40.0].active = YES;
        [self.textLabel_protocol.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-40.0].active = YES;
        [self.textLabel_protocol.widthAnchor constraintGreaterThanOrEqualToConstant:186.0].active = YES;
        
        CGFloat buttonH = 44.0;
        [self.nextButton_protocol.topAnchor constraintEqualToAnchor:self.textLabel_protocol.bottomAnchor constant:20.0].active = YES;
        [self.nextButton_protocol.widthAnchor constraintEqualToConstant:188.0].active = YES;
        [self.nextButton_protocol.heightAnchor constraintEqualToConstant:buttonH].active = YES;
        [self.nextButton_protocol.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        
        [self.previousButton_protocol.topAnchor constraintEqualToAnchor:self.nextButton_protocol.bottomAnchor constant:2.0].active = YES;
        [self.previousButton_protocol.centerXAnchor constraintEqualToAnchor:self.nextButton_protocol.centerXAnchor].active = YES;
        [self.previousButton_protocol.widthAnchor constraintEqualToAnchor:self.nextButton_protocol.widthAnchor].active = YES;
        [self.previousButton_protocol.heightAnchor constraintEqualToAnchor:self.nextButton_protocol.heightAnchor].active = YES;
        [self.previousButton_protocol.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-12.0].active = YES;
        
        // cornerRadius
        self.redView.layer.cornerRadius = colorViewWH * 0.5;
        self.yellowView.layer.cornerRadius = colorViewWH * 0.5;
        self.greenView.layer.cornerRadius = colorViewWH * 0.5;
        self.nextButton_protocol.layer.cornerRadius = buttonH * 0.5;
    }
    return self;
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

- (UIView *)redView {
    if (!_redView) {
        UIView *view = UIView.new;
        _redView = view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.backgroundColor = UIColor.systemRedColor;
    }
    return _redView;
}

- (UIView *)yellowView {
    if (!_yellowView) {
        UIView *view = UIView.new;
        _yellowView = view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.backgroundColor = UIColor.systemYellowColor;
    }
    return _yellowView;
}

- (UIView *)greenView {
    if (!_greenView) {
        UIView *view = UIView.new;
        _greenView = view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.backgroundColor = UIColor.systemGreenColor;
    }
    return _greenView;
}

- (UIView *)topView {
    if (!_topView) {
        UIView *view = UIView.new;
        _topView = view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}

- (UIImageView *)iconView_protocol {
    if (!_iconView_protocol) {
        UIImageView *imageView = UIImageView.new;
        _iconView_protocol = imageView;
        imageView.layer.cornerRadius = 8.0;
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
        label.textAlignment = NSTextAlignmentCenter;
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
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setTitle:@"上一条" forState:UIControlStateNormal];
        [button setTitleColor:UIColor.systemGreenColor forState:UIControlStateNormal];
        [button setTitleColor:UIColor.systemGreenColor.igDisabledColor forState:UIControlStateDisabled];
        [button.titleLabel setFont:self.textLabel_protocol.font];
    }
    return _previousButton_protocol;
}

@end
