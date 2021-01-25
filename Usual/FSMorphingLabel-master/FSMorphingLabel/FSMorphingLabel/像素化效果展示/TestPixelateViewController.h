//
//  TestPixelateViewController.h
//  FSMorphingLabel
//
//  Created by 翁志方 on 2017/12/20.
//  Copyright © 2017年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PixelateLabel.h"

@interface TestPixelateViewController : UIViewController

@property (weak, nonatomic) IBOutlet PixelateLabel *label;

@property (weak, nonatomic) IBOutlet UILabel *scaleLabel;


- (IBAction)backBtnClked:(id)sender;

@end
