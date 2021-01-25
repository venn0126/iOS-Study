//
//  TimeFuncViewController.m
//  FSMorphingLabel
//
//  Created by 翁志方 on 2017/12/22.
//  Copyright © 2017年 wzf. All rights reserved.
//

#import "TimeFuncViewController.h"
#import "Turtle.h"
#import "FSEasing.h"

@interface TimeFuncViewController ()
{
    CGFloat sx,sy;      //
    CGFloat width;
    
    CAShapeLayer *curveLayer;  // 曲线图层
    
    BOOL animationDisable;
}
@end

@implementation TimeFuncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 曲线图层初始化
    curveLayer = [CAShapeLayer layer];
    
    curveLayer.fillColor = [UIColor clearColor].CGColor;
    curveLayer.strokeColor = [UIColor whiteColor].CGColor;
    curveLayer.borderWidth = 1;
    curveLayer.fillMode = kCAFillModeBoth;
    
    [self.view.layer addSublayer:curveLayer];
}

- (void)viewWillAppear:(BOOL)animated
{
    width = 180;
    // 寻找初始坐标点
    sy = self.horLabel.frame.origin.y;
    sx = self.verLabel.frame.origin.x;
    
    // 添加两条虚线
    UIView *horLine = [[UIView alloc] initWithFrame:CGRectMake(sx, sy-width, 250, 0.5)];
    horLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:horLine];
    
    UIView *verLine = [[UIView alloc] initWithFrame:CGRectMake(sx+width, sy-250, 0.5, 250)];
    verLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:verLine];

    
    // 开始绘制第一条函数曲线
    [self drawCurve:0];
}


- (void)viewDidAppear:(BOOL)animated
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClked:(id)sender
{
    animationDisable = !animationDisable;
    if (animationDisable) {
        [self.animationSwitchBtn setTitle:@"disableAnimation" forState:UIControlStateNormal];
    }else{
        [self.animationSwitchBtn setTitle:@"enableAnimation" forState:UIControlStateNormal];
    }
}

- (void)drawCurve:(NSInteger)index
{
    DRAWINVIEW(self.view);
    MOVETOXY(sx, sy);
    
    // 100等分
    CGFloat posx = sx;
    for (NSInteger i=1; i<=100; ++i) {

        CGFloat height;
        CGFloat process = i/100.0;
        switch (index) {
            case 0:{
                height = easeOutQuit(process,0, width, 1);
            }break;

            case 1:{
                height = easeInQuit(process,0, width, 1);
            }break;

            case 2:{
                height = easeOutBack(process,0, width, 1);
            }break;

            case 3:{
                height = easeOutBounce(process,0, width, 1);
            }break;
            default:
                break;
        }
        posx += width/100;
        LINETOXY(posx, sy-height);
    }
    
    if (animationDisable==NO && curveLayer.path) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.duration = 0.6;
        animation.fromValue = (id) curveLayer.path;
        animation.toValue = (id) TURTLE.shapePath;
        animation.fillMode = kCAFillModeBoth;
        animation.removedOnCompletion = NO;
        [curveLayer addAnimation:animation forKey:nil];
    }else{
        // 不移除之前的动画可能会导致下面的路径设置失效
        [curveLayer removeAllAnimations];
    }
    
    curveLayer.path = TURTLE.shapePath;
}


- (IBAction)segmentClked:(UISegmentedControl *)sender {

    [self drawCurve:sender.selectedSegmentIndex];
}



- (IBAction)backBtnClked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
