//
//  YFOneViewController.m
//  AnimationDemo
//
//  Created by EnforLiu on 15/11/26.
//  Copyright © 2015年 EnforLiu. All rights reserved.
//

#import "YFOneViewController.h"
#import "YFAnimationCostum.h"
@interface YFOneViewController ()

@end

@implementation YFOneViewController
{
    UIImageView *_imageView;
    CALayer *layer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];

    _imageView          = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _imageView.image    = [UIImage imageNamed:@"Image1"];
    _imageView.center   = CGPointMake(self.view.center.x, self.view.center.y-100);
    [self.view addSubview:_imageView];
    
    layer = _imageView.layer;

    UIBarButtonItem * item =[[UIBarButtonItem alloc]initWithTitle:@"选择动画"
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(changeAnimation)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;


}

- (void)changeAnimation {
    
    //先移除动画 不然会有动画重叠
    [layer removeAllAnimations];
    //ios8 的actionsheet
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"动画效果" message:@"整理的动画效果" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel handler:nil];
   
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"闪烁动画"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        //闪烁
        [layer addAnimation:[YFAnimationCostum animation_opacityForever:0.5] forKey:nil];
    }];
   
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"横向移动"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        //横向移动
        [layer addAnimation:[YFAnimationCostum animation_moveX:0.5 X:[NSNumber numberWithFloat:50]] forKey:nil];
    }];
   
    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"纵向移动"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        //纵向移动
        [layer addAnimation:[YFAnimationCostum animation_moveY:0.5 Y:[NSNumber numberWithFloat:50]] forKey:nil];
    }];
  
    UIAlertAction * action4 = [UIAlertAction actionWithTitle:@"缩放效果"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        //缩放
        [layer addAnimation:[YFAnimationCostum animation_scale:[NSNumber numberWithFloat:1.0f] orgin:[NSNumber numberWithFloat:0.5] durTimes:0.5]forKey:nil];
    }];
  
    UIAlertAction * action5 = [UIAlertAction actionWithTitle:@"组合动画"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
       //组合动画
        NSArray *myArray = [NSArray arrayWithObjects:[YFAnimationCostum animation_opacityForever:0.5],[YFAnimationCostum animation_moveX:0.5 X:[NSNumber numberWithFloat:100]],[YFAnimationCostum animation_scale:[NSNumber numberWithFloat:1.0f] orgin:[NSNumber numberWithFloat:0.5] durTimes:0.5], nil];
        
        [layer addAnimation:[YFAnimationCostum animation_groupAnimation:myArray durTimes:3 Rep:MAXFLOAT]forKey:nil];
    }];
  
    UIAlertAction * action6 = [UIAlertAction actionWithTitle:@"路径动画"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        //路径动画
        CGPoint centerP = _imageView.center;
        //YFAnimationCostum.h 中有使用方法
        CGMutablePathRef curvedPath = CGPathCreateMutable();
        CGPathMoveToPoint(curvedPath, NULL, centerP.x, centerP.y);
        CGPathAddQuadCurveToPoint(curvedPath, NULL, centerP.x+100,centerP.y,centerP.x+100, centerP.y+100);
        CGPathAddQuadCurveToPoint(curvedPath, NULL, centerP.x+100,centerP.y+200,centerP.x , centerP.y+200);
        CGPathAddQuadCurveToPoint(curvedPath, NULL, centerP.x-100, centerP.y+200,centerP.x-100, centerP.y+100);
        CGPathAddQuadCurveToPoint(curvedPath, NULL, centerP.x-100, centerP.y,centerP.x, centerP.y);

        [layer addAnimation:[YFAnimationCostum animation_keyframeAnimation:curvedPath durTimes:2 Rep:MAXFLOAT] forKey:nil];
        
    }];
   
    UIAlertAction * action7 = [UIAlertAction actionWithTitle:@"旋转动画"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        //旋转
        CATransform3D ca3d = CATransform3DMakeRotation(kDegreesToRadian(180), 1, 1, 0);
        [layer addAnimation:[YFAnimationCostum animation_rotation:0.7 CATransform3D:ca3d repeatCount:MAXFLOAT] forKey:nil];
        
    }];
    UIAlertAction * action8 = [UIAlertAction actionWithTitle:@"抖动动画"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        //抖动
        CATransform3D ca3d1 =CATransform3DRotate(_imageView.layer.transform, -0.05, 0.0, 0.0, 0.05);
        CATransform3D ca3d2 =CATransform3DRotate(_imageView.layer.transform, 0.05, 0.0, 0.0, 0.05);
        [layer addAnimation:[YFAnimationCostum animation_JitterFromCATransform3D:ca3d1 To:ca3d2] forKey:nil];
    }];
    

    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:action4];
    [alertController addAction:action5];
    [alertController addAction:action6];
    [alertController addAction:action7];
    [alertController addAction:action8];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
