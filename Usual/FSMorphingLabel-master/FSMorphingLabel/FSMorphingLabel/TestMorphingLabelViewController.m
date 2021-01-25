//
//  TestMorphingLabelViewController.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/26.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "TestMorphingLabelViewController.h"
#import "FSMorphingLabel.h"
#import "TestPixelateViewController.h"
#import "TimeFuncViewController.h"


@interface TestMorphingLabelViewController ()
{
    FSMorphingLabel *morphingLabel;
}
@end

@implementation TestMorphingLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化
    morphingLabel = [[FSMorphingLabel alloc] init];
    morphingLabel.textColor = [UIColor whiteColor];
    morphingLabel.font = [UIFont systemFontOfSize:30];
    morphingLabel.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 100);
    morphingLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:morphingLabel];
    
    // 词语初始化
    textArr = @[@"What is design?",
                @"Design",
                @"Design is not just",
                @"what it looks like",
                @"and feels like.",
                @"Design",
                @"is how it works.",
                @"- Steve Jobs",
                @"Older people",
                @"类与对象",
                @"OO 面向对象"
                @"建筑设计", @"设计模式",
                @"数据结构与算法", @"sit down and ask,", @"'What is it?'",
                @"but the boy asks,", @"'What can I do with it?'.", @"- Steve Jobs",
                @"", @"Swift", @"Objective-C", @"iPhone", @"iPad", @"Mac Mini",
                @"MacBook Pro🔥", @"Mac Pro⚡️"
                ];
    [self pixelateBtnClked:self.pixelateBtn];
    
    // 改变文本
    changeTextBtn = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [changeTextBtn addTarget:self
                      action:@selector(changeTextBtnClked:)
            forControlEvents:UIControlEventTouchUpInside];
    
    [self.view insertSubview:changeTextBtn belowSubview:self.scaleBtn];
    
    self.view.backgroundColor = [UIColor blackColor];
    
//    [self testTimeFunction:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)changeTextBtnClked:(UIButton *)btn
{
    if (btn != changeTextBtn) {
        // 修改选中按钮的状态
        if (previousSelectedBtn != btn) {
            
            [previousSelectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            
            previousSelectedBtn = btn;
        }
    }
    static NSInteger count = 0;
    morphingLabel.text = textArr[count % textArr.count];
    
    ++count;
}


- (IBAction)scaleBtnClked:(UIButton *)sender
{
    morphingLabel.morphingEffect = kMorphingEffectScale;
    [self changeTextBtnClked:sender];
}
- (IBAction)evaporateBtnBtnClked:(UIButton *)sender
{
    morphingLabel.morphingEffect = kMorphingEffectEvaporate;
    [self changeTextBtnClked:sender];
}
- (IBAction)fallBtnClked:(UIButton *)sender
{
    morphingLabel.morphingEffect = kMorphingEffectFall;
    [self changeTextBtnClked:sender];
}
- (IBAction)pixelateBtnClked:(UIButton *)sender
{
    morphingLabel.morphingEffect = kMorphingEffectPixelate;
    [self changeTextBtnClked:sender];
}
- (IBAction)anvilBtnClked:(UIButton *)sender
{
    morphingLabel.morphingEffect = kMorphingEffectAnvil;
    [self changeTextBtnClked:sender];
}
- (IBAction)burnBtnClked:(UIButton *)sender
{
    morphingLabel.morphingEffect = kMorphingEffectBurn;
    [self changeTextBtnClked:sender];
}
- (IBAction)sparkleBtnClked:(UIButton *)sender
{
    morphingLabel.morphingEffect = kMorphingEffectSparkle;
    [self changeTextBtnClked:sender];
}


- (IBAction)testPixelate:(id)sender {
    TestPixelateViewController *vc = [TestPixelateViewController new];
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

- (IBAction)testTimeFunction:(id)sender {
    
    TimeFuncViewController *vc = [TimeFuncViewController new];
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

@end
