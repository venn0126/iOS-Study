
/*!
 *  @header TongThemeHelper.h
 *
 *  @brief  Tong主题管理
 *
 *  @author Augus
 *  @copyright    Copyright © 2016 - 2023年 Tong. All rights reserved.
 *  @version    V1.0.0
 */

FOUNDATION_EXPORT double TongThemeVersionNumber;
FOUNDATION_EXPORT const unsigned char TongThemeVersionString[];

#ifndef TongThemeHelper_h
#define TongThemeHelper_h

@class TongThemeConfigModel;

#pragma mark - 宏

#define TongColorRGBA(R , G , B , A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

#define TongColorRGB(R , G , B) TongColorRGBA(R , G , B , 1.0f)

#define TongColorHex(hex) [UIColor TongTheme_ColorWithHexString:hex]

#define TongColorFromIdentifier(tag, identifier) ({((UIColor *)([TongTheme getValueWithTag:tag Identifier:identifier]));})

#define TongImageFromIdentifier(tag, identifier) ({((UIImage *)([TongTheme getValueWithTag:tag Identifier:identifier]));})

#define TongValueFromIdentifier(tag, identifier) ({([TongTheme getValueWithTag:tag Identifier:identifier]);})

#pragma mark - typedef

NS_ASSUME_NONNULL_BEGIN

typedef void(^TongThemeConfigBlock)(id item);
typedef void(^TongThemeConfigBlockToValue)(id item , id value);
typedef void(^TongThemeChangingBlock)(NSString *tag , id item);
typedef TongThemeConfigModel * _Nonnull (^TongConfigTheme)(void);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToFloat)(CGFloat number);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToTag)(NSString *tag);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToKeyPath)(NSString *keyPath);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToSelector)(SEL selector);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToIdentifier)(NSString *identifier);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToChangingBlock)(TongThemeChangingBlock);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToT_KeyPath)(NSString *tag , NSString *keyPath);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToT_Selector)(NSString *tag , SEL selector);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToT_Color)(NSString *tag , id color);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToT_Image)(NSString *tag , id image);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToT_Block)(NSString *tag , TongThemeConfigBlock);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToTs_Block)(NSArray *tags , TongThemeConfigBlock);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToKeyPathAndIdentifier)(NSString *keyPath , NSString *identifier);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToSelectorAndIdentifier)(SEL sel , NSString *identifier);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToSelectorAndIdentifierAndValueIndexAndValueArray)(SEL sel , NSString *identifier , NSInteger valueIndex , NSArray *otherValues);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToSelectorAndValues)(SEL sel , NSArray *values);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToIdentifierAndState)(NSString *identifier , UIControlState state);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToT_ColorAndState)(NSString *tag , UIColor *color , UIControlState state);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToT_ImageAndState)(NSString *tag , UIImage *image , UIControlState state);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToT_KeyPathAndValue)(NSString *tag , NSString *keyPath , id value);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToT_SelectorAndColor)(NSString *tag , SEL sel , id color);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToT_SelectorAndImage)(NSString *tag , SEL sel , id image);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToT_SelectorAndValues)(NSString *tag , SEL sel , ...);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToT_SelectorAndValueArray)(NSString *tag , SEL sel , NSArray *values);
typedef TongThemeConfigModel * _Nonnull (^TongConfigThemeToIdentifierAndBlock)(NSString *identifier , TongThemeConfigBlockToValue);

NS_ASSUME_NONNULL_END

#endif /* TongThemeHelper_h */
