//
//  GDTMaskViewController.h
//  ZKTweak
//
//  Created by Augus on 11.27.2022
//  Copyright (c) 2022 Cocoanetics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDTMaskViewController.h"

@interface GTHomeAdClearController : GDTMaskViewController

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) BOOL blankViewClickable;

- (void)viewWillAppear:(BOOL)arg1;
- (void)viewDidLoad;
- (long long)preferredInterfaceOrientationForPresentation;
- (void)setBlankViewClickedCallback:(id)arg1;



@end
