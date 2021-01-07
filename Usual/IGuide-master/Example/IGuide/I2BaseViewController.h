//
//  I2BaseViewController.h
//  IGuide_Example
//
//  Created by whatsbug on 2019/12/17.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface I2BaseViewController : UIViewController

@property(nonatomic, strong, readonly) UIButton *button;
@property(nonatomic, strong, readonly) UISlider *slider;
@property(nonatomic, strong, readonly) UISwitch *aSwitch;

@end

NS_ASSUME_NONNULL_END
