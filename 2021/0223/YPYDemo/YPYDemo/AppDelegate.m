//
//  AppDelegate.m
//  YPYDemo
//
//  Created by Augus on 2021/3/5.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


+ (void)load {
    
//    __block id observer =
//    [[NSNotificationCenter defaultCenter]
//     addObserverForName:UIApplicationDidFinishLaunchingNotification
//     object:nil
//     queue:nil
//     usingBlock:^(NSNotification *note) {
//        //             [self setup]; // Do whatever you want
//        NSLog(@"block begin");
//        [self setup];
//        NSLog(@"block end");
//        
//        [[NSNotificationCenter defaultCenter] removeObserver:observer];
//    }];
}

+ (void)setup {
    
    NSLog(@"+ set up");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSLog(@"didFinishLaunchingWithOptions");
    
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

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    NSLog(@"%@---%@",@(__PRETTY_FUNCTION__),@(__LINE__));
}


@end
