//
//  FOSScanView.h
//  BioSaferID
//
//  Created by Wei Niu on 2018/8/29.
//  Copyright © 2018年 Fosafer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FOSScanView : UIView


@property (nonatomic, assign)  BOOL fosAnmating;

// 该方法是销毁页面时候调用
- (void)stopAnimation;

// 以下两个方法是在中途检测中更新UI使用
- (void)pauseAnimation;

- (void)continueAnimation;

@end
