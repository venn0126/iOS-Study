//
//  IGuideAnnotationViewProtocol.h
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/6.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGuideAnnotationViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 自定义的"注解"视图必须实现该协议
 因为内部是通过约束计算高度的，所以自定义的视图必须是self-sizing的，也就是视图的上下左右都要有约束支撑
 可参考内置的IGuideAppleAnnotationView、IGuideJerryAnnotationView等
 */
@protocol IGuideAnnotationViewProtocol <NSObject>

@required
@property(nonatomic, weak) id<IGuideAnnotationViewModelProtocol> model;
@property(nonatomic, strong, readonly) UILabel *textLabel_protocol;
@property(nonatomic, strong, readonly) UIButton *nextButton_protocol;

@optional
@property(nonatomic, strong, readonly) UIButton *previousButton_protocol;
@property(nonatomic, strong, readonly) UILabel *titleLabel_protocol;
@property(nonatomic, strong, readonly) UIImageView *iconView_protocol;
@property(nonatomic, strong, readonly) UIImageView *backgroundView_protocol;

@end

NS_ASSUME_NONNULL_END
