//
//  TimeFuncViewController.h
//  FSMorphingLabel
//
//  Created by 翁志方 on 2017/12/22.
//  Copyright © 2017年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeFuncViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *horLabel;
@property (weak, nonatomic) IBOutlet UILabel *verLabel;

- (IBAction)segmentClked:(UISegmentedControl *)sender;

@property (weak, nonatomic) IBOutlet UIButton *animationSwitchBtn;

- (IBAction)backBtnClked:(id)sender;


@end
