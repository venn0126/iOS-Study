//
//  UIView+Extension.h
//  TestHookEncryption
//
//  Created by Augus on 2023/8/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)

@property (nonatomic, copy) UIView *(^st_backgroundColor)(UIColor *color);

@property (nonatomic, copy) UIView *(^st_frame)(CGRect rect);

#pragma mark 直接给控件frame赋值
@property (nonatomic, assign) CGFloat x ;
@property (nonatomic, assign) CGFloat y ;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


@end

@interface UIButton (UIButton___Extension)
#pragma mark Nomal状态button下各属性
//image
@property (nonatomic, copy) UIButton *(^st_nomalImage)(NSString *nomalImageName);
//title
@property (nonatomic, copy) UIButton *(^st_nomalTitle)(NSString *nomalTitle);
//titleColor
@property (nonatomic, copy) UIButton *(^st_nomalTitleColor)(UIColor *color );
//backgroudImage
@property (nonatomic, copy) UIButton *(^st_nomalBackgroundImage)(NSString *nomalBackgroundImageName);

#pragma mark Highlighted状态button下各属性
//image
@property (nonatomic, copy) UIButton *(^st_highlightedImage)(NSString *highlightedImageName);
//title
@property (nonatomic, copy) UIButton *(^st_highlightedTitle)(NSString *highlightedTitle);
//titleColor
@property (nonatomic, copy) UIButton *(^st_highlightedTitleColor)(UIColor *color );
//backgroudImage
@property (nonatomic, copy) UIButton *(^st_highlightedBackgroundImage)(NSString *highlightedBackgroundImageName);

#pragma mark Selected状态button下各属性

//image
@property (nonatomic, copy) UIButton *(^st_selectedImage)(NSString *selectedImageName);
//title
@property (nonatomic, copy) UIButton *(^st_selectedTitle)(NSString *selectedTitle);
//titleColor
@property (nonatomic, copy) UIButton *(^st_selectedTitleColor)(UIColor *color );
//backgroudImage
@property (nonatomic, copy) UIButton *(^st_selectedBackgroundImage)(NSString *selectedBackgroundImageName);

#pragma mark Disabled状态button下各属性

//image
@property (nonatomic, copy) UIButton *(^st_disabledImage)(NSString *disabledImageName);
//title
@property (nonatomic, copy) UIButton *(^st_disabledTitle)(NSString *disabledTitle);
//titleColor
@property (nonatomic, copy) UIButton *(^st_disabledTitleColor)(UIColor *color );
//backgroudImage
@property (nonatomic, copy) UIButton *(^st_disabledBackgroundImage)(NSString *disabledBackgroundImageName);

#pragma mark frame 及 textAlignment、font
//textAlignment
@property (nonatomic, copy) UIButton *(^st_textAlignment)(NSTextAlignment textAlignment);
//frame
@property (nonatomic, copy) UIButton *(^st_frame)(CGRect rect);
//font
@property (nonatomic, copy) UIButton *(^st_font)(CGFloat size);
@end

@interface UILabel (Extension)
//label.text
@property (nonatomic, copy) UILabel *(^st_title)(NSString *str);
//label.backgroundColor
@property (nonatomic, copy) UILabel *(^st_backgroundColor)(UIColor * color);
//label.textAlignment
@property (nonatomic, copy) UILabel *(^st_textAlignment)(NSTextAlignment textAlignment);
//frame
@property (nonatomic, copy) UILabel *(^st_frame)(CGRect rect);
//font
@property (nonatomic, copy) UILabel *(^st_font)(CGFloat size);
//textcolor
@property (nonatomic, copy) UILabel *(^st_textColor)(UIColor *color);
@end

@interface UIImageView (Extension)
@property (nonatomic, copy) UIImageView *(^st_backgroundColor)(UIColor *color);

@property (nonatomic, copy) UIImageView *(^st_frame)(CGRect rect);

@property (nonatomic, copy) UIImageView *(^st_image)(NSString *imageName);

@end


NS_ASSUME_NONNULL_END
