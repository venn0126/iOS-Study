//
//  NSDateFormatter+Extension.m
//  CADisplayLinkTest
//
//  Created by Augus on 2022/4/18.
//

#import "NSDateFormatter+Extension.h"

@implementation NSDateFormatter (Extension)

+ (NSString *)toStringByDate:(NSDate *)date format:(NSString *)format {

    if (![date isKindOfClass:[NSDate class]] || !date) {
        return nil;
    }
    
    if (![format isKindOfClass:[NSString class]] || format.length == 0) {
        format = @"yyyy-MM-dd";
    }
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.locale = [NSLocale systemLocale];
    [formatter setLocalizedDateFormatFromTemplate:@"jj:mm:ss"];
    formatter.dateFormat = [NSString stringWithFormat:@"%@ %@",format, formatter.dateFormat];
    
    return [formatter stringFromDate:date];
}

@end
