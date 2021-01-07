//
//  I2DefaultStyleViewController.m
//  IGuide_Example
//
//  Created by whatsbug on 2019/12/17.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import "I2DefaultStyleViewController.h"
#import "IGuide.h"

@interface I2DefaultStyleViewController ()<IGuideViewControllerDataSource, IGuideViewControllerDelegate>

@end

@implementation I2DefaultStyleViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [IGuideViewController showsWithDataSource:self];
}

//MARK: - IGuideViewControllerDataSource
- (NSUInteger)numberOfGuidesInGuideViewController:(NSString *)identifier {
    return 1 + 1;
}

- (IGuideItem *)guideViewController:(NSString *)identifier itemForGuideAtIndex:(NSUInteger)index {
    IGuideItem *item = IGuideItem.new;
    item.highlightFrameOfAnnotated = self.aSwitch.frame;
    item.cornerRadiusOfAnnotated = CGRectGetHeight(item.highlightFrameOfAnnotated) * 0.5;
    item.iconImageName = @"bird";
    
    return item;
}

//MARK: - IGuideViewControllerDelegate
- (void)guideViewControllerDidSelectSkipTutorial:(NSString *)identifier {
    NSLog(@"下次提醒");
}

- (void)guideViewControllerDidSelectNeverRemind:(NSString *)identifier {
    NSLog(@"不再提醒");
}

@end
