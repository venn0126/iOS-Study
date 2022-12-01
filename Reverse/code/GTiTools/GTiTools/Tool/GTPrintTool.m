//
//  GTPrintTool.m
//  GTiTools
//
//  Created by Augus on 2022/12/1.
//

#import "GTPrintTool.h"


const NSString *GTPrintColorDefault = @"\033[0m";

const NSString *GTPrintColorRed = @"\033[1;31m";
const NSString *GTPrintColorGreen = @"\033[1;32m";
const NSString *GTPrintColorBlue = @"\033[1;34m";
const NSString *GTPrintColorWhite = @"\033[1;37m";
const NSString *GTPrintColorBlack = @"\033[1;30m";
const NSString *GTPrintColorYellow = @"\033[1;33m";
const NSString *GTPrintColorCyan = @"\033[1;36m";
const NSString *GTPrintColorMagenta = @"\033[1;35m";

const NSString *GTPrintColorWarning = @"\033[1;33m";
const NSString *GTPrintColorError = @"\033[1;31m";
const NSString *GTPrintColorStrong = @"\033[1;32m";


#define GTBeginFormat \
if (!format) return; \
va_list args; \
va_start(args, format); \
format = [[NSString alloc] initWithFormat:format arguments:args];

#define GTEndFormat va_end(args);

@implementation GTPrintTool

+ (void)printError:(NSString *)format, ...
{
    GTBeginFormat;
    format = [@"Error: " stringByAppendingString:format];
    [self printColor:(NSString *)GTPrintColorError format:format];
}

+ (void)printWarning:(NSString *)format, ...
{
    GTBeginFormat;
    format = [@"Warning: " stringByAppendingString:format];
    [self printColor:(NSString *)GTPrintColorWarning format:format];
    GTEndFormat;
}

+ (void)printStrong:(NSString *)format, ...
{
    GTBeginFormat;
    [self printColor:(NSString *)GTPrintColorStrong format:format];
    GTEndFormat;
}

+ (void)print:(NSString *)format, ...
{
    GTBeginFormat;
    [self printColor:nil format:format];
    GTEndFormat;
}

+ (void)printColor:(NSString *)color format:(NSString *)format, ...
{
    GTBeginFormat;
    
    NSMutableString *printStr = [NSMutableString string];
    if (color && ![color isEqual:GTPrintColorDefault]) {
        [printStr appendString:color];
        [printStr appendString:format];
        [printStr appendString:(NSString *)GTPrintColorDefault];
    } else {
        [printStr appendString:(NSString *)GTPrintColorDefault];
        [printStr appendString:format];
    }
    printf("%s", printStr.UTF8String);
    
    GTEndFormat;
}

@end
