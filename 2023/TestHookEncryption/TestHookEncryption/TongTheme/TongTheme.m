/*!
 *  @header TongTheme.m
 *
 *  @brief  Tong主题管理
 *
 *  @author Tong
 *  @copyright    Copyright © 2016 - 2019年 Tong. All rights reserved.
 *  @version    V1.1.8
 */

#import "TongTheme.h"

#import <objc/runtime.h>
#import <objc/message.h>

static NSString * const TongThemeChangingNotificaiton = @"TongThemeChangingNotificaiton";
static NSString * const TongThemeAddTagNotificaiton = @"TongThemeAddTagNotificaiton";
static NSString * const TongThemeRemoveTagNotificaiton = @"TongThemeRemoveTagNotificaiton";
static NSString * const TongThemeAllTags = @"TongThemeAllTags";
static NSString * const TongThemeCurrentTag = @"TongThemeCurrentTag";
static NSString * const TongThemeConfigInfo = @"TongThemeConfigInfo";

@interface TongTheme ()

@property (nonatomic , copy ) NSString *defaultTag;

@property (nonatomic , copy ) NSString *currentTag;

@property (nonatomic , strong ) NSMutableArray *allTags;

@property (nonatomic , strong ) NSMutableDictionary *configInfo;

@end

@implementation TongTheme

#if !__has_feature(objc_arc)
#error "ARC才可以  ( *・ω・)✄╰ひ╯ "
#endif

+ (TongTheme *)shareTheme{
    
    static TongTheme *themeManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        themeManager = [[TongTheme alloc]init];
    });
    
    return themeManager;
}

#pragma mark Public

+ (void)startTheme:(NSString *)tag{
    
    NSAssert([[TongTheme shareTheme].allTags containsObject:tag], @"所启用的主题不存在 - 请检查是否添加了该%@主题的设置" , tag);
    
    if (!tag) return;
    
    [TongTheme shareTheme].currentTag = tag;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TongThemeChangingNotificaiton object:nil userInfo:nil];
}

+ (void)defaultTheme:(NSString *)tag{
    
    if (!tag) return;
    
    [TongTheme shareTheme].defaultTag = tag;
    
    if (![TongTheme shareTheme].currentTag && ![[NSUserDefaults standardUserDefaults] objectForKey:TongThemeCurrentTag]) [TongTheme shareTheme].currentTag = tag;
}

+ (NSString *)currentThemeTag{
    
    return [TongTheme shareTheme].currentTag ? [TongTheme shareTheme].currentTag : [[NSUserDefaults standardUserDefaults] objectForKey:TongThemeCurrentTag];
}

+ (NSArray *)allThemeTag{
    
    return [[TongTheme shareTheme].allTags copy];
}

#pragma mark Private

- (void)setCurrentTag:(NSString *)currentTag{
    
    _currentTag = currentTag;
    
    [[NSUserDefaults standardUserDefaults] setObject:currentTag forKey:TongThemeCurrentTag];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveConfigInfo{
    
    [[NSUserDefaults standardUserDefaults] setObject:self.configInfo forKey:TongThemeConfigInfo];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)addTagToAllTags:(NSString *)tag{
    
    if (![[TongTheme shareTheme].allTags containsObject:tag]) {
        
        [[TongTheme shareTheme].allTags addObject:tag];
        
        [[NSUserDefaults standardUserDefaults] setObject:[TongTheme shareTheme].allTags forKey:TongThemeAllTags];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

+ (void)removeTagToAllTags:(NSString *)tag{
    
    if ([[TongTheme shareTheme].allTags containsObject:tag]) {
        
        [[TongTheme shareTheme].allTags removeObject:tag];
        
        [[NSUserDefaults standardUserDefaults] setObject:[TongTheme shareTheme].allTags forKey:TongThemeAllTags];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

#pragma mark - LazyLoading

- (NSMutableArray *)allTags{
    
    if (!_allTags) _allTags = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:TongThemeAllTags]];

    return _allTags;
}

- (NSMutableDictionary *)configInfo{
    
    if (!_configInfo) _configInfo = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:TongThemeConfigInfo]];
    
    return _configInfo;
}

@end

@implementation TongTheme (JsonModeExtend)

+ (void)addThemeConfigWithJson:(NSString *)json Tag:(NSString *)tag ResourcesPath:(NSString *)path{
    
    if (json) {
        
        NSError *jsonError = nil;
        
        NSDictionary *jsonConfigInfo = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonError];
        
        NSAssert(!jsonError, @"添加的主题json配置数据解析错误 - 错误描述");
        NSAssert(jsonConfigInfo, @"添加的主题json配置数据解析为空 - 请检查");
        NSAssert(tag, @"添加的主题json标签不能为空");
        
        if (!jsonError && jsonConfigInfo) {
        
            [[TongTheme shareTheme].configInfo setValue:[NSMutableDictionary dictionaryWithObjectsAndKeys:jsonConfigInfo , @"info", path , @"path" , nil] forKey:tag];
            
            [[TongTheme shareTheme] saveConfigInfo];
            
            [TongTheme addTagToAllTags:tag];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:TongThemeAddTagNotificaiton object:nil userInfo:@{@"tag" : tag}];
        }
        
    }
    
}

+ (void)removeThemeConfigWithTag:(NSString *)tag{
    
    if ([[TongTheme shareTheme].allTags containsObject:tag] && ![[TongTheme shareTheme].defaultTag isEqualToString:tag]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:TongThemeRemoveTagNotificaiton object:nil userInfo:@{@"tag" : tag}];
        
        [TongTheme removeTagToAllTags:tag];
        
        [[TongTheme shareTheme].configInfo removeObjectForKey:tag];
        
        [[TongTheme shareTheme] saveConfigInfo];
        
        if ([[TongTheme currentThemeTag] isEqualToString:tag]) [TongTheme startTheme:[TongTheme shareTheme].defaultTag];
    }
    
}

+ (NSString *)getResourcesPathWithTag:(NSString *)tag{
    
    NSString *path = [TongTheme shareTheme].configInfo[tag][@"path"];
    
    return path ? path : [[NSBundle mainBundle] bundlePath];
}

+ (id)getValueWithTag:(NSString *)tag Identifier:(NSString *)identifier{
    
    id value = nil;
    
    NSDictionary *configInfo = [TongTheme shareTheme].configInfo[tag];
    
    NSDictionary *info = configInfo[@"info"];
    
    NSDictionary *colorInfo = info[@"color"];
    
    NSString *colorHexString = colorInfo[identifier];
    
    if (colorHexString) {
        
        UIColor *color = [UIColor TongTheme_ColorWithHexString:colorHexString];
        
        if (color && !value) value = color;
    }
    
    NSDictionary *imageInfo = info[@"image"];
    
    NSString *imageName = imageInfo[identifier];
    
    if (imageName) {
        
        NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        
        NSString *path = configInfo[@"path"];
        
        if (path) path = [documentsPath stringByAppendingPathComponent:path];
        
        UIImage *image = path ? [UIImage imageWithContentsOfFile:[path stringByAppendingPathComponent:imageName]] : [UIImage imageNamed:imageName];
        
        if (!image) image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:imageName]];
        
        if (!image) image = [UIImage imageNamed:imageName];
        
        if (image && !value) value = image;
    }
    
    NSDictionary *otherInfo = info[@"other"];
    
    if (!value) value = otherInfo[identifier];
    
    return value;
}

@end

#pragma mark - ----------------主题设置模型----------------

@interface TongThemeConfigModel ()

@property (nonatomic , copy ) void(^modelUpdateCurrentThemeConfig)(void);
@property (nonatomic , copy ) void(^modelConfigThemeChangingBlock)(void);

@property (nonatomic , copy ) TongThemeChangingBlock modelChangingBlock;

@property (nonatomic , copy ) NSString *modelCurrentThemeTag;

@property (nonatomic , strong ) NSMutableDictionary <NSString * , NSMutableDictionary *>*modelThemeBlockConfigInfo; // @{tag : @{block : value}}
@property (nonatomic , strong ) NSMutableDictionary <NSString * , NSMutableDictionary *>*modelThemeKeyPathConfigInfo; // @{keypath : @{tag : value}}
@property (nonatomic , strong ) NSMutableDictionary <NSString * , NSMutableDictionary *>*modelThemeSelectorConfigInfo; // @{selector : @{tag : @[@[parameter, parameter,...] , @[...]]}}

@end

@implementation TongThemeConfigModel

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    objc_removeAssociatedObjects(self);
    
    _modelCurrentThemeTag = nil;
    _modelThemeBlockConfigInfo = nil;
    _modelThemeKeyPathConfigInfo = nil;
    _modelThemeSelectorConfigInfo = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TongTheme_RemoveThemeTagNotify:) name:TongThemeRemoveTagNotificaiton object:nil];
    }
    return self;
}

- (void)TongTheme_RemoveThemeTagNotify:(NSNotification *)notify{
    
    NSString *tag = notify.userInfo[@"tag"];
    
    self.TongClearAllConfig_Tag(tag);
}

- (void)updateCurrentThemeConfigHandleWithTag:(NSString *)tag{
    
    if ([[TongTheme currentThemeTag] isEqualToString:tag]) {
        
        if ([NSThread isMainThread]) {
            
            if (self.modelUpdateCurrentThemeConfig) self.modelUpdateCurrentThemeConfig();
        
        } else {
        
            dispatch_async(dispatch_get_main_queue(), ^{
               
                if (self.modelUpdateCurrentThemeConfig) self.modelUpdateCurrentThemeConfig();
            });
        }
        
    }
    
}

- (TongConfigThemeToChangingBlock)TongThemeChangingBlock{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(TongThemeChangingBlock changingBlock){
        
        if (changingBlock) {
            
            weakSelf.modelChangingBlock = changingBlock;
            
            if (weakSelf.modelConfigThemeChangingBlock) weakSelf.modelConfigThemeChangingBlock();
        }
            
        return weakSelf;
    };
    
}

- (TongConfigThemeToT_Block)TongAddCustomConfig{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , TongThemeConfigBlock configBlock){
        
        if (configBlock) {
            
            [TongTheme addTagToAllTags:tag];
            
            NSMutableDictionary *info = weakSelf.modelThemeBlockConfigInfo[tag];
            
            if (!info) info = [NSMutableDictionary dictionary];
            
            [info setObject:[NSNull null] forKey:configBlock];
            
            [weakSelf.modelThemeBlockConfigInfo setObject:info forKey:tag];
            
            [weakSelf updateCurrentThemeConfigHandleWithTag:tag];
        }
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToTs_Block)TongAddCustomConfigs{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSArray *tags , TongThemeConfigBlock configBlock){
        
        if (configBlock) {
            
            [tags enumerateObjectsUsingBlock:^(NSString *tag, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [TongTheme addTagToAllTags:tag];
                
                NSMutableDictionary *info = weakSelf.modelThemeBlockConfigInfo[tag];
                
                if (!info) info = [NSMutableDictionary dictionary];
                
                [info setObject:[NSNull null] forKey:configBlock];
                
                [weakSelf.modelThemeBlockConfigInfo setObject:info forKey:tag];
                
                [weakSelf updateCurrentThemeConfigHandleWithTag:tag];
            }];

        }
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToT_Color)TongAddTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setTintColor:) , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddTextColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setTextColor:) , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddFillColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setFillColor:) , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddStrokeColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setStrokeColor:) , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddBorderColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setBorderColor:) , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddShadowColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setShadowColor:) , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddOnTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setOnTintColor:) , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddThumbTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setThumbTintColor:) , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddSeparatorColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setSeparatorColor:) , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddBarTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setBarTintColor:) , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddBackgroundColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setBackgroundColor:) , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddPlaceholderColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddKeyPathAndValue(tag , @"_placeholderLabel.textColor" , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddTrackTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setTrackTintColor:) , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddProgressTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setProgressTintColor:) , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddHighlightedTextColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setHighlightedTextColor:) , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddCurrentPageIndicatorTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setCurrentPageIndicatorTintColor:) , color);
    };
    
}

- (TongConfigThemeToT_Color)TongAddPageIndicatorTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id color){
        
        return weakSelf.TongAddSelectorAndColor(tag , @selector(setPageIndicatorTintColor:) , color);
    };
    
}

- (TongConfigThemeToT_ColorAndState)TongAddButtonTitleColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , UIColor *color , UIControlState state){
        
        return weakSelf.TongAddSelectorAndValues(tag , @selector(setTitleColor:forState:) , color , @(state) , nil);
    };
    
}

- (TongConfigThemeToT_ColorAndState)TongAddButtonTitleShadowColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , UIColor *color , UIControlState state){
        
        return weakSelf.TongAddSelectorAndValues(tag , @selector(setTitleShadowColor:forState:) , color , @(state), nil);
    };
    
}

- (TongConfigThemeToT_Image)TongAddImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id image){
        
        return weakSelf.TongAddSelectorAndImage(tag , @selector(setImage:) , image);
    };
    
}

- (TongConfigThemeToT_Image)TongAddTrackImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id image){
        
        return weakSelf.TongAddSelectorAndImage(tag , @selector(setTrackImage:) , image);
    };
    
}

- (TongConfigThemeToT_Image)TongAddProgressImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id image){
        
        return weakSelf.TongAddSelectorAndImage(tag , @selector(setProgressImage:) , image);
    };
    
}

- (TongConfigThemeToT_Image)TongAddShadowImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id image){
        
        return weakSelf.TongAddSelectorAndImage(tag , @selector(setShadowImage:) , image);
    };
    
}

- (TongConfigThemeToT_Image)TongAddSelectedImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id image){
        
        return weakSelf.TongAddSelectorAndImage(tag , @selector(setSelectedImage:) , image);
    };
    
}

- (TongConfigThemeToT_Image)TongAddBackgroundImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id image){
        
        return weakSelf.TongAddSelectorAndImage(tag , @selector(setBackgroundImage:) , image);
    };
    
}

- (TongConfigThemeToT_Image)TongAddBackIndicatorImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id image){
        
        return weakSelf.TongAddSelectorAndImage(tag , @selector(setBackIndicatorImage:) , image);
    };
    
}

- (TongConfigThemeToT_Image)TongAddBackIndicatorTransitionMaskImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id image){
        
        return weakSelf.TongAddSelectorAndImage(tag , @selector(setBackIndicatorTransitionMaskImage:) , image);
    };
    
}

- (TongConfigThemeToT_Image)TongAddSelectionIndicatorImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id image){
        
        return weakSelf.TongAddSelectorAndImage(tag , @selector(setSelectionIndicatorImage:) , image);
    };
    
}

- (TongConfigThemeToT_Image)TongAddScopeBarBackgroundImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id image){
        
        return weakSelf.TongAddSelectorAndImage(tag , @selector(setScopeBarBackgroundImage:) , image);
    };
    
}

- (TongConfigThemeToT_ImageAndState)TongAddButtonImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , UIImage *image , UIControlState state){
        
        return weakSelf.TongAddSelectorAndValues(tag , @selector(setImage:forState:) , image , @(state), nil);
    };
    
}

- (TongConfigThemeToT_ImageAndState)TongAddButtonBackgroundImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , UIImage *image , UIControlState state){
        
        return weakSelf.TongAddSelectorAndValues(tag , @selector(setBackgroundImage:forState:) , image , @(state), nil);
    };
    
}

- (TongConfigThemeToT_SelectorAndColor)TongAddSelectorAndColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , SEL sel , id color){
        
        id value = nil;
        
        if ([color isKindOfClass:NSString.class]) {
            
            value = [UIColor TongTheme_ColorWithHexString:color];
            
        } else {
            
            value = color;
        }
        
        if (value) weakSelf.TongAddSelectorAndValueArray(tag , sel , @[value]);
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToT_SelectorAndImage)TongAddSelectorAndImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , SEL sel , id image){
        
        id value = nil;
        
        if ([image isKindOfClass:NSString.class]) {
            
            value = [UIImage imageNamed:image];
            
            if (!value) value = [UIImage imageWithContentsOfFile:image];
            
        } else {
            
            value = image;
        }
        
        if (value) weakSelf.TongAddSelectorAndValueArray(tag , sel , @[value]);
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToT_KeyPathAndValue)TongAddKeyPathAndValue{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , NSString *keyPath , id value){
        
        if (!value) return weakSelf;
        
        [TongTheme addTagToAllTags:tag];
        
        NSMutableDictionary *info = weakSelf.modelThemeKeyPathConfigInfo[keyPath];
        
        if (!info) info = [NSMutableDictionary dictionary];
        
        [info setObject:value forKey:tag];
        
        [weakSelf.modelThemeKeyPathConfigInfo setObject:info forKey:keyPath];
        
        [weakSelf updateCurrentThemeConfigHandleWithTag:tag];
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToT_SelectorAndValues)TongAddSelectorAndValues{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag, SEL sel , ...){
        
        if (!sel) return weakSelf;
        
        NSMutableArray *array = [NSMutableArray array];
        
        va_list argsList;
        
        va_start(argsList, sel);
        
        id arg;
        
        while ((arg = va_arg(argsList, id))) {
            
            [array addObject:arg];
        }
        
        va_end(argsList);
        
        return weakSelf.TongAddSelectorAndValueArray(tag, sel, array);
    };
    
}

- (TongConfigThemeToT_SelectorAndValueArray)TongAddSelectorAndValueArray{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag, SEL sel , NSArray *values){
      
        if (!tag) return weakSelf;
        
        if (!sel) return weakSelf;
        
        [TongTheme addTagToAllTags:tag];
        
        NSString *key = NSStringFromSelector(sel);
        
        NSMutableDictionary *info = weakSelf.modelThemeSelectorConfigInfo[key];
        
        if (!info) info = [NSMutableDictionary dictionary];
        
        NSMutableArray *valuesArray = info[tag];
        
        if (!valuesArray) valuesArray = [NSMutableArray array];
        
        NSArray *temp = [valuesArray copy];
        
        [temp enumerateObjectsUsingBlock:^(NSArray *valueArray, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([valueArray isEqualToArray:values]) [valuesArray removeObject:valueArray]; // 过滤相同参数值的数组
        }];
        
        if (values && values.count) [valuesArray addObject:values];
        
        [info setObject:valuesArray forKey:tag];
        
        [weakSelf.modelThemeSelectorConfigInfo setObject:info forKey:key];
        
        [weakSelf updateCurrentThemeConfigHandleWithTag:tag];
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToT_KeyPath)TongRemoveKeyPath{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , NSString *keyPath){
        
        NSMutableDictionary *info = weakSelf.modelThemeKeyPathConfigInfo[keyPath];
        
        if (info) {
            
            [info removeObjectForKey:tag];
            
            [weakSelf.modelThemeKeyPathConfigInfo setObject:info forKey:keyPath];
        }
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToT_Selector)TongRemoveSelector{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , SEL sel){
        
        NSMutableDictionary *info = weakSelf.modelThemeSelectorConfigInfo[NSStringFromSelector(sel)];
        
        if (info) {
            
            [info removeObjectForKey:tag];
            
            [weakSelf.modelThemeSelectorConfigInfo setObject:info forKey:NSStringFromSelector(sel)];
        }
        
        return weakSelf;
    };
    
}

- (TongConfigTheme)TongClearAllConfig{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(){
        
        weakSelf.modelChangingBlock = nil;
        
        [weakSelf.modelThemeBlockConfigInfo removeAllObjects];
        
        [weakSelf.modelThemeKeyPathConfigInfo removeAllObjects];
        
        [weakSelf.modelThemeSelectorConfigInfo removeAllObjects];
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToTag)TongClearAllConfig_Tag{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag){
        
        [weakSelf.modelThemeBlockConfigInfo removeObjectForKey:tag];
        
        for (id keyPath in [weakSelf.modelThemeKeyPathConfigInfo copy]) {
            
            weakSelf.TongRemoveKeyPath(tag, keyPath);
        }
        
        for (id selector in [weakSelf.modelThemeSelectorConfigInfo copy]) {
            
            weakSelf.TongRemoveSelector(tag, NSSelectorFromString(selector));
        }
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToKeyPath)TongClearAllConfig_KeyPath{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *keyPath){
        
        [weakSelf.modelThemeKeyPathConfigInfo removeObjectForKey:keyPath];
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToSelector)TongClearAllConfig_Selector{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(SEL selector){
        
        [weakSelf.modelThemeSelectorConfigInfo removeObjectForKey:NSStringFromSelector(selector)];
        
        return weakSelf;
    };
    
}

#pragma mark - LazyLoading

- (NSMutableDictionary *)modelThemeBlockConfigInfo{
    
    if (!_modelThemeBlockConfigInfo) _modelThemeBlockConfigInfo = [NSMutableDictionary dictionary];
    
    return _modelThemeBlockConfigInfo;
}

- (NSMutableDictionary *)modelThemeKeyPathConfigInfo{
    
    if (!_modelThemeKeyPathConfigInfo) _modelThemeKeyPathConfigInfo = [NSMutableDictionary dictionary];

    return _modelThemeKeyPathConfigInfo;
}

- (NSMutableDictionary *)modelThemeSelectorConfigInfo{
    
    if (!_modelThemeSelectorConfigInfo) _modelThemeSelectorConfigInfo = [NSMutableDictionary dictionary];
    
    return _modelThemeSelectorConfigInfo;
}

@end

typedef NS_ENUM(NSInteger, TongThemeIdentifierConfigType) {
    
    /** 标识符设置类型 - Block */
    
    TongThemeIdentifierConfigTypeBlock,
    
    /** 标识符设置类型 - 路径,方法 */
    
    TongThemeIdentifierConfigTypeKeyPath,
    TongThemeIdentifierConfigTypeSelector
};

@implementation TongThemeConfigModel (IdentifierModeExtend)

- (TongConfigThemeToIdentifierAndBlock)TongCustomConfig{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier , TongThemeConfigBlockToValue configBlock){
        
        if (configBlock) {
            
            for (NSString *tag in [TongTheme shareTheme].allTags) {
                
                id value = [TongTheme getValueWithTag:tag Identifier:identifier];
                
                if (value) {
                    
                    NSMutableDictionary *info = weakSelf.modelThemeBlockConfigInfo[tag];
                    
                    if (!info) info = [NSMutableDictionary dictionary];
                    
                    [info setObject:value forKey:configBlock];
                    
                    [weakSelf.modelThemeBlockConfigInfo setObject:info forKey:tag];
                    
                    [weakSelf updateCurrentThemeConfigHandleWithTag:tag];
                }
                
            }
            
            NSMutableDictionary *info = weakSelf.modelThemeIdentifierConfigInfo[@(TongThemeIdentifierConfigTypeBlock)];
            
            if (!info) info = [NSMutableDictionary dictionary];
            
            [info setObject:identifier forKey:configBlock];
            
            [weakSelf.modelThemeIdentifierConfigInfo setObject:info forKey:@(TongThemeIdentifierConfigTypeBlock)];
        }
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setTintColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigTextColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setTextColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigFillColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setFillColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigStrokeColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setStrokeColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigBorderColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setBorderColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigShadowColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setShadowColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigOnTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setOnTintColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigThumbTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setThumbTintColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigSeparatorColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setSeparatorColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigBarTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setBarTintColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigBackgroundColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setBackgroundColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigPlaceholderColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigKeyPathAndIdentifier(@"_placeholderLabel.textColor" , identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigTrackTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setTrackTintColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigProgressTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setProgressTintColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigHighlightedTextColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setHighlightedTextColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigPageIndicatorTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setPageIndicatorTintColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigCurrentPageIndicatorTintColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setCurrentPageIndicatorTintColor:), identifier);
    };
    
}

- (TongConfigThemeToIdentifierAndState)TongConfigButtonTitleColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier , UIControlState state){
        
        return weakSelf.TongConfigSelectorAndValueArray(@selector(setTitleColor:forState:), @[[TongThemeIdentifier ident:identifier], @(state)]);
    };
    
}

- (TongConfigThemeToIdentifierAndState)TongConfigButtonTitleShadowColor{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier , UIControlState state){
        
        return weakSelf.TongConfigSelectorAndValueArray(@selector(setTitleShadowColor:forState:), @[[TongThemeIdentifier ident:identifier], @(state)]);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setImage:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigTrackImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setTrackImage:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigProgressImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setProgressImage:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigShadowImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setShadowImage:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigSelectedImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setSelectedImage:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigBackgroundImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setBackgroundImage:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigBackIndicatorImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setBackIndicatorImage:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigBackIndicatorTransitionMaskImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setBackIndicatorTransitionMaskImage:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigSelectionIndicatorImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setSelectionIndicatorImage:), identifier);
    };
    
}

- (TongConfigThemeToIdentifier)TongConfigScopeBarBackgroundImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndIdentifier(@selector(setScopeBarBackgroundImage:), identifier);
    };
    
}

- (TongConfigThemeToIdentifierAndState)TongConfigButtonImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier , UIControlState state){
        
        return weakSelf.TongConfigSelectorAndValueArray(@selector(setImage:forState:), @[[TongThemeIdentifier ident:identifier], @(state)]);
    };
    
}

- (TongConfigThemeToIdentifierAndState)TongConfigButtonBackgroundImage{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier , UIControlState state){
        
        weakSelf.TongConfigSelectorAndValueArray(@selector(setBackgroundImage:forState:), @[[TongThemeIdentifier ident:identifier], @(state)]);
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToKeyPathAndIdentifier)TongConfigKeyPathAndIdentifier{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *keyPath , NSString *identifier){
        
        for (NSString *tag in [TongTheme shareTheme].allTags) {
            
            id value = [TongTheme getValueWithTag:tag Identifier:identifier];
            
            if (value) weakSelf.TongAddKeyPathAndValue(tag, keyPath, value);
        }
        
        NSMutableDictionary *info = weakSelf.modelThemeIdentifierConfigInfo[@(TongThemeIdentifierConfigTypeKeyPath)];
        
        if (!info) info = [NSMutableDictionary dictionary];
        
        [info setObject:identifier forKey:keyPath];
        
        [weakSelf.modelThemeIdentifierConfigInfo setObject:info forKey:@(TongThemeIdentifierConfigTypeKeyPath)];
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToSelectorAndIdentifier)TongConfigSelectorAndIdentifier{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(SEL sel , NSString *identifier){
        
        return weakSelf.TongConfigSelectorAndValueArray(sel , @[[TongThemeIdentifier ident:identifier]]);
    };
    
}

- (TongConfigThemeToSelectorAndValues)TongConfigSelectorAndValueArray{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(SEL sel , NSArray *values){
        
        for (NSString *tag in [TongTheme shareTheme].allTags) {
            
            NSMutableArray *valueArray = [NSMutableArray array];
            
            for (id value in values) {

                id v = value;
                
                if ([value isKindOfClass:TongThemeIdentifier.class]) {
                    
                    v = [TongTheme getValueWithTag:tag Identifier:value];
                }
                
                if (v) [valueArray addObject:v];
            }
            
            if (valueArray.count == values.count && valueArray.count) weakSelf.TongAddSelectorAndValueArray(tag, sel, valueArray);
        }
        
        NSMutableDictionary *info = weakSelf.modelThemeIdentifierConfigInfo[@(TongThemeIdentifierConfigTypeSelector)];
        
        if (!info) info = [NSMutableDictionary dictionary];
        
        if (values) [info setObject:NSStringFromSelector(sel) forKey:values];
        
        [weakSelf.modelThemeIdentifierConfigInfo setObject:info forKey:@(TongThemeIdentifierConfigTypeSelector)];
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToKeyPath)TongRemoveKeyPathIdentifier{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *keyPath){
        
        id type = @(TongThemeIdentifierConfigTypeKeyPath);
        
        NSMutableDictionary *info = weakSelf.modelThemeIdentifierConfigInfo[type];
        
        for (id key in [info copy]) {
            
            if ([key isEqualToString:keyPath]) {
                
                for (NSString *tag in [TongTheme shareTheme].allTags) {
                    
                    if ([TongTheme getValueWithTag:tag Identifier:info[key]]) weakSelf.TongRemoveKeyPath(tag, keyPath);
                }
                
                [info removeObjectForKey:key];
            }
            
        }
        
        if (info) [weakSelf.modelThemeIdentifierConfigInfo setObject:info forKey:type];
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToSelector)TongRemoveSelectorIdentifier{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(SEL sel){
        
        id type = @(TongThemeIdentifierConfigTypeSelector);
        
        NSMutableDictionary *info = weakSelf.modelThemeIdentifierConfigInfo[type];
        
        for (id key in [info copy]) {
            
            if ([info[key] isEqualToString:NSStringFromSelector(sel)]) {
                
                NSArray *values = key;
                
                for (id value in values) {
                    
                    if ([value isKindOfClass:TongThemeIdentifier.class]) {
                        
                        for (NSString *tag in [TongTheme shareTheme].allTags) {
                            
                            if ([TongTheme getValueWithTag:tag Identifier:value]) weakSelf.TongRemoveSelector(tag, NSSelectorFromString(info[key]));
                        }

                    }
                    
                }
                
                [info removeObjectForKey:key];
            }
            
        }
        
        if (info) [weakSelf.modelThemeIdentifierConfigInfo setObject:info forKey:type];
        
        return weakSelf;
    };
    
}

- (TongConfigThemeToIdentifier)TongRemoveIdentifier{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *identifier){
      
        for (id type in [weakSelf.modelThemeIdentifierConfigInfo copy]) {
         
            NSMutableDictionary *info = weakSelf.modelThemeIdentifierConfigInfo[type];
            
            for (id key in [info copy]) {
                
                switch ([type integerValue]) {
                        
                    case TongThemeIdentifierConfigTypeBlock:
                    {
                        if ([info[key] isEqualToString:identifier]) {
                        
                            for (NSString *tag in [TongTheme shareTheme].allTags) {
                                
                                id value = [TongTheme getValueWithTag:tag Identifier:identifier];
                                
                                if (!value) continue;
                                
                                NSMutableDictionary *info = weakSelf.modelThemeBlockConfigInfo[tag];
                                
                                if (info) {
                                    
                                    [info removeObjectForKey:key];
                                    
                                    [weakSelf.modelThemeBlockConfigInfo setObject:info forKey:tag];
                                }
                                
                            }
                        
                            [info removeObjectForKey:key];
                        }
                        
                    }
                        break;
                        
                    case TongThemeIdentifierConfigTypeKeyPath:
                    {
                        if ([info[key] isEqualToString:identifier]) {
                            
                            for (NSString *tag in [TongTheme shareTheme].allTags) {
                                
                                id value = [TongTheme getValueWithTag:tag Identifier:identifier];
                                
                                if (!value) continue;
                                
                                weakSelf.TongRemoveKeyPath(tag, key);
                            }
                            
                            [info removeObjectForKey:key];
                        }
                        
                    }
                        break;
                        
                    case TongThemeIdentifierConfigTypeSelector:
                    {
                        BOOL remove = NO;
                        
                        NSArray *values = key;
                        
                        for (id value in values) {
                            
                            if ([value isKindOfClass:TongThemeIdentifier.class]) {
                                
                                if ([value isEqualToString:identifier]) {
                                    
                                    for (NSString *tag in [TongTheme shareTheme].allTags) {
                                        
                                        if ([TongTheme getValueWithTag:tag Identifier:value]) weakSelf.TongRemoveSelector(tag, NSSelectorFromString(info[key]));
                                    }
                                    
                                    remove = YES;
                                }
                                
                            }
                            
                        }
                        
                        if (remove) [info removeObjectForKey:key];
                    }
                        break;
                        
                    default:
                        break;
                }
                
            }
            
            if (info) [weakSelf.modelThemeIdentifierConfigInfo setObject:info forKey:type];
        }
        
        return weakSelf;
    };
    
}

- (TongConfigTheme)TongClearAllConfigOnIdentifierMode{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(){
        
        for (NSNumber *type in weakSelf.modelThemeIdentifierConfigInfo) {
            
            NSDictionary *info = weakSelf.modelThemeIdentifierConfigInfo[type];
            
            for (id key in info) {
                
                switch ([type integerValue]) {
                        
                    case TongThemeIdentifierConfigTypeBlock:
                    {   
                        for (NSString *tag in [TongTheme allThemeTag]) {
                            
                            NSMutableDictionary *blockInfo = weakSelf.modelThemeBlockConfigInfo[tag];
                            
                            if (!blockInfo) blockInfo = [NSMutableDictionary dictionary];
                            
                            for (id key in [blockInfo copy]) {
                                
                                if (![blockInfo[key] isKindOfClass:NSNull.class]) [blockInfo removeObjectForKey:key];
                            }
                            
                            [weakSelf.modelThemeBlockConfigInfo setObject:blockInfo forKey:tag];
                        }
                        
                    }
                        break;
                        
                    case TongThemeIdentifierConfigTypeKeyPath:
                    {
                        NSString *identifier = info[key];
                        
                        for (NSString *tag in [TongTheme allThemeTag]) {
                            
                            id value = [TongTheme getValueWithTag:tag Identifier:identifier];
                            
                            if (!value) continue;
                            
                            weakSelf.TongRemoveKeyPath(tag, key);
                        }
                        
                    }
                        break;
                        
                    case TongThemeIdentifierConfigTypeSelector:
                    {
                        NSArray *values = key;
                        
                        for (NSString *tag in [TongTheme shareTheme].allTags) {
                            
                            BOOL remove = NO;
                            
                            for (id value in values) {
                                
                                if ([value isKindOfClass:TongThemeIdentifier.class]) {
                                    
                                    if ([TongTheme getValueWithTag:tag Identifier:value]) remove = YES;
                                }
                                
                            }
                            
                            if (remove) weakSelf.TongRemoveSelector(tag, NSSelectorFromString(info[key]));
                        }
                        
                    }
                        break;
                        
                    default:
                        break;
                }
                
            }
            
        }
        
        [weakSelf.modelThemeIdentifierConfigInfo removeAllObjects];
        
        return weakSelf;
    };
    
}

- (void)TongTheme_AddThemeTagNotify:(NSNotification *)notify{
    
    NSString *tag = notify.userInfo[@"tag"];
    
    NSDictionary *configInfo = self.modelThemeIdentifierConfigInfo;
    
    for (NSNumber *type in configInfo) {
        
        NSDictionary *info = configInfo[type];
        
        for (id key in info) {
            
            switch ([type integerValue]) {
                    
                case TongThemeIdentifierConfigTypeBlock:
                {
                    NSString *identifier = info[key];
                    
                    id value = [TongTheme getValueWithTag:tag Identifier:identifier];
                    
                    if (value) {
                        
                        NSMutableDictionary *blockInfo = self.modelThemeBlockConfigInfo[tag];
                        
                        if (!blockInfo) blockInfo = [NSMutableDictionary dictionary];
                        
                        [blockInfo setObject:value forKey:key];
                        
                        [self.modelThemeBlockConfigInfo setObject:blockInfo forKey:tag];
                    }
                }
                    break;
                    
                case TongThemeIdentifierConfigTypeKeyPath:
                {
                    NSString *identifier = info[key];
                    
                    id value = [TongTheme getValueWithTag:tag Identifier:identifier];
                    
                    if (value) self.TongAddKeyPathAndValue(tag, key, value);
                }
                    break;
                    
                case TongThemeIdentifierConfigTypeSelector:
                {
                    NSArray *values = key;
                    
                    NSMutableArray *valueArray = [NSMutableArray array];
                    
                    for (id value in values) {
                        
                        id v = value;
                        
                        if ([value isKindOfClass:TongThemeIdentifier.class]) {
                            
                            v = [TongTheme getValueWithTag:tag Identifier:value];
                        }
                        
                        if (v) [valueArray addObject:v];
                    }
                    
                    if (valueArray.count == values.count && valueArray.count) self.TongAddSelectorAndValueArray(tag, NSSelectorFromString(info[key]), valueArray);
                }
                    break;
                    
                default:
                    break;
            }

        }
        
    }
    
}

- (NSMutableDictionary *)modelThemeIdentifierConfigInfo{
    
    /**
     *  @{type : @{(keypath or block) : identifier}}
     *  
     *  @{type : @{values : selector}}
     */
    NSMutableDictionary *dic = objc_getAssociatedObject(self, _cmd);
    
    if (!dic) {
        
        dic = [NSMutableDictionary dictionary];
        
        objc_setAssociatedObject(self, _cmd, dic , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TongTheme_AddThemeTagNotify:) name:TongThemeAddTagNotificaiton object:nil];
    }
    
    return dic;
}

- (void)setModelThemeIdentifierConfigInfo:(NSMutableDictionary *)modelThemeIdentifierConfigInfo{
    
    objc_setAssociatedObject(self, @selector(modelThemeIdentifierConfigInfo), modelThemeIdentifierConfigInfo , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation TongThemeIdentifier
{
    NSString *_backingStore;
}

+ (TongThemeIdentifier *)ident:(NSString *)ident{
    
    return [[TongThemeIdentifier alloc] initWithString:ident];
}

- (id)initWithString:(NSString *)aString
{
    if (self = [self init]) {
        
        _backingStore = [[NSString stringWithString:aString] copy];
    }
    return self;
}

- (NSUInteger)length{
    
    return [_backingStore length];
}

- (unichar)characterAtIndex:(NSUInteger)index{
    
    return [_backingStore characterAtIndex:index];
}

@end

#pragma mark - ----------------主题设置----------------

@implementation NSObject (TongThemeConfigObject)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *selStringsArray = @[@"dealloc"];
        
        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
            
            NSString *TongSelString = [@"Tong_theme_" stringByAppendingString:selString];
            
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
            
            Method TongMethod = class_getInstanceMethod(self, NSSelectorFromString(TongSelString));
            
            BOOL isAddedMethod = class_addMethod(self, NSSelectorFromString(selString), method_getImplementation(TongMethod), method_getTypeEncoding(TongMethod));
            
            if (isAddedMethod) {
                
                class_replaceMethod(self, NSSelectorFromString(TongSelString), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
                
            } else {
                
                method_exchangeImplementations(originalMethod, TongMethod);
            }
            
        }];
        
    });
    
}

- (void)Tong_theme_dealloc{
    
    if ([self isTongTheme]) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:TongThemeChangingNotificaiton object:nil];
        
        objc_removeAssociatedObjects(self);
    }

    [self Tong_theme_dealloc];
}

- (BOOL)isChangeTheme{
    
    return (!self.Tong_theme.modelCurrentThemeTag || ![self.Tong_theme.modelCurrentThemeTag isEqualToString:[TongTheme currentThemeTag]]) ? YES : NO;
}

- (void)TongTheme_ChangeThemeConfigNotify:(NSNotification *)notify{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([self isChangeTheme]) {
            
            if (self.Tong_theme.modelChangingBlock) self.Tong_theme.modelChangingBlock([TongTheme currentThemeTag] , self);
            
            [CATransaction begin];
            
            [CATransaction setDisableActions:YES];
            
            [self changeThemeConfig]; 
            
            [CATransaction commit];
        }
        
    });
    
}

- (void)setInv:(NSInvocation *)inv Sig:(NSMethodSignature *)sig Obj:(id)obj Index:(NSInteger)index{
    
    if (sig.numberOfArguments <= index) return;
    
    char *type = (char *)[sig getArgumentTypeAtIndex:index];
    
    while (*type == 'r' || // const
           *type == 'n' || // in
           *type == 'N' || // inout
           *type == 'o' || // out
           *type == 'O' || // bycopy
           *type == 'R' || // byref
           *type == 'V') { // oneway
        type++; // cutoff useless prefix
    }
    
    BOOL unsupportedType = NO;
    
    switch (*type) {
        case 'v': // 1: void
        case 'B': // 1: bool
        case 'c': // 1: char / BOOL
        case 'C': // 1: unsigned char
        case 's': // 2: short
        case 'S': // 2: unsigned short
        case 'i': // 4: int / NSInteger(32bit)
        case 'I': // 4: unsigned int / NSUInteger(32bit)
        case 'l': // 4: long(32bit)
        case 'L': // 4: unsigned long(32bit)
        { // 'char' and 'short' will be promoted to 'int'.
            int value = [obj intValue];
            [inv setArgument:&value atIndex:index];
        } break;
            
        case 'q': // 8: long long / long(64bit) / NSInteger(64bit)
        case 'Q': // 8: unsigned long long / unsigned long(64bit) / NSUInteger(64bit)
        {
            long long value = [obj longLongValue];
            [inv setArgument:&value atIndex:index];
        } break;
            
        case 'f': // 4: float / CGFloat(32bit)
        { // 'float' will be promoted to 'double'.
            double value = [obj doubleValue];
            float valuef = value;
            [inv setArgument:&valuef atIndex:index];
        } break;
            
        case 'd': // 8: double / CGFloat(64bit)
        {
            double value = [obj doubleValue];
            [inv setArgument:&value atIndex:index];
        } break;
            
        case '*': // char *
        case '^': // pointer
        {
            if ([obj isKindOfClass:UIColor.class]) obj = (id)[obj CGColor]; //CGColor转换
            if ([obj isKindOfClass:UIImage.class]) obj = (id)[obj CGImage]; //CGImage转换
            void *value = (__bridge void *)obj;
            [inv setArgument:&value atIndex:index];
        } break;
            
        case '@': // id
        {
            id value = obj;
            [inv setArgument:&value atIndex:index];
        } break;
            
        case '{': // struct
        {
            if (strcmp(type, @encode(CGPoint)) == 0) {
                CGPoint value = [obj CGPointValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(CGSize)) == 0) {
                CGSize value = [obj CGSizeValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(CGRect)) == 0) {
                CGRect value = [obj CGRectValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(CGVector)) == 0) {
                CGVector value = [obj CGVectorValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(CGAffineTransform)) == 0) {
                CGAffineTransform value = [obj CGAffineTransformValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(CATransform3D)) == 0) {
                CATransform3D value = [obj CATransform3DValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(NSRange)) == 0) {
                NSRange value = [obj rangeValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(UIOffset)) == 0) {
                UIOffset value = [obj UIOffsetValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(UIEdgeInsets)) == 0) {
                UIEdgeInsets value = [obj UIEdgeInsetsValue];
                [inv setArgument:&value atIndex:index];
            } else {
                unsupportedType = YES;
            }
        } break;
            
        case '(': // union
        {
            unsupportedType = YES;
        } break;
            
        case '[': // array
        {
            unsupportedType = YES;
        } break;
            
        default: // what?!
        {
            unsupportedType = YES;
        } break;
    }
    
    NSAssert(unsupportedType == NO, @"方法的参数类型暂不支持");
}

- (void)changeThemeConfig{
    
    self.Tong_theme.modelCurrentThemeTag = [TongTheme currentThemeTag];
    
    NSString *tag = [TongTheme currentThemeTag];
    
    // Block
    
    for (id blockKey in self.Tong_theme.modelThemeBlockConfigInfo[tag]) {
        
        id value = self.Tong_theme.modelThemeBlockConfigInfo[tag][blockKey];
        
        if ([value isKindOfClass:NSNull.class]) {
            
            TongThemeConfigBlock block = (TongThemeConfigBlock)blockKey;
            
            if (block) block(self);
            
        } else {
            
            TongThemeConfigBlockToValue block = (TongThemeConfigBlockToValue)blockKey;
            
            if (block) block(self , value);
        }
        
    }
    
    // KeyPath
    
    for (id keyPath in self.Tong_theme.modelThemeKeyPathConfigInfo) {
        
        NSDictionary *info = self.Tong_theme.modelThemeKeyPathConfigInfo[keyPath];
        
        id value = info[tag];
        
        if ([keyPath isKindOfClass:NSString.class]) {
            
            [self setValue:value forKeyPath:keyPath];
        }
        
    }
    
    // Selector
    
    for (NSString *selector in self.Tong_theme.modelThemeSelectorConfigInfo) {
        
        NSDictionary *info = self.Tong_theme.modelThemeSelectorConfigInfo[selector];
        
        NSArray *valuesArray = info[tag];
        
        for (NSArray *values in valuesArray) {
            
            SEL sel = NSSelectorFromString(selector);
            
            NSMethodSignature * sig = [self methodSignatureForSelector:sel];
            
            if (!sig) [self doesNotRecognizeSelector:sel];
            
            NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
            
            if (!inv) [self doesNotRecognizeSelector:sel];
            
            [inv setTarget:self];
            
            [inv setSelector:sel];
            
            if (sig.numberOfArguments == values.count + 2) {
                
                [values enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    NSInteger index = idx + 2;
                    
                    [self setInv:inv Sig:sig Obj:obj Index:index];
                }];
                
                [inv invoke];
                
            } else {
                
                NSAssert(YES, @"参数个数与方法参数个数不匹配");
            }
            
        }
        
    }
    
}

- (TongThemeConfigModel *)Tong_theme{
    
    TongThemeConfigModel *model = objc_getAssociatedObject(self, _cmd);
    
    if (!model) {
        
        NSAssert(![self isKindOfClass:[TongThemeConfigModel class]], @"是不是点多了? ( *・ω・)✄╰ひ╯ ");
        
        model = [TongThemeConfigModel new];
        
        objc_setAssociatedObject(self, _cmd, model , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TongTheme_ChangeThemeConfigNotify:) name:TongThemeChangingNotificaiton object:nil];
        
        [self setIsTongTheme:YES];
        
        __weak typeof(self) weakSelf = self;
        
        model.modelUpdateCurrentThemeConfig = ^{
            
            if (weakSelf) [weakSelf changeThemeConfig];
        };
        
        model.modelConfigThemeChangingBlock = ^{
            
            if (weakSelf) weakSelf.Tong_theme.modelChangingBlock([TongTheme currentThemeTag], weakSelf);
        };
        
    }
    
    return model;
}

- (void)setTong_theme:(TongThemeConfigModel *)Tong_theme{
    
    if(self) objc_setAssociatedObject(self, @selector(Tong_theme), Tong_theme , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isTongTheme{
    
    return self ? [objc_getAssociatedObject(self, _cmd) boolValue] : NO;
}

- (void)setIsTongTheme:(BOOL)isTongTheme{
    
    if (self) objc_setAssociatedObject(self, @selector(isTongTheme), @(isTongTheme) , OBJC_ASSOCIATION_ASSIGN);
}

@end

#pragma mark - ----------------工具扩展----------------

@implementation UIColor (TongThemeColor)

+ (UIColor *)TongTheme_ColorWithHexString:(NSString *)hexString{
    
    if (!hexString) return nil;
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    
    CGFloat alpha, red, blue, green;
    
    switch ([colorString length]) {
        case 0:
            return nil;
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom:colorString start: 0 length: 1];
            green = [self colorComponentFrom:colorString start: 1 length: 1];
            blue  = [self colorComponentFrom:colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom:colorString start: 0 length: 1];
            red   = [self colorComponentFrom:colorString start: 1 length: 1];
            green = [self colorComponentFrom:colorString start: 2 length: 1];
            blue  = [self colorComponentFrom:colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom:colorString start: 0 length: 2];
            green = [self colorComponentFrom:colorString start: 2 length: 2];
            blue  = [self colorComponentFrom:colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom:colorString start: 0 length: 2];
            red   = [self colorComponentFrom:colorString start: 2 length: 2];
            green = [self colorComponentFrom:colorString start: 4 length: 2];
            blue  = [self colorComponentFrom:colorString start: 6 length: 2];
            break;
        default:
            alpha = 0;
            red = 0;
            blue = 0;
            green = 0;
            break;
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)colorComponentFrom:(NSString *) string start:(NSUInteger)start length:(NSUInteger) length{
    
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0f;
}

@end
