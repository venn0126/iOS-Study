//
//  AppDelegate.m
//  DDDemo
//
//  Created by Augus on 2021/5/14.
//

#import "AppDelegate.h"

/// PLCrashReporter
#import <CrashReporter/CrashReporter.h>


// debugger_should_exit
#import <sys/types.h>
#import <sys/sysctl.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
        
//    [AppDelegate handleCCrashReportWrap];
    
    return YES;
}



#pragma mark - PLCrashReporter
+ (void)handleCCrashReport:(PLCrashReporter *)crashReporter {
    NSData *crashData;
    NSError *error;
    
    // try loading the crash report
    crashData = [crashReporter loadPendingCrashReportDataAndReturnError:&error];
    if (crashData == nil) {
        NSLog(@"could not load crash report: %@",error);
        // 清除待处理的崩溃报告
        [crashReporter purgePendingCrashReport];
        return;
    }
    
    PLCrashReport *report = [[PLCrashReport alloc] initWithData:crashData error:&error];
    if (report == nil) {
        NSLog(@"could not parse crash report");
        [crashReporter purgePendingCrashReport];
        return;
    }
    
    // upload symbol text to server or sandbox
    NSString *humanText = [PLCrashReportTextFormatter stringValueForCrashReport:report withTextFormat:PLCrashReportTextFormatiOS];
    NSString *documentDict = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [documentDict stringByAppendingPathComponent:@"1.crash"];
    [humanText writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"human save sandbox fail: %@",error);
    } else {
        NSLog(@"human save sandbox success");

    }
    
    // purge the report
    [crashReporter purgePendingCrashReport];
    
    
    
}

+ (void)handleCCrashReportWrap {
    
    
    // xcode 单步调试下不能使用，否则xcode断开
    if (debugger_should_exit()) {
        NSLog(@"The demo crash app should be run without a debugger present. Exiting...");
        return;
    }

    PLCrashReporterConfig *config = [[PLCrashReporterConfig alloc] initWithSignalHandlerType:PLCrashReporterSignalHandlerTypeMach symbolicationStrategy:PLCrashReporterSymbolicationStrategyAll];
    PLCrashReporter *reporter = [[PLCrashReporter alloc] initWithConfiguration:config];
    
    NSError *error;
    
    // check if we previously crashed
    if ([reporter hasPendingCrashReport]) {
        [self handleCCrashReport:reporter];
    }
    
    // enable the crash reporter
    if ([reporter enableCrashReporterAndReturnError:&error]) {
        NSLog(@"Warn: Could not enable crash reporter: %@",error);
    }
    
}


/// Make step debug not crash
static bool debugger_should_exit (void) {

    struct kinfo_proc info;
    size_t info_size = sizeof(info);
    int name[4];

    name[0] = CTL_KERN;
    name[1] = KERN_PROC;
    name[2] = KERN_PROC_PID;
    name[3] = getpid();

    if (sysctl(name, 4, &info, &info_size, NULL, 0) == -1) {
        NSLog(@"sysctl() failed: %s", strerror(errno));
        return false;
    }

    if ((info.kp_proc.p_flag & P_TRACED) != 0)
        return true;

    return false;
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
