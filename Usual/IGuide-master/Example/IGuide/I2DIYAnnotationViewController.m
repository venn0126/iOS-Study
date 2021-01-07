//
//  I2DIYAnnotationViewController.m
//  IGuide_Example
//
//  Created by whatsbug on 2019/12/26.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "I2DIYAnnotationViewController.h"
#import "I2DIYAnnotationView.h"
#import "IGuide.h"
#import "UIView+Guide.h"

@interface I2DIYAnnotationViewController ()<IGuideViewControllerDataSource, IGuideViewControllerDelegate>

@end

@implementation I2DIYAnnotationViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [IGuideViewController showsWithDataSource:self];
    
    // 🎃🎃🎃
    // 发自内心的希望你能把自定义的"注解"视图提交pull request，贡献你的代码~
    // 如果你嫌麻烦也可以直接把代码发我~
}

//MARK: - IGuideViewControllerDataSource
- (NSUInteger)numberOfGuidesInGuideViewController:(NSString *)identifier {
    return 2 + 1;
}

- (IGuideItem *)guideViewController:(NSString *)identifier itemForGuideAtIndex:(NSUInteger)index {
    IGuideItem *item = IGuideItem.new;
    
    CGRect frame = CGRectZero;
    NSString *annotationText = nil;
    if (index == 0) {
        frame = self.button.frame;
        annotationText = @"我是自定义的注解视图";
    } else if (index == 1) {
        frame = self.aSwitch.frame;
        annotationText = @"我要提交pull request";
    } else {
        annotationText = @"好的呢~老铁奥利给";
    }
    
    item.highlightFrameOfAnnotated = frame;
    item.spacingBetweenAnnotationAndAnnotated = 24.0;
    item.shadowColor = UIColor.systemBlueColor;
    item.annotationText = annotationText;
    return item;
}

- (UIView<IGuideAnnotationViewProtocol> *)guideViewController:(NSString *)identifier annotationViewForGuideAtIndex:(NSUInteger)index {
    // 在这里返回自定义的"注解"视图
    I2DIYAnnotationView *annotationView = I2DIYAnnotationView.new;
    annotationView.backgroundColor = UIColor.systemBlueColor;
    return annotationView;
}

- (UIVisualEffectView *)visualEffectViewInGuideViewController:(NSString *)identifier {
    // 改变背景的模糊程度
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    //visualEffectView.alpha = 0.0;
    return visualEffectView;
}

- (UIView *)guideViewController:(NSString *)identifier indicatorViewForGuideAtIndex:(NSUInteger)index {
    UIView *indicator = IGuideIndicatorTriangleView.new;
    indicator.frame = CGRectMake(0, 0, 14, 7);
    indicator.backgroundColor = UIColor.systemBlueColor;
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
