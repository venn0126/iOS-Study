//
//  FSGuideAnnotationViewProtocol.h
//  fosFloatView
//
//  Created by Augus on 2020/11/18.
//

#import "FSGuideAnnotationViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 自定义的"注解"视图必须实现该协议
 因为内部是通过约束计算高度的，所以自定义的视图必须是self-sizing的，也就是视图的上下左右都要有约束支撑
 可参考内置的IGuideAppleAnnotationView、IGuideJerryAnnotationView等
 */
@protocol FSGuideAnnotationViewProtocol <NSObject>

@required
@property(nonatomic, weak) id<FSGuideAnnotationViewModelProtocol> model;
@property(nonatomic, strong, readonly) UILabel *textLabel_protocol;
@property(nonatomic, strong, readonly) UIButton *nextButton_protocol;

@optional
@property(nonatomic, strong, readonly) UIButton *previousButton_protocol;
@property(nonatomic, strong, readonly) UILabel *titleLabel_protocol;
@property(nonatomic, strong, readonly) UIImageView *iconView_protocol;
@property(nonatomic, strong, readonly) UIImageView *backgroundView_protocol;

@end

NS_ASSUME_NONNULL_END
