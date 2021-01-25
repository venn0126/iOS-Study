//
//  TestPixelateViewController.m
//  FSMorphingLabel
//
//  Created by 翁志方 on 2017/12/20.
//  Copyright © 2017年 wzf. All rights reserved.
//

#import "TestPixelateViewController.h"

@interface TestPixelateViewController ()

@end

@implementation TestPixelateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
- (IBAction)sliderChanged:(UISlider *)sender
{
    CGFloat tmp = 0.167/sender.value;
    self.label.progress = tmp;
//    self.label.progress = [UIScreen mainScreen].scale * sender.value;
    
    self.scaleLabel.text = [NSString stringWithFormat:@"%f",self.label.progress];
    [self.label setNeedsDisplay];
}

- (IBAction)backBtnClked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
