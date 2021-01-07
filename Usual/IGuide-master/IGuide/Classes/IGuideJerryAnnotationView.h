//
//  IGuideJerryAnnotationView.h
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/11.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGuideAnnotationViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 内置的"注解"视图Jerry
 */
@interface IGuideJerryAnnotationView : UIView<IGuideAnnotationViewProtocol>

@property(nonatomic, weak) id<IGuideAnnotationViewModelProtocol> model;

@end

NS_ASSUME_NONNULL_END
