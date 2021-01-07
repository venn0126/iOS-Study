//
//  I2BaseViewController.m
//  IGuide_Example
//
//  Created by whatsbug on 2019/12/17.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "I2BaseViewController.h"

@interface I2BaseViewController ()
@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UISlider *slider;
@property(nonatomic, strong) UISwitch *aSwitch;
@end

@implementation I2BaseViewController

//MARK: - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.whiteColor];
    [self.view addSubview:self.aSwitch];
    [self.view addSubview:self.slider];
    [self.view addSubview:self.button];
    
    // make constraints
    [self.slider.widthAnchor constraintEqualToConstant:128.0].active = YES;
    [self.slider.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor constant:64.0].active = YES;
    [self.slider.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:64.0].active = YES;
    
    [self.aSwitch.centerYAnchor constraintEqualToAnchor:self.slider.bottomAnchor constant:128.0].active = YES;
    [self.aSwitch.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-32.0].active = YES;
    
    [self.button.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:32.0].active = YES;
    [self.button.topAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-128.0].active = YES;
}

//MARK: - Getter & Setter
- (UIButton *)button {
    if (!_button) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button = button;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setTitle:@"i am a button" forState:UIControlStateNormal];
    }
    return _button;
}

- (UISlider *)slider {
    if (!_slider) {
        UISlider *slider = UISlider.new;
        _slider = slider;
        slider.translatesAutoresizingMaskIntoConstraints = NO;
        slider.value = 0.7;
    }
    return _slider;
}

- (UISwitch *)aSwitch {
    if (!_aSwitch) {
        UISwitch *aSwitch = UISwitch.new;
        _aSwitch = aSwitch;
        aSwitch.translatesAutoresizingMaskIntoConstraints = NO;
        aSwitch.on = YES;
    }
    return _aSwitch;
}

@end
