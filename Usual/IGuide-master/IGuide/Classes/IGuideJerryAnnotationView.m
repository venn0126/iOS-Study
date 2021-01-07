//
//  IGuideJerryAnnotationView.m
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/11.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "IGuideJerryAnnotationView.h"
#import "UIColor+Guide.h"
#import "UIView+Guide.h"

@interface IGuideJerryAnnotationView ()
@property(nonatomic, strong) UIImageView *backgroundView_protocol;
@property(nonatomic, strong) UIImageView *iconView_protocol;
@property(nonatomic, strong) UILabel *titleLabel_protocol;
@property(nonatomic, strong) UILabel *textLabel_protocol;
@property(nonatomic, strong) UIButton *previousButton_protocol;
@property(nonatomic, strong) UIButton *nextButton_protocol;
@property(nonatomic, strong) UIView *contentView;
@end

@implementation IGuideJerryAnnotationView

//MARK: - Life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.igThemeColor;
        self.layer.cornerRadius = 18.0;
        
        // add subviews
        [self addSubview:self.backgroundView_protocol];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.iconView_protocol];
        [self.contentView addSubview:self.titleLabel_protocol];
        [self.contentView addSubview:self.textLabel_protocol];
        [self.contentView addSubview:self.previousButton_protocol];
        [self.contentView addSubview:self.nextButton_protocol];

        // make constraints
        [self.backgroundView_protocol.bottomAnchor constraintEqualToAnchor:self.topAnchor constant:30.0].active = YES;
        [self.backgroundView_protocol.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
        [self.backgroundView_protocol.heightAnchor constraintEqualToConstant:150.0].active = YES;
        [self.backgroundView_protocol.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        
        [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
        
        [self.iconView_protocol.centerYAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [self.iconView_protocol.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:60.0].active = YES;
        
        [self.titleLabel_protocol.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:20.0].active = YES;
        [self.titleLabel_protocol.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
        [self.titleLabel_protocol.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;
        [self.titleLabel_protocol.heightAnchor constraintEqualToConstant:44.0].active = YES;
        
        [self.textLabel_protocol.topAnchor constraintEqualToAnchor:self.titleLabel_protocol.bottomAnchor].active = YES;
        [self.textLabel_protocol.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:40.0].active = YES;
        [self.textLabel_protocol.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-40.0].active = YES;
        [self.textLabel_protocol.widthAnchor constraintGreaterThanOrEqualToConstant:186.0].active = YES;
        
        CGFloat buttonH = 40.0;
        [self.previousButton_protocol.topAnchor constraintEqualToAnchor:self.textLabel_protocol.bottomAnchor constant:20.0].active = YES;
        [self.previousButton_protocol.widthAnchor constraintEqualToConstant:100.0].active = YES;
        [self.previousButton_protocol.heightAnchor constraintEqualToConstant:buttonH].active = YES;
        [self.previousButton_protocol.trailingAnchor constraintEqualToAnchor:self.centerXAnchor constant:-15].active = YES;
        [self.previousButton_protocol.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-20].active = YES;
        
        [self.nextButton_protocol.centerYAnchor constraintEqualToAnchor:self.previousButton_protocol.centerYAnchor].active = YES;
        [self.nextButton_protocol.widthAnchor constraintEqualToAnchor:self.previousButton_protocol.widthAnchor].active = YES;
        [self.nextButton_protocol.heightAnchor constraintEqualToAnchor:self.previousButton_protocol.heightAnchor].active = YES;
        [self.nextButton_protocol.leadingAnchor constraintEqualToAnchor:self.centerXAnchor constant:15].active = YES;
        
        // cornerRadius
        self.previousButton_protocol.layer.cornerRadius = buttonH * 0.5;
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
    if (model.backgroundImageName) {
        self.backgroundView_protocol.image = [UIImage imageNamed:model.backgroundImageName];
    }
    if (model.previousButtonTitle) {
        [self.previousButton_protocol setTitle:model.previousButtonTitle forState:UIControlStateNormal];
    }
    if (model.nextButtonTitle) {
        [self.nextButton_protocol setTitle:model.nextButtonTitle forState:UIControlStateNormal];
    }
}

- (UIImageView *)backgroundView_protocol {
    if (!_backgroundView_protocol) {
        UIImageView *imageView = UIImageView.new;
        _backgroundView_protocol = imageView;
        imageView.layer.cornerRadius = 18.0;
        imageView.layer.backgroundColor = UIColor.igThemeColor.CGColor;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
    }
    return _backgroundView_protocol;
}

- (UIView *)contentView {
    if (!_contentView) {
        UIView *view = UIView.new;
        _contentView = view;
        view.layer.cornerRadius = 18.0;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.backgroundColor = UIColor.whiteColor;
        [view drawsShadowWithColor:UIColor.blackColor];
    }
    return _contentView;
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
