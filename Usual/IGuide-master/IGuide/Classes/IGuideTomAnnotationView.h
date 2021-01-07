//
//  IGuideTomAnnotationView.h
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/12.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGuideAnnotationViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 内置的"注解"视图Tom
 */
@interface IGuideTomAnnotationView : UIView<IGuideAnnotationViewProtocol>

@property(nonatomic, weak) id<IGuideAnnotationViewModelProtocol> model;

@end

NS_ASSUME_NONNULL_END
