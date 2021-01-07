//
//  I2OtherViewController.m
//  IGuide_Example
//
//  Created by whatsbug on 2019/12/18.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "I2OtherViewController.h"
#import "UIColor+I2Add.h"
#import "IGuide.h"

@interface I2OtherViewController ()<IGuideViewControllerDataSource, IGuideViewControllerDelegate>

@end

@implementation I2OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 任何对象只要遵守协议都可以通过 +showsWithDataSource: 弹出动画教程
    [IGuideViewController showsWithDataSource:self];
    
    // 🌵如何获取内置"注解"视图的root权限？？？
    // 如果你觉得内置的"注解"视图暴露的api有限，达不到你想要的定制效果，那该怎么办呢？
    // 以下有两个办法：
    // 1. 准守IGuideAnnotationViewProtocol协议，完全自定义你自己的"注解"视图（欢迎提交pull request）
    // 2. 新建一个继承UIView的子类，复制内置"注解"视图的所有代码到新建的类，在新建的类里修改你想定制的代码
    // 最后通过 -guideViewController:annotationViewForGuideAtIndex: 代理方法返回新建的类即可
}

//MARK: - IGuideViewControllerDataSource
- (NSUInteger)numberOfGuidesInGuideViewController:(NSString *)identifier {
    return 1 + 1;
}

- (IGuideItem *)guideViewController:(NSString *)identifier itemForGuideAtIndex:(NSUInteger)index {
    IGuideItem *item = IGuideItem.new;
    
    item.highlightFrameOfAnnotated = self.aSwitch.frame;
    item.cornerRadiusOfAnnotated = CGRectGetHeight(item.highlightFrameOfAnnotated) * 0.5;
    item.spacingBetweenAnnotationAndAnnotated = 128.0; // 间隔
    item.shadowColor = UIColor.randomColor;
    item.annotationText = index == 0 ? @"其他一些知识点" : @"蓝色按钮可移动的哦";
    item.annotationTitle = index == 0 ? @"其他" : @"移动试试";
    item.backgroundImageName = @"bird";
    item.iconImageName = @"bird";
    return item;
}

- (UIVisualEffectView *)visualEffectViewInGuideViewController:(NSString *)identifier {
    // 改变背景的模糊程度
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    //visualEffectView.alpha = 0.0;
    return visualEffectView;
}

- (UIView<IGuideAnnotationViewProtocol> *)guideViewController:(NSString *)identifier annotationViewForGuideAtIndex:(NSUInteger)index {
    IGuideJerryAnnotationView *annotationView = IGuideJerryAnnotationView.new;
    annotationView.backgroundView_protocol.backgroundColor = UIColor.clearColor;
    annotationView.backgroundView_protocol.contentMode = UIViewContentModeScaleAspectFit;
    return annotationView;
}

- (UIView *)guideViewController:(NSString *)identifier indicatorViewForGuideAtIndex:(NSUInteger)index {
    // 设置指示器的大小
    IGuideIndicatorLineView *indicator = IGuideIndicatorLineView.new;
    indicator.frame = CGRectMake(0, 0, 30, 110);
    indicator.backgroundColor = UIColor.brownColor;
    return indicator;
}

//MARK: - IGuideViewControllerDelegate
- (void)guideViewControllerDidSelectSkipTutorial:(NSString *)identifier {
    NSLog(@"下次提醒");
}

- (void)guideViewControllerDidSelectNeverRemind:(NSString *)identifier {
    NSLog(@"不再提醒");
}

@end
