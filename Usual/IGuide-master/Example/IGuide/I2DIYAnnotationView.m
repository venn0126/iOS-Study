//
//  I2DIYAnnotationView.m
//  IGuide_Example
//
//  Created by whatsbug on 2019/12/26.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "I2DIYAnnotationView.h"
#import "UIColor+Guide.h"

@interface I2DIYAnnotationView ()
@property(nonatomic, strong) UILabel *textLabel_protocol;
@property(nonatomic, strong) UIButton *nextButton_protocol;
@end

@implementation I2DIYAnnotationView

//MARK: - Life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.igThemeColor;
        
        // add subviews
        [self addSubview:self.textLabel_protocol];
        [self addSubview:self.nextButton_protocol];

        // make constraints
        [self.textLabel_protocol.topAnchor constraintEqualToAnchor:self.topAnchor constant:12.0].active = YES;
        [self.textLabel_protocol.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-12.0].active = YES;
        [self.textLabel_protocol.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10.0].active = YES;
        
        [self.nextButton_protocol.leadingAnchor constraintEqualToAnchor:self.textLabel_protocol.trailingAnchor].active = YES;
        [self.nextButton_protocol.widthAnchor constraintEqualToConstant:30.0].active = YES;
        [self.nextButton_protocol.heightAnchor constraintEqualToConstant:30.0].active = YES;
        [self.nextButton_protocol.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
        [self.nextButton_protocol.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-4.0].active = YES;
    }
    return self;
}

//MARK: - Getter & Setter
- (void)setModel:(id<IGuideAnnotationViewModelProtocol>)model {
    _model = model;
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineSpacing = 5.0;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:model.annotationText attributes:attributes];
    self.textLabel_protocol.attributedText = attributedText;
    
    if (model.nextButtonTitle) {
        [self.nextButton_protocol setTitle:model.nextButtonTitle forState:UIControlStateNormal];
    }
}

- (UILabel *)textLabel_protocol {
    if (!_textLabel_protocol) {
        UILabel *label = UILabel.new;
        _textLabel_protocol = label;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.numberOfLines = 0;
        label.textColor = UIColor.whiteColor;
        label.font = [UIFont systemFontOfSize:15.0];
    }
    return _textLabel_protocol;
}

- (UIButton *)nextButton_protocol {
    if (!_nextButton_protocol) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        _nextButton_protocol = button;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setTitle:@"✕" forState:UIControlStateNormal];
        [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    }
    return _nextButton_protocol;
}

@end
