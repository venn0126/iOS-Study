//
//  AppDelegate.m
//  Test1103
//
//  Created by Augus on 2020/11/3.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchOnce"]) {
          [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchOnce"];
          NSString *path = @"https://www.baidu.com";
          path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
          NSURL *purl = [NSURL URLWithString:path];
          id result = [NSString stringWithContentsOfURL:purl encoding:NSUTF8StringEncoding error:nil];
          NSLog(@"result---%@",result);
      }
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
