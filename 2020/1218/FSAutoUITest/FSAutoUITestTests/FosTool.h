//
//  FosTool.h
//  fosFloatView
//
//  Created by Augus on 2020/11/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FosTool : NSObject

+ (UIViewController *)fs_convertToController:(NSString *)controller;

+ (UIViewController *)fs_currentViewController;
+ (UITabBarController *)fs_currentTabBarController;
+ (UINavigationController *)fs_currentNavigationController;

+ (void)fos_hideKeyboard:(UIView *)view;

+ (void)saveModel:(id )model key:(NSString *)key;
+ (id)unArchivedModelObjectOfClass:(Class)cls key:(NSString *)key;

/**
 time and string
 */

+ (NSString *)stringFormatWithDate:(NSDate *)date;

+ (NSDate *)dateFormatWithString:(NSString *)dateString;

+ (BOOL)isTodayWithDateString:(NSString *)dateString;

/**
 json and data
 */

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (NSString *)convertToJsonData:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
