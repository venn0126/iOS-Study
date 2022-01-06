//
//  SNSon.m
//  TestStingNil
//
//  Created by Augus on 2021/11/14.
//

#import "SNSon.h"
#import "SNAppConfig.h"
#import "SNPerson.h"
#import <UIKit/UIKit.h>
#import <pthread.h>


static pthread_mutex_t kSon_mutex_0 = PTHREAD_MUTEX_INITIALIZER;
static pthread_mutex_t kSon_mutex_1 = PTHREAD_MUTEX_INITIALIZER;
static pthread_mutex_t kSon_mutex_2 = PTHREAD_MUTEX_INITIALIZER;



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

+ (NSString *)deviceIDFV {
    
    pthread_mutex_lock(&kSon_mutex_0);
    NSString *IDFV = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    pthread_mutex_unlock(&kSon_mutex_0);
    return IDFV;

}

+ (NSString *)timeString {
    
    pthread_mutex_lock(&kSon_mutex_1);

    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *intervalString = [NSString stringWithFormat:@"%.0f", interval];
    if (!intervalString.length) {
        intervalString = @"";
    }
    
    pthread_mutex_unlock(&kSon_mutex_1);

    return intervalString;
}

@end
