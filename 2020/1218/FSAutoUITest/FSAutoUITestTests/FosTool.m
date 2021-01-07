//
//  FosTool.m
//  fosFloatView
//
//  Created by Augus on 2020/11/10.
//

#import "FosTool.h"

@implementation FosTool

+ (UIViewController *)fs_convertToController:(NSString *)controller {
    
    if (!controller || controller.length <= 0) {
        return  nil;
    }
    Class fsClass = NSClassFromString(controller);
    id fsObj = [[fsClass alloc] init];
    if ([fsObj isKindOfClass:[UIViewController class]]) {
        
        return (UIViewController *)fsObj;
    }
    
    return  nil;
}


+ (UIViewController *)fs_currentViewController {
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController *) vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController *) vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        } else {
            break;
        }
    }
    return vc;
}

+ (UINavigationController *)fs_currentNavigationController {
    return [self fs_currentViewController].navigationController;
}

+ (UITabBarController *)fs_currentTabBarController {
    return [self fs_currentViewController].tabBarController;
}


+ (void)fos_hideKeyboard:(UIView *)view {
    [self _traverseAllSubviewsToResignFirstResponder:view];
}

// 遍历父视图的所有子视图包括嵌套的视图
+ (void)_traverseAllSubviewsToResignFirstResponder:(UIView *)view {
    for (UIView *subview in view.subviews) {
        if (subview.subviews.count != 0) {
            [self _traverseAllSubviewsToResignFirstResponder:subview];
        }
        [subview resignFirstResponder];
    }
}

+ (void)saveModel:(id )model key:(NSString *)key{
 
    if (!model || !key) {
        return;
    }
    
    NSError *error = nil;
    NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:model requiringSecureCoding:YES error:&error];
    if (error) {
        NSLog(@"save mode error--%@",error);
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:modelData forKey:key];
}

+ (id)unArchivedModelObjectOfClass:(Class)cls key:(NSString *)key {
    
    NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (!modelData) {
        return nil;
    }
    NSError *error = nil;
    id model = [NSKeyedUnarchiver unarchivedObjectOfClass:cls fromData:modelData error:&error];
    if (error) {
        NSLog(@"unarchieve error -%@",error);
        return nil;
    }
    return model;
}

+ (NSString *)stringFormatWithDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSDate *)dateFormatWithString:(NSString *)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}

+ (BOOL)isTodayWithDateString:(NSString *)dateString {
    NSDate *todayDate = [NSDate date];
    NSString *todayDateString = [self stringFormatWithDate:todayDate];
    return [dateString isEqualToString:todayDateString];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

// dict to json
+ (NSString *)convertToJsonData:(NSDictionary *)dict{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"dict to data happen error %@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
    
}

@end
