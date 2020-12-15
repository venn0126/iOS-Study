//
//  FSGuideAnnotationViewModelProtocol.h
//  fosFloatView
//
//  Created by Augus on 2020/11/18.
//

/**
 为"注解"视图提供数据的协议
 */
@protocol FSGuideAnnotationViewModelProtocol <NSObject>

@required
- (NSString *_Nullable)annotationText;

@optional
- (nullable NSString *)previousButtonTitle;
- (nullable NSString *)nextButtonTitle;
- (nullable NSString *)annotationTitle;
- (nullable NSString *)iconImageName;
- (nullable NSString *)backgroundImageName;


@end
