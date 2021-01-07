//
//  I2TomStyleViewController.m
//  IGuide_Example
//
//  Created by whatsbug on 2019/12/17.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "I2TomStyleViewController.h"
#import "UIColor+I2Add.h"
#import "IGuide.h"

@interface I2TomStyleViewController ()<IGuideViewControllerDataSource, IGuideViewControllerDelegate>

@end

@implementation I2TomStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (![NSUserDefaults.standardUserDefaults boolForKey:@"iDoNotNeedTutorialsAnymore"]) {
        [IGuideViewController showsWithDataSource:self];
    }
}

//MARK: - IGuideViewControllerDataSource
- (NSUInteger)numberOfGuidesInGuideViewController:(NSString *)identifier {
    return 3 + 1;
}

- (IGuideItem *)guideViewController:(NSString *)identifier itemForGuideAtIndex:(NSUInteger)index {
    IGuideItem *item = IGuideItem.new;
    
    CGRect frame = CGRectZero;
    CGFloat cornerRadius = 0.0;
    NSString *annotationText = nil;
    NSString *annotationTitle = nil;
    if (index == 0) {
        frame = self.slider.frame;
        cornerRadius = CGRectGetHeight(frame) * 0.5;
        annotationText = @"哈喽我是你们可爱的Tom";
        annotationTitle = @"哈喽";
    } else if (index == 1) {
        frame = CGRectInset(self.button.frame, -8.0, -2.0);
        cornerRadius = 8.0;
        annotationText = @"可以旋转屏幕试试~";
        annotationTitle = @"横屏支持";
    } else if (index == 2) {
        frame = self.aSwitch.frame;
        cornerRadius = CGRectGetHeight(frame) * 0.5;
        annotationText = @"指示器变成自定义的小鸟图片了";
        annotationTitle = @"自定义指示器";
    } else if (index == 3) {
        annotationText = @"教程结束啦，点击不再提醒就会永远看不到我的哦";
        annotationTitle = @"再见了";
    }
    
    item.highlightFrameOfAnnotated = frame;
    item.cornerRadiusOfAnnotated = cornerRadius;
    item.annotationText = annotationText;
    item.annotationTitle = annotationTitle;
    item.iconImageName = @"bird";
    return item;
}

- (UIView<IGuideAnnotationViewProtocol> *)guideViewController:(NSString *)identifier annotationViewForGuideAtIndex:(NSUInteger)index {
    // 返回内置的"注解"视图Tom
    // 也可以返回自定义的"注解"视图
    // 自定义"注解"视图需要遵守 IGuideAnnotationViewProtocol 协议
    // 可在这里设置"注解"视图的背景色和阴影等（不设置有默认值）
    IGuideTomAnnotationView *annotationView = IGuideTomAnnotationView.new;

    annotationView.backgroundColor = UIColor.blackColor;
    annotationView.titleLabel_protocol.textColor = UIColor.systemYellowColor;
    annotationView.textLabel_protocol.textColor = UIColor.brownColor;
    annotationView.previousButton_protocol.backgroundColor = UIColor.systemYellowColor;
    annotationView.nextButton_protocol.backgroundColor = UIColor.systemYellowColor;
    return annotationView;
}

- (UIView *)guideViewController:(NSString *)identifier indicatorViewForGuideAtIndex:(NSUInteger)index {
    // 返回内置的指示器
    // 也可以返回自定义的指示器
    // 自定义的指示器需要自行设置大小
    // 可根据index返回不同的指示器
    // 可在这里设置指示器的背景色和阴影等（不设置有默认值）
    if (index != 2) {
        IGuideIndicatorTriangleView *indicator = IGuideIndicatorTriangleView.new;
        indicator.backgroundColor = UIColor.systemYellowColor;
        return indicator;
    } else {
        UIImageView *imageView = UIImageView.new;
        imageView.image = [UIImage imageNamed:@"bird"];
        imageView.frame = CGRectMake(0, 0, 24.0, 24.0);
        return imageView;
    }
}

- (UIButton *)skipButtonInGuideViewController:(NSString *)identifier {
    // 自定义"跳过"按钮
    // 需要自行设置大小
    // 如需拖动按钮，请使用IGuideButton类
    // UIButton *button = IGuideButton.new;
    UIButton *button = UIButton.new;
    button.frame = CGRectMake(0, 0, 120, 40);
    button.layer.cornerRadius = 20.0;
    button.layer.shadowOpacity = 0.5;
    button.layer.shadowOffset = CGSizeZero;
    button.layer.shadowRadius = 8.0;
    button.layer.shadowColor = UIColor.blackColor.CGColor;
    button.layer.backgroundColor = UIColor.blackColor.CGColor;
    [button setTitle:@"自定义按钮" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.systemYellowColor forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    return button;
}

//MARK: - IGuideViewControllerDelegate
- (void)guideViewControllerDidSelectSkipTutorial:(NSString *)identifier {
    NSLog(@"下次提醒");
}

- (void)guideViewControllerDidSelectNeverRemind:(NSString *)identifier {
    NSLog(@"不再提醒");
    [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"iDoNotNeedTutorialsAnymore"];
}

@end
