//
//  FSGuideAppleAnnotationView.h
//  fosFloatView
//
//  Created by Augus on 2020/11/18.
//

#import <UIKit/UIKit.h>
#import "FSGuideAnnotationViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 内置的"注解"视图Apple
 */

@interface FSGuideAppleAnnotationView : UIView<FSGuideAnnotationViewModelProtocol>

@property(nonatomic, weak) id<FSGuideAnnotationViewModelProtocol> model;


@end

NS_ASSUME_NONNULL_END
