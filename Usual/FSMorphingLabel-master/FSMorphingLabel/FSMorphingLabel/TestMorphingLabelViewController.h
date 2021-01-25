//
//  TestMorphingLabelViewController.h
//  iDraw
//
//  Created by 翁志方 on 2017/1/9.
//  Copyright © 2017年 翁志方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestMorphingLabelViewController : UIViewController
{
    UIButton *previousSelectedBtn;
    UIButton *changeTextBtn;
    NSArray *textArr;
}

@property (weak, nonatomic) IBOutlet UIButton *scaleBtn;
@property (weak, nonatomic) IBOutlet UIButton *evaporateBtn;
@property (weak, nonatomic) IBOutlet UIButton *fallBtn;
@property (weak, nonatomic) IBOutlet UIButton *pixelateBtn;
@property (weak, nonatomic) IBOutlet UIButton *anvilBtn;
@property (weak, nonatomic) IBOutlet UIButton *burnBtn;
@property (weak, nonatomic) IBOutlet UIButton *sparkleBtn;

- (IBAction)scaleBtnClked:(UIButton *)sender;
- (IBAction)evaporateBtnBtnClked:(UIButton *)sender;
- (IBAction)fallBtnClked:(UIButton *)sender;
- (IBAction)pixelateBtnClked:(UIButton *)sender;
- (IBAction)anvilBtnClked:(UIButton *)sender;
- (IBAction)burnBtnClked:(UIButton *)sender;
- (IBAction)sparkleBtnClked:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
