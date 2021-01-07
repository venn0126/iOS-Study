//
//  I2JerryStyleViewController.m
//  IGuide_Example
//
//  Created by whatsbug on 2019/12/18.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "I2JerryStyleViewController.h"
#import "UIColor+I2Add.h"
#import "IGuide.h"

@interface I2JerryStyleViewController ()<IGuideViewControllerDataSource, IGuideViewControllerDelegate>

@end

@implementation I2JerryStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [IGuideViewController showsWithDataSource:self];
}

//MARK: - IGuideViewControllerDataSource
- (NSUInteger)numberOfGuidesInGuideViewController:(NSString *)identifier {
    return 2 + 1;
}

- (IGuideItem *)guideViewController:(NSString *)identifier itemForGuideAtIndex:(NSUInteger)index {
    IGuideItem *item = IGuideItem.new;
    
    CGRect frame = CGRectZero;
    CGFloat cornerRadius = 0.0;
    NSString *annotationText = nil;
    NSString *annotationTitle = nil;
    if (index == 0) {
        frame = CGRectInset(self.button.frame, -8.0, -2.0);
        cornerRadius = 8.0;
        annotationText = @"很不高兴见到大家";
        annotationTitle = @"你好！";
    } else if (index == 1) {
        frame = self.aSwitch.frame;
        cornerRadius = CGRectGetHeight(frame) * 0.5;
        annotationText = @"记得到 www.github.com 给我点赞啊铁子";
        annotationTitle = @"你个星星";
    } else if (index == 2) {
        annotationText = @"又到了说再见的时候了";
        annotationTitle = @"拜拜👋";
    }
    
    item.highlightFrameOfAnnotated = frame;
    item.cornerRadiusOfAnnotated = cornerRadius;
    item.annotationText = annotationText;
    item.annotationTitle = annotationTitle;
    item.backgroundImageName = [NSString stringWithFormat:@"i%ld", index];
    item.iconImageName = @"bird";
    return item;
}

- (UIView<IGuideAnnotationViewProtocol> *)guideViewController:(NSString *)identifier annotationViewForGuideAtIndex:(NSUInteger)index {
    // 返回内置的"注解"视图Jerry
    return IGuideJerryAnnotationView.new;
}

//MARK: - IGuideViewControllerDelegate
- (void)guideViewControllerDidSelectSkipTutorial:(NSString *)identifier {
    NSLog(@"跳过教程");
}

- (void)guideViewControllerDidSelectNeverRemind:(NSString *)identifier {
    NSLog(@"不再提醒");
}

@end
