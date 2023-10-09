
/*!
 *  @header TongTheme.h
 *
 *
 *  @brief  Tong主题管理
 *
 *  @author Tong
 *  @copyright    Copyright © 2016 - 2023年 Tong. All rights reserved.
 *  @version    V1.0.0
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TongThemeHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface TongTheme : NSObject

/**
 *  启动主题
 *
 *  @param tag 主题标签
 */
+ (void)startTheme:(NSString *)tag;

/**
 *  默认主题 (必设置 , 应用程序最少需要一个默认主题)
 *
 *
 *  @param tag 主题标签
 */
+ (void)defaultTheme:(NSString *)tag;

/**
 *  当前主题标签
 *
 *  @return 主题标签 tag
 */
+ (NSString *)currentThemeTag;

/**
 *  全部主题标签
 *
 *  @return 主题标签集合
 */
+ (NSArray *)allThemeTag;

@end

@interface TongTheme (JsonModeExtend)

/**
 *  添加主题设置Json
 *
 *  @param json json字符串
 *  @param tag 主题标签
 *  @param path 资源路径 (在Documents目录下的路径 如果资源不在Documents目录下应传入nil 例: ResourcesPath:@@"themeResources/day/")
 */
+ (void)addThemeConfigWithJson:(NSString *)json Tag:(NSString *)tag ResourcesPath:(NSString * _Nullable)path;

/**
 *  移除主题设置
 *
 *  @param tag 主题标签
 */
+ (void)removeThemeConfigWithTag:(NSString *)tag;

/**
 *  获取指定主题标签的资源路径
 *
 *  @param tag 主题标签
 *
 *  @return 资源路径 (如为不存在则返回mainBundle路径)
 */
+ (NSString *)getResourcesPathWithTag:(NSString *)tag;

/**
 *  获取值
 *
 *  @param tag          主题标签
 *  @param identifier   标识符
 *
 *  @return 值对象 (UIColor或UIImage或NSString 如为不存在则返回nil)
 */
+ (id)getValueWithTag:(NSString *)tag Identifier:(NSString *)identifier;

@end

@interface TongThemeConfigModel : NSObject

/** ----默认设置方式---- */

/** Block */

/** 主题改变Block -> 格式: .TongThemeChangingBlock(^(NSString *tag , id item){ code... }) */
@property (nonatomic , copy , readonly ) TongConfigThemeToChangingBlock TongThemeChangingBlock;

/** 添加自定义设置 -> 格式: .TongAddCustomConfig(@@"tag" , ^(id item){ code... }) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Block TongAddCustomConfig;

/** 添加多标签自定义设置 -> 格式: .TongAddCustomConfigs(@@[tag1 , tag2] , ^(id item){ code... }) */
@property (nonatomic , copy , readonly ) TongConfigThemeToTs_Block TongAddCustomConfigs;

/** Color快捷设置方法 */

/** 添加渲染颜色设置 -> 格式: .TongAddTintColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddTintColor;

/** 添加文本颜色设置 -> 格式: .TongAddTextColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddTextColor;

/** 添加填充颜色设置 -> 格式: .TongAddFillColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddFillColor;

/** 添加笔画颜色设置 -> 格式: .TongAddStrokeColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddStrokeColor;

/** 添加边框颜色设置 -> 格式: .TongAddBorderColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddBorderColor;

/** 添加阴影颜色设置 -> 格式: .TongAddShadowColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddShadowColor;

/** 添加开关开启颜色设置 -> 格式: .TongAddOnTintColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddOnTintColor;

/** 添加开关按钮颜色设置 -> 格式: .TongAddThumbTintColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddThumbTintColor;

/** 添加分隔线颜色设置 -> 格式: .TongAddSeparatorColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddSeparatorColor;

/** 添加bar渲染颜色设置 -> 格式: .TongAddBarTintColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddBarTintColor;

/** 添加背景颜色设置 -> 格式: .TongAddBackgroundColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddBackgroundColor;

/** 添加占位符颜色设置 -> 格式: .TongAddPlaceholderColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddPlaceholderColor;

/** 添加进度轨道渲染颜色设置 -> 格式: .TongAddTrackTintColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddTrackTintColor;

/** 添加进度渲染颜色设置 -> 格式: .TongAddProgressTintColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddProgressTintColor;

/** 添加高亮文本颜色设置 -> 格式: .TongAddHighlightedTextColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddHighlightedTextColor;

/** 添加页数指示渲染颜色设置 -> 格式: .TongAddPageIndicatorTintColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddPageIndicatorTintColor;

/** 添加当前页数指示渲染颜色设置 -> 格式: .TongAddCurrentPageIndicatorTintColor(@@"tag" , UIColor) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Color TongAddCurrentPageIndicatorTintColor;

/** 添加按钮标题颜色设置 -> 格式: .TongAddButtonTitleColor(@@"tag" , UIColor , UIControlStateNormal) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_ColorAndState TongAddButtonTitleColor;

/** 添加按钮标题阴影颜色设置 -> 格式: .TongAddButtonTitleShadowColor(@@"tag" , UIColor , UIControlStateNormal) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_ColorAndState TongAddButtonTitleShadowColor;

/** Image快捷设置方法 */

/** 添加图片设置 -> 格式: .TongAddImage(@@"tag" , UIImage 或 @@"imageName" 或 @@"imagePath") */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Image TongAddImage;

/** 添加进度轨道图片设置 -> 格式: .TongAddTrackImage(@@"tag" , UIImage 或 @@"imageName" 或 @@"imagePath") */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Image TongAddTrackImage;

/** 添加进度图片设置 -> 格式: .TongAddProgressImage(@@"tag" , UIImage 或 @@"imageName" 或 @@"imagePath") */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Image TongAddProgressImage;

/** 添加阴影图片设置 -> 格式: .TongAddShadowImage(@@"tag" , UIImage 或 @@"imageName" 或 @@"imagePath") */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Image TongAddShadowImage;

/** 添加选中图片设置 -> 格式: .TongAddSelectedImage(@@"tag" , UIImage 或 @@"imageName" 或 @@"imagePath") */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Image TongAddSelectedImage;

/** 添加背景图片设置 -> 格式: .TongAddBackgroundImage(@@"tag" , UIImage 或 @@"imageName" 或 @@"imagePath") */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Image TongAddBackgroundImage;

/** 添加返回指示图片设置 -> 格式: .TongAddBackIndicatorImage(@@"tag" , UIImage 或 @@"imageName" 或 @@"imagePath") */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Image TongAddBackIndicatorImage;

/** 添加返回指示图片设置 -> 格式: .TongAddBackIndicatorTransitionMaskImage(@@"tag" , UIImage 或 @@"imageName" 或 @@"imagePath") */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Image TongAddBackIndicatorTransitionMaskImage;

/** 添加选择指示器图片设置 -> 格式: .TongAddSelectionIndicatorImage(@@"tag" , UIImage 或 @@"imageName" 或 @@"imagePath") */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Image TongAddSelectionIndicatorImage;

/** 添加分栏背景图片设置 -> 格式: .TongAddScopeBarBackgroundImage(@@"tag" , UIImage 或 @@"imageName" 或 @@"imagePath") */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Image TongAddScopeBarBackgroundImage;

/** 添加按钮图片设置 -> 格式: .TongAddButtonImage(@@"tag" , UIImage , UIControlStateNormal) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_ImageAndState TongAddButtonImage;

/** 添加按钮背景图片设置 -> 格式: .TongAddButtonBackgroundImage(@@"tag" , UIImage , UIControlStateNormal) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_ImageAndState TongAddButtonBackgroundImage;


/** 添加颜色设置 -> 格式: .TongAddSelectorAndColor(@@"tag" , @@selector(XXX:) , UIColor 或 @"F3F3F3") */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_SelectorAndColor TongAddSelectorAndColor;

/** 添加图片设置 -> 格式: .TongAddSelectorAndImage(@@"tag" , @@selector(XXX:) , UIImage 或 @"imageName" 或 @"imagePath") */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_SelectorAndImage TongAddSelectorAndImage;


/** 基础设置方法 */

/** 添加路径设置 -> 格式: .TongAddKeyPathAndValue(@@"tag" , @@"keyPath" , id) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_KeyPathAndValue TongAddKeyPathAndValue;

/** 添加方法设置 -> 格式: .TongAddSelectorAndValues(@@"tag" , @@selector(XXX:XXX:) , id , id) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_SelectorAndValues TongAddSelectorAndValues;

/** 添加方法设置 -> 格式: .TongAddSelectorAndValueArray(@@"tag" , @@selector(XXX:XXX:) , @@[id , id]) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_SelectorAndValueArray TongAddSelectorAndValueArray;

/** 移除路径设置 -> 格式: .TongRemoveKeyPath(@@"tag" , @@"keyPath") */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_KeyPath TongRemoveKeyPath;

/** 移除方法设置 -> 格式: .TongRemoveSelector(@@"tag" , @@selector(XXX:XXX:)) */
@property (nonatomic , copy , readonly ) TongConfigThemeToT_Selector TongRemoveSelector;


/** 移除全部设置 -> 格式: .TongClearAllConfig() */
@property (nonatomic , copy , readonly ) TongConfigTheme TongClearAllConfig;

/** 移除标签全部的设置 -> 格式: .TongClearAllConfig_Tag(@@"tag") */
@property (nonatomic , copy , readonly ) TongConfigThemeToTag TongClearAllConfig_Tag;

/** 移除路径全部的设置 -> 格式: .TongClearAllConfig_KeyPath(@@"keyPath") */
@property (nonatomic , copy , readonly ) TongConfigThemeToKeyPath TongClearAllConfig_KeyPath;

/** 移除方法全部的设置 -> 格式: .TongClearAllConfig_Selector(@selector(XXXX:)) */
@property (nonatomic , copy , readonly ) TongConfigThemeToSelector TongClearAllConfig_Selector;

@end

@interface TongThemeConfigModel (IdentifierModeExtend)

/** Block */

/** 自定义设置 -> 格式: .TongCustomConfig(@@"identifier" , ^(id item , id value){ code... }) */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifierAndBlock TongCustomConfig;

/** Color快捷设置方法 */

/** 设置渲染颜色标识符 -> 格式: .TongConfigTintColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigTintColor;

/** 设置文本颜色标识符 -> 格式: .TongConfigTextColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigTextColor;

/** 设置填充颜色标识符 -> 格式: .TongConfigFillColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigFillColor;

/** 设置笔画颜色标识符 -> 格式: .TongConfigStrokeColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigStrokeColor;

/** 设置边框颜色标识符 -> 格式: .TongConfigBorderColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigBorderColor;

/** 设置文本颜色标识符 -> 格式: .TongConfigShadowColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigShadowColor;

/** 设置开关开启颜色标识符 -> 格式: .TongConfigOnTintColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigOnTintColor;

/** 设置开关按钮颜色标识符 -> 格式: .TongConfigThumbTintColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigThumbTintColor;

/** 设置分隔线颜色标识符 -> 格式: .TongConfigSeparatorColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigSeparatorColor;

/** 设置bar渲染颜色标识符 -> 格式: .TongConfigBarTintColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigBarTintColor;

/** 设置背景颜色标识符 -> 格式: .TongConfigBackgroundColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigBackgroundColor;

/** 设置占位符颜色标识符 -> 格式: .TongConfigPlaceholderColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigPlaceholderColor;

/** 设置进度轨道渲染颜色标识符 -> 格式: .TongConfigTrackTintColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigTrackTintColor;

/** 设置进度渲染颜色标识符 -> 格式: .TongConfigProgressTintColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigProgressTintColor;

/** 设置高亮文本颜色标识符 -> 格式: .TongConfigHighlightedTextColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigHighlightedTextColor;

/** 设置页数指示渲染颜色标识符 -> 格式: .TongConfigPageIndicatorTintColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigPageIndicatorTintColor;

/** 设置当前页数指示渲染颜色标识符 -> 格式: .TongConfigCurrentPageIndicatorTintColor(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigCurrentPageIndicatorTintColor;

/** 设置按钮标题颜色标识符 -> 格式: .TongConfigButtonTitleColor(@@"identifier" , UIControlStateNormal) */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifierAndState TongConfigButtonTitleColor;

/** 设置按钮标题阴影颜色标识符 -> 格式: .TongConfigButtonTitleColor(@@"identifier" , UIControlStateNormal) */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifierAndState TongConfigButtonTitleShadowColor;

/** Image快捷设置方法 */

/** 设置图片标识符 -> 格式: .TongConfigImage(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigImage;

/** 设置进度轨道图片标识符 -> 格式: .TongConfigTrackImage(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigTrackImage;

/** 设置进度图片标识符 -> 格式: .TongConfigProgressImage(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigProgressImage;

/** 设置阴影图片标识符 -> 格式: .TongConfigShadowImage(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigShadowImage;

/** 设置选中图片标识符 -> 格式: .TongConfigSelectedImage(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigSelectedImage;

/** 设置背景图片标识符 -> 格式: .TongConfigBackgroundImage(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigBackgroundImage;

/** 设置返回指示图片标识符 -> 格式: .TongConfigBackIndicatorImage(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigBackIndicatorImage;

/** 设置返回指示图片标识符 -> 格式: .TongConfigBackIndicatorTransitionMaskImage(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigBackIndicatorTransitionMaskImage;

/** 设置选择指示器图片标识符 -> 格式: .TongConfigSelectionIndicatorImage(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigSelectionIndicatorImage;

/** 设置分栏背景图片标识符 -> 格式: .TongConfigScopeBarBackgroundImage(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongConfigScopeBarBackgroundImage;

/** 设置按钮图片标识符 -> 格式: .TongConfigButtonImage(@@"identifier" , UIControlStateNormal) */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifierAndState TongConfigButtonImage;

/** 设置按钮背景图片标识符 -> 格式: .TongConfigButtonBackgroundImage(@@"identifier" , UIControlStateNormal) */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifierAndState TongConfigButtonBackgroundImage;

/** 基础设置方法 */

/** 设置路径标识符 -> 格式: .TongConfigKeyPathAndIdentifier(@@"keyPath" , @@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToKeyPathAndIdentifier TongConfigKeyPathAndIdentifier;

/** 设置方法标识符 -> 格式: .TongConfigSelectorAndIdentifier(@@selector(XXX:) , @@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToSelectorAndIdentifier TongConfigSelectorAndIdentifier;

/** 设置方法标识符 -> 格式: .TongConfigSelectorAndValueArray(@@selector(XXX:XXX:) , @@[id , id]) */
@property (nonatomic , copy , readonly ) TongConfigThemeToSelectorAndValues TongConfigSelectorAndValueArray;

/** 移除路径标识符设置 -> 格式: .TongRemoveKeyPathIdentifier(@@"keyPath") */
@property (nonatomic , copy , readonly ) TongConfigThemeToKeyPath TongRemoveKeyPathIdentifier;

/** 移除方法标识符设置 -> 格式: .TongRemoveSelectorIdentifier(@@selector(XXX:)) */
@property (nonatomic , copy , readonly ) TongConfigThemeToSelector TongRemoveSelectorIdentifier;

/** 移除标识符设置 -> 格式: .TongRemoveIdentifier(@@"identifier") */
@property (nonatomic , copy , readonly ) TongConfigThemeToIdentifier TongRemoveIdentifier;


/** 移除全部设置(标识符模式) -> 格式: .TongClearAllConfigOnIdentifierMode() */
@property (nonatomic , copy , readonly ) TongConfigTheme TongClearAllConfigOnIdentifierMode;

@end

@interface TongThemeIdentifier : NSString

+ (TongThemeIdentifier *)ident:(NSString *)ident;

@end

@interface NSObject (TongThemeConfigObject)

@property (nonatomic , strong ) TongThemeConfigModel *Tong_theme;

@end

@interface UIColor (TongThemeColor)

+ (UIColor *)TongTheme_ColorWithHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END

/*
 *
 *          ┌─┐       ┌─┐
 *       ┌──┘ ┴───────┘ ┴──┐
 *       │                 │
 *       │       ───       │
 *       │  ─┬┘       └┬─  │
 *       │                 │
 *       │       ─┴─       │
 *       │                 │
 *       └───┐         ┌───┘
 *           │         │
 *           │         │
 *           │         │
 *           │         └──────────────┐
 *           │                        │
 *           │                        ├─┐
 *           │                        ┌─┘
 *           │                        │
 *           └─┐  ┐  ┌───────┬──┐  ┌──┘
 *             │ ─┤ ─┤       │ ─┤ ─┤
 *             └──┴──┘       └──┴──┘
 *                 神兽 保佑
 *                 代码无BUG!
 */
