//
//  LYCacheUtils.h
//  jianzhimao_enterprise
//
//  Created by 林liouly on 15/12/23.
//  Copyright © 2015年 joiway. All rights reserved.
//
/**
 *  @author joiway_liouly
 *
 *  @brief  缓存工具类
 */

#import <Foundation/Foundation.h>

@interface LYCacheUtils : NSObject

///打印信息
void LYLog(NSString *format, ...);

///返回当前时间，北京时间
+(NSDate *)ly_currentDateForGMT;

///返回当前时间String
+(NSString *)ly_currentDateStr;

///NSString 转 Date
+(NSDate *)ly_dateFromDateString:(NSString *)dateStr;

///转为北京时间
+ (NSDate *)ly_dateForGMT:(NSDate *)data;

///md5加密
+ (NSString *)ly_md5:(NSString *)str accessory:(NSString *)accessory;

@end
