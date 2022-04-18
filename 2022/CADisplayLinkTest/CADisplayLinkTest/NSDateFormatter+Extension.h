//
//  NSDateFormatter+Extension.h
//  CADisplayLinkTest
//
//  Created by Augus on 2022/4/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (Extension)


/// NSDate to string by some format,if format is nil or is not kind of NSString,default format is `yyyy-MM-dd`
/// @param date a NSDate instance
/// @param format a date format
+ (nullable NSString *)toStringByDate:(NSDate *)date format:(NSString * _Nullable)format;

@end

NS_ASSUME_NONNULL_END
