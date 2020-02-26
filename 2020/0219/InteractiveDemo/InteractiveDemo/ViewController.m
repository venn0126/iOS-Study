//
//  ViewController.m
//  InteractiveDemo
//
//  Created by Wei Niu on 2018/11/2.
//  Copyright © 2018年 Fosafer. All rights reserved.
//

#import "ViewController.h"
#import "FOSDetectController.h"
#import <AlipayVerifySDK/APVerifyService.h>


#define kButtonWidth 100
#define kButtonHeight 50

@interface ViewController ()

@property (nonatomic, strong) UIImageView *iconImageView;
// 0 随机一种动作 眨眼 左摇 又摇 点头
// 3眨眼+左摇 5眨眼+右摇 9眨眼+点头
// 11眨眼+左摇+点头 13眨眼+右摇+点头
@property (nonatomic, strong) UIButton *beginButton;
@property (nonatomic, strong) UIButton *threeButton;
@property (nonatomic, strong) UIButton *fiveButton;
@property (nonatomic, strong) UIButton *nineButton;
@property (nonatomic, strong) UIButton *elevenButton;
@property (nonatomic, strong) UIButton *thirteenButton;
@property (nonatomic, strong) UIButton *aliButton;




@end



@implementation ViewController



- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        [_iconImageView sizeToFit];
    }
    return _iconImageView;
}

- (UIButton *)beginButton {
    if (!_beginButton) {
        _beginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_beginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_beginButton setTitle:@"随机" forState:UIControlStateNormal];
        _beginButton.layer.cornerRadius = 5;
        _beginButton.backgroundColor = [UIColor redColor];
        _beginButton.tag = 0;
        
    }
    return _beginButton;
}

- (UIButton *)threeButton {
    if (!_threeButton) {
        _threeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_threeButton setTitle:@"眨眼+左摇" forState:UIControlStateNormal];
        _threeButton.layer.cornerRadius = 5;
        _threeButton.backgroundColor = [UIColor redColor];
        _threeButton.tag = 3;
        
    }
    return _threeButton;
}

- (UIButton *)fiveButton {
    if (!_fiveButton) {
        _fiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_fiveButton setTitle:@"眨眼+右摇" forState:UIControlStateNormal];
        _fiveButton.layer.cornerRadius = 5;
        _fiveButton.backgroundColor = [UIColor redColor];
        _fiveButton.tag = 5;
        
    }
    return _fiveButton;
}

- (UIButton *)nineButton {
    if (!_nineButton) {
        _nineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nineButton setTitle:@"眨眼+点头" forState:UIControlStateNormal];
        _nineButton.layer.cornerRadius = 5;
        _nineButton.backgroundColor = [UIColor redColor];
        _nineButton.tag = 9;
        
    }
    return _nineButton;
}

- (UIButton *)elevenButton {
    if (!_elevenButton) {
        _elevenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_elevenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_elevenButton setTitle:@"眨眼+左摇+点头" forState:UIControlStateNormal];
        _elevenButton.layer.cornerRadius = 5;
        _elevenButton.backgroundColor = [UIColor redColor];
        _elevenButton.tag = 11;
        _elevenButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
    }
    return _elevenButton;
}

- (UIButton *)thirteenButton {
    if (!_thirteenButton) {
        _thirteenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_thirteenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_thirteenButton setTitle:@"眨眼+右摇+点头" forState:UIControlStateNormal];
        _thirteenButton.layer.cornerRadius = 5;
        _thirteenButton.backgroundColor = [UIColor redColor];
        _thirteenButton.tag = 13;
        _thirteenButton.titleLabel.font = [UIFont systemFontOfSize:13];

        
    }
    return _thirteenButton;
}


- (UIButton *)aliButton {

    if (!_aliButton) {
        _aliButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_aliButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_aliButton setTitle:@"alitest" forState:UIControlStateNormal];
        _aliButton.layer.cornerRadius = 5;
        _aliButton.backgroundColor = [UIColor redColor];
        _aliButton.tag = 14;
        _aliButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _aliButton;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"首页";
    [self initSubviews];
    
}

- (void)initSubviews {
    
    self.iconImageView.frame = CGRectMake(0, 0, 200, 200);
    self.iconImageView.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    self.iconImageView.image = [UIImage imageNamed:@"icon"];
    [self.view addSubview:self.iconImageView];
    
    [self addButton:self.beginButton index:1];
    [self addButton:self.threeButton index:2];
    [self addButton:self.fiveButton index:3];
    
    [self addButton:self.nineButton index:4];
    [self addButton:self.elevenButton index:5];
    [self addButton:self.thirteenButton index:6];

//    [self.view addSubview:self.aliButton];
//    self.aliButton.frame = CGRectMake(100, self.view.frame.size.height - 100, 200, 50);
//    [self.aliButton addTarget:self action:@selector(beginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)addButton:(UIButton *)button index:(NSInteger)index{
    CGFloat offset = (self.view.frame.size.width - kButtonWidth * 3 ) / 4;

    if (index > 3) {
        button.frame = CGRectMake(offset * (index - 3) + kButtonWidth * (index - 4) , self.iconImageView.frame.origin.y + self.iconImageView.frame.size.height + 170, kButtonWidth, kButtonHeight);
    } else {
        button.frame = CGRectMake(offset * index + kButtonWidth * (index - 1), self.iconImageView.frame.origin.y + self.iconImageView.frame.size.height + 100, kButtonWidth, kButtonHeight);
    }
    [button addTarget:self action:@selector(beginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
   
}


- (void)beginButtonAction:(UIButton *)sender {
    
    // default
    if (sender.tag == 14) {
        [[APVerifyService sharedService] startVerifyService:@{@"url": @"https://fengdie.alipay.com/p/f/dev-jp17v2yi/pages/home/index.html",
                                                                 @"certifyId": @"test-certifyId",
                                                                 @"ext": @"test-extInfo"
                                                                 } target:self block:^(NSMutableDictionary * resultDic){
                                                                     NSLog(@"%@", resultDic);
                                                                 }];
    }else {
    
        FOSDetectController * __block detect = [[FOSDetectController alloc] init];
        detect.index = sender.tag;
        
        detect.imageCallBack = ^(id result){
            self.iconImageView.image = (UIImage *)result;
            detect = nil;
        };
        [self.navigationController pushViewController:detect animated:YES];
  }
}



@end
