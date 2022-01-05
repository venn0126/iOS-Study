//
//  SNSon.m
//  TestStingNil
//
//  Created by Augus on 2021/11/14.
//

#import "SNSon.h"
#import "SNAppConfig.h"
#import "SNPerson.h"


@interface SNSon ()


@end

@implementation SNSon


- (void)requestConfigAsync {
    
    SNAppConfig *config = [[SNPerson shared] config];
//    NSString *dateString =
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];

    NSDate *currentDate = [NSDate date];
    NSString *dateString = [formatter stringFromDate:currentDate];
    NSDictionary *dict = @{@"_abTestExpose":dateString};
    [config.appConfigABTest updateWithDic:dict];
    
}

+ (NSString *)getCid {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"clientId"];
}


+ (NSString *)appVersion {
    static dispatch_once_t onceToken;
    static NSString *appVersion;
    dispatch_once(&onceToken, ^{
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        //6.2.3.1 -> 6.2.3
        if (version.length > 5) {
            appVersion = [version substringToIndex:5];
        } else {
            appVersion = version;
        }
    });
    return appVersion;
}

@end
