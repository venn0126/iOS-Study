//
//  SNAugusSiriHandler.m
//  TestSiriDemo
//
//  Created by Augus on 2022/9/5.
//

#import "SNAugusSiriHandler.h"
#import "Intents/Intents.h"

@implementation SNAugusSiriHandler

+ (void)askUserSiriPermissions {
    
    // siri权限要求最低10，目前项目支持
    [INPreferences requestSiriAuthorization:^(INSiriAuthorizationStatus status) {
        switch (status) {
            case INSiriAuthorizationStatusNotDetermined:
                NSLog(@"用户尚未对该应用程序作出选择。");
                break;
            case INSiriAuthorizationStatusRestricted:
                NSLog(@"此应用程序无权使用Siri服务");
                break;
            case INSiriAuthorizationStatusDenied:
                NSLog(@"用户已明确拒绝此应用程序的授权");
                break;
            case INSiriAuthorizationStatusAuthorized:
                NSLog(@"用户可以使用此应用程序的授权");
                break;
            default:
                break;
        }
    }];
}

@end
