//
//  UIView+Extension.h
//  FosAttendance
//
//  Created by Wei Niu on 2018/6/28.
//  Copyright © 2018年 Fosafer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGPoint fos_origin;
@property (nonatomic, assign) CGSize  fos_size;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end
