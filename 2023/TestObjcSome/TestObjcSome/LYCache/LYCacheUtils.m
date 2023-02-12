//
//  LYCacheUtils.m
//  jianzhimao_enterprise
//
//  Created by 林liouly on 15/12/23.
//  Copyright © 2015年 joiway. All rights reserved.
//

#import "LYCacheUtils.h"
#import <CommonCrypto/CommonDigest.h>

static NSString* const formatterStr = @"yyyy-MM-dd HH:mm:ss";

@implementation LYCacheUtils

void LYLog(NSString *format, ...)
{
#ifdef DEBUG
    va_list argptr;
    va_start(argptr, format);
    NSLogv(format, argptr);
    va_end(argptr);
#endif
}

///返回当前时间，北京时间
+(NSDate *)ly_currentDateForGMT
{
    NSDate *date = [NSDate date];
    
    return [self ly_dateForGMT:date];
}

///返回当前时间String
+(NSString *)ly_currentDateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    NSString *date = [formatter stringFromDate:[NSDate date]];

    return date;
}

///NSString 转 Date
+(NSDate *)ly_dateFromDateString:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:formatterStr];
    NSDate *date = [formatter dateFromString:dateStr];

    return [self ly_dateForGMT:date];
}

///转为北京时间
+ (NSDate *)ly_dateForGMT:(NSDate *)data
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:data];
    NSDate *localeDate = [data dateByAddingTimeInterval:interval];
    
    return localeDate;
}

///md5加密
+ (NSString *)ly_md5:(NSString *)str accessory:(NSString *)accessory
{
    NSString *oriStr = [str stringByAppendingString:accessory];
    const char *cStr = [oriStr UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    NSString *md5Str = [NSString stringWithFormat:
                        @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                        result[0], result[1], result[2], result[3],
                        result[4], result[5], result[6], result[7],
                        result[8], result[9], result[10], result[11],
                        result[12], result[13], result[14], result[15]
                        ];
    
    return md5Str;
    
}



@end
