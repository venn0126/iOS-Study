//
//  I2DIYAnnotationView.h
//  IGuide_Example
//
//  Created by whatsbug on 2019/12/26.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGuide.h"

NS_ASSUME_NONNULL_BEGIN

/**
 我是自定义的"注解"视图，不是框架内置的
 */
@interface I2DIYAnnotationView : UIView<IGuideAnnotationViewProtocol>

@property(nonatomic, weak) id<IGuideAnnotationViewModelProtocol> model;

@end

NS_ASSUME_NONNULL_END
