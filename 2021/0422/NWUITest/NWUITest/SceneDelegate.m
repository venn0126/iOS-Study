//
//  SceneDelegate.m
//  NWUITest
//
//  Created by Augus on 2021/4/22.
//

#import "SceneDelegate.h"
#import "ViewController.h"
#import "QiAudioPlayer.h"
#import <BackgroundTasks/BackgroundTasks.h>

@interface SceneDelegate ()

@property (nonatomic, assign)  UIBackgroundTaskIdentifier bgIdentifier;

@end


static NSString * const kSBGTaskName = @"com.fosafer.task1.augus";
static NSString * const kSBGTaskRefresh = @"com.fosafer.background.refresh";
static NSString * const kSBGTaskClean = @"com.fosafer.background.clean";


@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    UIWindow *window;
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    NSLog(@"nav init");

    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        window = [[UIWindow alloc] initWithWindowScene:windowScene];
        window.rootViewController = nav;
        
    } else {
        // Fallback on earlier versions
        
    }
    
//    [window makeKeyAndVisible];
    [window makeKeyWindow];
    
    // 注册后台任务
    [self registerBGTask];
    
}

- (void)registerBGTask {
    
    BOOL registerRefreshFlag = [[BGTaskScheduler sharedScheduler] registerForTaskWithIdentifier:kSBGTaskRefresh usingQueue:nil launchHandler:^(__kindof BGTask * _Nonnull task) {
       
        [self handleAppRefresh:task];
    }];
    
    if (registerRefreshFlag) {
        NSLog(@"刷新注册成功");
    } else {
        NSLog(@"刷新注册失败");
    }
    
    BOOL registerCleanFlag = [[BGTaskScheduler sharedScheduler] registerForTaskWithIdentifier:kSBGTaskClean usingQueue:nil launchHandler:^(__kindof BGTask * _Nonnull task) {
       
        [self handleAppRefresh:task];
    }];
    
    if (registerCleanFlag) {
        NSLog(@"清除注册成功");
    } else {
        NSLog(@"清除注册失败");
    }
}

- (void)handleAppRefresh:(BGAppRefreshTask *)appRefreshTask  API_AVAILABLE(ios(13.0)){
    
    [self scheduleAppRefresh];
    
    NSLog(@"App刷新====================================================================");
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.maxConcurrentOperationCount = 1;
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:AppViewControllerRefreshNotificationName object:nil];
        
        NSLog(@"操作");
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *timeString = [dateFormatter stringFromDate:date];
        
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"QiLog.txt"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            NSData *data = [timeString dataUsingEncoding:NSUTF8StringEncoding];
            [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
        } else {
            NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
            NSString *originalContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *content = [originalContent stringByAppendingString:[NSString stringWithFormat:@"\n时间：%@\n", timeString]];
            data = [content dataUsingEncoding:NSUTF8StringEncoding];
            [data writeToFile:filePath atomically:YES];
        }
    }];
    
    appRefreshTask.expirationHandler = ^{
        [queue cancelAllOperations];
    };
    [queue addOperation:operation];
    
    __weak NSBlockOperation *weakOperation = operation;
    operation.completionBlock = ^{
        [appRefreshTask setTaskCompletedWithSuccess:!weakOperation.isCancelled];
    };
}

- (void)scheduleAppRefresh {
    
    if (@available(iOS 13.0, *)) {
        BGAppRefreshTaskRequest *request = [[BGAppRefreshTaskRequest alloc] initWithIdentifier:kSBGTaskRefresh];
        // 最早1分钟后启动后台任务请求
        request.earliestBeginDate = [NSDate dateWithTimeIntervalSinceNow:60 * 1];
        NSError *error = nil;
        [[BGTaskScheduler sharedScheduler] submitTaskRequest:request error:&error];
        if (error) {
            NSLog(@"错误信息：%@", error);
        }
        
    } else {
        // Fallback on earlier versions
    }
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    
    NSLog(@"%s 场景已断开",__func__);

}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    
    NSLog(@"%s 场景由不活跃到活跃",__func__);

}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
    
    NSLog(@"%s 场景由活跃到不活跃",__func__);

}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
    NSLog(@"%s 应用即将进入前台",__func__);
    
    
    if ([QiAudioPlayer sharedInstance].needRunBackground) {
        [[QiAudioPlayer sharedInstance].player pause];
    }
    
    [[UIApplication sharedApplication] endBackgroundTask:self.bgIdentifier];

}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    
    NSLog(@"%s 应用已进入后台",__func__);
//    [self scheduleAppRefresh];

    /**
     
     
    
    self.bgIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithName:kSBGTaskName expirationHandler:^{

        if (self.bgIdentifier != UIBackgroundTaskInvalid) {
            
            // >= iOS 13
//            if ([QiAudioPlayer sharedInstance].needRunBackground) {
                NSLog(@"%s 后台音乐持续播放",__func__);
//                [[QiAudioPlayer sharedInstance].player play];
//            }
            
//            NSLog(@"终止后台任务 %s",__func__);
            [[UIApplication sharedApplication] endBackgroundTask:self.bgIdentifier];
            self.bgIdentifier = UIBackgroundTaskInvalid;
            
            // 结论
            // < iOS 13的话 task后台保活 175s
            // >= iOS 13的话 31s
            
            // 12:05:11.973415+0800 0
            // 12:05:37.912017+0800 终止 25s
            // 12:05:42.974094+0800 挂起 30s
        }
        
    }];
    
     */
    
//    self.bgIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//
//        [self overTimeTask];
//
//    }];
    
    
}

- (void)overTimeTask {
    
    for (int i = 0; i < pow(10, 9); i++) {
        NSLog(@"hello %d",i);
    }
}


@end
