//
//  IGuideAnnotationViewModelProtocol.h
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/6.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 为"注解"视图提供数据的协议
 */
@protocol IGuideAnnotationViewModelProtocol <NSObject>

@required
- (NSString *)annotationText;

@optional
- (nullable NSString *)previousButtonTitle;
- (nullable NSString *)nextButtonTitle;
- (nullable NSString *)annotationTitle;
- (nullable NSString *)iconImageName;
- (nullable NSString *)backgroundImageName;

@end

NS_ASSUME_NONNULL_END
