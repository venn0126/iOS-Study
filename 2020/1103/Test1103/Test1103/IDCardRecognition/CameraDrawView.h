//
//  CameraDrawView.h
//  IDCardDemo
//
//  Created by linmac on 16-10-15.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "YMOCRWeexModule.h"

@interface CameraDrawView : UIView

@property (assign, nonatomic) BOOL ymz;
@property (assign, nonatomic) BOOL leftHidden;
@property (assign, nonatomic) BOOL rightHidden;
@property (assign, nonatomic) BOOL topHidden;
@property (assign, nonatomic) BOOL bottomHidden;
@property (assign ,nonatomic) NSInteger smallX;
@property (assign ,nonatomic) CGRect smallrect;
@property (assign, nonatomic) CGRect ymzSmallRect;
@property (assign, nonatomic) CGRect engIdCardRect;
@property (assign, nonatomic) NSInteger cameraDrawIdType;

@property (strong, nonatomic) UILabel *LabbankDetail;
@property (strong, nonatomic) UILabel *LabIdDetail;
@property (strong, nonatomic) UIImageView *ImageVBankLine;

@end
