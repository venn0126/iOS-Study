//
//  NSDate+Extension.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/7.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSString *)currentDate{
    
    //获取系统时间戳
    NSDate* date1 = [NSDate date];
    NSTimeInterval time1 =[date1 timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",time1];
    
    //时间戳转换成时间
    NSTimeInterval time2 =[timeString doubleValue];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:time2];

    //显示的时间格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *currentTime = [formatter stringFromDate:date2];
    
    //
    
    //NSLog(@"当前时间:%@",currentTime);
    
    return currentTime;
}

@end
