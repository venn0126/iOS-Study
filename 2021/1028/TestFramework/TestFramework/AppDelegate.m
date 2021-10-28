//
//  AppDelegate.m
//  TestFramework
//
//  Created by Augus on 2021/10/28.
//

#import "AppDelegate.h"
#import <DMSTAIDSDK/DMS_MKAIDBusinessSDK.h>
#import <FosaferAuth/FosaferAuth.h>


#define Xorganizeld @"00001062"
#define XappId   @"0007"
#define App_ID @"69b85ab111ff448498d9791090786a33"
#define AppPrpperty @"111111111"
#define UserId @""
#define CTIDUrl @"https://api.ikiaid.net:9096"
#define RA_AID_HTTP @"https://ra.ikiaid.net:8089"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    NSString *version = [FOSFosafer version];
    NSLog(@"fosafer version is %@",version);
    
    [[DMS_MKAIDBusinessSDK DMS_AID_BUSS_sharedManager] sdkInit:Xorganizeld withAId:XappId withAppID:App_ID withAppProperty:AppPrpperty withUserID:UserId withCTIDUrl:CTIDUrl withAIDHttp:RA_AID_HTTP];
    
    
    NSString *mkaVersion = [[DMS_MKAIDBusinessSDK DMS_AID_BUSS_sharedManager] getSdkVersion];
    NSLog(@"mka version is %@",mkaVersion);
    

    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
