//
//  AppDelegate.m
//  TestSiriDemo
//
//  Created by Augus on 2022/8/11.
//

#import "AppDelegate.h"
#import "SNAugusSiriHandler.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    [SNAugusSiriHandler askUserSiriPermissions];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    
    if ([userActivity.activityType isEqualToString:@"INPlayMediaIntent"]) {
        NSLog(@"0开始处理播放音频");
        return YES;
    }
    
    
    return NO;
}

- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error {
    
    NSLog(@"%@---%@",@(__func__),error);
}


//- (id)application:(UIApplication *)application handlerForIntent:(INIntent *)intent {
//    INPlayMediaIntent *playIntent = [[INPlayMediaIntent alloc] init];
//    playIntent.suggestedInvocationPhrase = @"测试捷径搜索三十而已";
//
//    return playIntent;
//}


- (void)application:(UIApplication *)application handleIntent:(INIntent *)intent completionHandler:(void (^)(INIntentResponse * _Nonnull))completionHandler {
    
    NSLog(@"2开始处理播放音频");

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
