//
//  AppDelegate.m
//  NWUITest
//
//  Created by Augus on 2021/4/22.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "QiAudioPlayer.h"

@interface AppDelegate ()

@property (nonatomic, assign)  UIBackgroundTaskIdentifier backGroundTaskIdentifier;

@end

static NSString * const kBGTaskName = @"com.fosafer.task.augus";

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    /*! Use this category when recording and playing back audio. */
    // AVAudioSessionCategoryPlayAndRecord
    // AVAudioSessionCategoryPlayback--play audio
    if(![session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error]) {
        NSLog(@"set cateory error %@",[error localizedDescription]);
    }
    
    if (![session setActive:YES error:&error]) {
        NSLog(@"set active error %@",[error localizedDescription]);
    }
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);

    
    
    return YES;
}

/// OC instance crash report
/// @param exception a oc instance of exception
void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols]; //得到当前调用栈信息
    NSString *reason = [exception reason];       //非常重要，就是崩溃的原因
    NSString *name = [exception name];           //异常类型

    NSString *title = [NSString stringWithFormat:@"%@:%@", reason, name];
    NSString *content = [arr componentsJoinedByString:@";"];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:title forKey:@"CrashTitleIdentifier"];
    [userDefault setObject:content forKey:@"CrashContentIdentifier"];
    [userDefault synchronize];
    NSLog(@"nw0 exception type : %@ \n crash reason : %@ \n call stack info : %@", name, reason, arr);
//    NSLog(@"nw1 exception type : %@ \n crash reason : %@ \n call stack info : %@", name, reason, arr);
}


#pragma mark - MARK: 需要后台下载的情况需要实现如下方法
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {
    
    NSLog(@"%s: 标识符 %@ 后台任务下载完成",__func__,identifier);
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    
    NSLog(@"%s: 创建新的场景会话",__func__);



    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    
    NSLog(@"%s: 已经丢弃一个场景会话",__func__);
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    NSLog(@"%s: <13应用即将进入前台",__func__);
    
//    if ([QiAudioPlayer sharedInstance].needRunBackground) {
//        [[QiAudioPlayer sharedInstance].player pause];
//    }
//
//    [[UIApplication sharedApplication] endBackgroundTask:self.backGroundTaskIdentifier];

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSLog(@"%s <13应用已进入活跃状态",__func__);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSLog(@"%s <13应用将要进入非活跃状态",__func__);

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    NSLog(@"%s <13应用进入后台",__func__);
    
    // < iOS 13版本的处理
    
//    self.backGroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithName:kBGTaskName expirationHandler:^{
//
//
//        if ([QiAudioPlayer sharedInstance].needRunBackground) {
//            [[QiAudioPlayer sharedInstance].player play];
//        }
//
//
//        if (self.backGroundTaskIdentifier != UIBackgroundTaskInvalid) {
//            [[UIApplication sharedApplication] endBackgroundTask:self.backGroundTaskIdentifier];
//            self.backGroundTaskIdentifier = UIBackgroundTaskInvalid;
//        }
//
//    }];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
    NSLog(@"%s <13应用将要终止",__func__);

}
@end
