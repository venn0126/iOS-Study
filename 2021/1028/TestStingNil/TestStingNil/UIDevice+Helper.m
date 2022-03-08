//
//  UIDevice+Helper.m
//  TestStingNil
//
//  Created by Augus on 2022/3/8.
//

#import "UIDevice+Helper.h"
#import <pthread.h>

static pthread_mutex_t kUIDeviceHardware_deviceIDFV_mutex_0 = PTHREAD_MUTEX_INITIALIZER;

@implementation UIDevice (Helper)

+ (NSString *)deviceIDFV {
    pthread_mutex_lock(&kUIDeviceHardware_deviceIDFV_mutex_0);
    NSString *IDFV = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    pthread_mutex_unlock(&kUIDeviceHardware_deviceIDFV_mutex_0);
    return IDFV;
}

@end
