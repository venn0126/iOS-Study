//
//  IGuideItem.h
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/6.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGuideAnnotationViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface IGuideItem : NSObject<IGuideAnnotationViewModelProtocol>

@property(nonatomic, weak, nullable) UIView *annotatedView; ///< 被注解对象（用于转换坐标，高亮区域坐标正确显示的情况下可为nil）
@property(nonatomic, assign) CGRect highlightFrameOfAnnotated; ///< 被注解对象需要高亮的区域
@property(nonatomic, assign) CGFloat cornerRadiusOfAnnotated; ///< 高亮区域的圆角
@property(nonatomic, assign) CGFloat spacingBetweenAnnotationAndAnnotated; ///< 注解和被注解对象之间的间距
@property(nonatomic, assign) CGPoint offsetOfIndicator; ///<  指示器横向和纵向的偏移
@property(nonatomic, strong) UIColor *shadowColor;

//MARK: - IGuideAnnotationViewModelProtocol
@property(nonatomic, strong, nonnull) NSString *annotationText; ///< 注解文字（对被注解对象的文字描述）
@property(nonatomic, strong, nullable) NSString *annotationTitle;
@property(nonatomic, strong, nullable) NSString *previousButtonTitle;
@property(nonatomic, strong, nullable) NSString *nextButtonTitle;
@property(nonatomic, strong, nullable) NSString *iconImageName;
@property(nonatomic, strong, nullable) NSString *backgroundImageName;

@end

NS_ASSUME_NONNULL_END
