//
//  main.m
//  GTiTools
//
//  Created by Augus on 2022/12/1.
//

#import <UIKit/UIKit.h>
//#import "AppDelegate.h"


/// 导入自定义工具类
#import "GTAppTool.h"
#import "GTMachO.h"
#import <UIKit/UIKit.h>
#import "GTPrintTool.h"

#define GTEncryptedString @"加壳"
#define GTDecryptedString @"未加壳"


#define GTPrintNewLine printf("\n")
#define GTPrintDivider(n) \
NSMutableString *dividerString = [NSMutableString string]; \
for (int i = 0; i<(n); i++) { \
[dividerString appendString:@"-"]; \
} \
[GTPrintTool print:dividerString];


static NSString *GTPrintColorCount;
static NSString *GTPrintColorNo;
static NSString *GTPrintColorCrypt;
static NSString *GTPrintColorName;
static NSString *GTPrintColorPath;
static NSString *GTPrintColorId;
static NSString *GTPrintColorArch;
static NSString *GTPrintColorTip;


void print_usage(void);
void list_machO(GTMachO *machO);
void list_app(GTApp *app, int index);
void list_apps(GTListAppsType type, NSString *regex);
void init_colors(void);

/// arg[0]:是当前可执行文件的路径
/// argc：argcount参数个数
/// argv[]：存放参数的数组

int main(int argc, char * argv[]) {
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        init_colors();
        
        BOOL gt_ios8 = ([[[UIDevice currentDevice] systemVersion] compare:@"8" options:NSNumericSearch] != NSOrderedAscending);
        if (!gt_ios8) {
            [GTPrintTool printError:@"MJAppTools目前不支持iOS8以下系统\n"];
            return 0;
        }
    
        if (argc == 1) { // 参数不够
            print_usage();
            return 0;
        }
        
        const char *firstArg = argv[1];
        if (firstArg[0] == '-' && firstArg[1] == 'l') {
            NSString *regex = nil;
            if (argc > 2) {
                regex = [NSString stringWithUTF8String:argv[2]];
            }
            
            if (strcmp(firstArg, "-le") == 0) {
                list_apps(GTListAppsTypeUserEncrypted, regex);
            } else if (strcmp(firstArg, "-ld") == 0) {
                list_apps(GTListAppsTypeUserDecrypted, regex);
            } else if (strcmp(firstArg, "-ls") == 0) {
                list_apps(GTListAppsTypeSystem, regex);
            } else {
                list_apps(GTListAppsTypeUser, regex);
            }
        } else {
            print_usage();
        }
    
    }
//    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
    
    return 0;
}


/// 初始化颜色色值
void init_colors()
{
    GTPrintColorCount = GTPrintColorMagenta;
    GTPrintColorNo = GTPrintColorDefault;
    GTPrintColorName = GTPrintColorRed;
    GTPrintColorPath = GTPrintColorBlue;
    GTPrintColorCrypt = GTPrintColorMagenta;
    GTPrintColorId = GTPrintColorCyan;
    GTPrintColorArch = GTPrintColorGreen;
    GTPrintColorTip = GTPrintColorCyan;
}


/// 格式化打印文本
void print_usage()
{
    [GTPrintTool printColor:GTPrintColorTip format:@"  -l  <regex>"];
    [GTPrintTool print:@"\t列出用户安装的应用\n"];
    
    [GTPrintTool printColor:GTPrintColorTip format:@"  -le <regex>"];
    [GTPrintTool print:@"\t列出用户安装的"];
    [GTPrintTool printColor:GTPrintColorCrypt format:GTEncryptedString];
    [GTPrintTool print:@"应用\n"];
    
    [GTPrintTool printColor:GTPrintColorTip format:@"  -ld <regex>"];
    [GTPrintTool print:@"\t列出用户安装的"];
    [GTPrintTool printColor:GTPrintColorCrypt format:GTDecryptedString];
    [GTPrintTool print:@"应用\n"];
    
    [GTPrintTool printColor:GTPrintColorTip format:@"  -ls <regex>"];
    [GTPrintTool print:@"\t列出"];
    [GTPrintTool printColor:GTPrintColorCrypt format:@"系统"];
    [GTPrintTool print:@"的应用\n"];
}


/// 打印输出
void list_app(GTApp *app, int index)
{
    [GTPrintTool print:@"# "];
    [GTPrintTool printColor:GTPrintColorNo format:@"%02d ", index +1];
    [GTPrintTool print:@"【"];
    [GTPrintTool printColor:GTPrintColorName format:@"%@", app.displayName];
    [GTPrintTool print:@"】 "];
    [GTPrintTool print:@"<"];
    [GTPrintTool printColor:GTPrintColorId format:@"%@", app.bundleIdentifier];
    [GTPrintTool print:@">"];
    
    GTPrintNewLine;
    [GTPrintTool print:@"  "];
    [GTPrintTool printColor:GTPrintColorPath format:app.bundlePath];
    
    if (app.dataPath.length) {
        GTPrintNewLine;
        [GTPrintTool print:@"  "];
        [GTPrintTool printColor:GTPrintColorPath format:app.dataPath];
    }
    
    if (app.executable.isFat) {
        GTPrintNewLine;
        [GTPrintTool print:@"  "];
        [GTPrintTool printColor:GTPrintColorArch format:@"Universal binary"];
        for (GTMachO *machO in app.executable.machOs) {
            GTPrintNewLine;
            printf("      ");
            list_machO(machO);
        }
    } else {
        GTPrintNewLine;
        [GTPrintTool print:@"  "];
        list_machO(app.executable);
    }
}


/// 通过正则匹配app
void list_apps(GTListAppsType type, NSString *regex)
{
    [GTAppTool listUserAppsWithType:type regex:regex operation:^(NSArray *apps) {
        [GTPrintTool print:@"# 一共"];
        [GTPrintTool printColor:GTPrintColorCount format:@"%zd", apps.count];
        [GTPrintTool print:@"个"];
        if (type == GTListAppsTypeUserDecrypted) {
            [GTPrintTool printColor:GTPrintColorCrypt format:GTDecryptedString];
        } else if (type == GTListAppsTypeUserEncrypted) {
            [GTPrintTool printColor:GTPrintColorCrypt format:GTEncryptedString];
        } else if (type == GTListAppsTypeSystem) {
            [GTPrintTool printColor:GTPrintColorCrypt format:@"系统"];
        }
        [GTPrintTool print:@"应用"];
        
        for (int i = 0; i < apps.count; i++) {
            GTPrintNewLine;
            GTPrintDivider(5);
            GTPrintNewLine;
            list_app(apps[i], i);
        }
        GTPrintNewLine;
    }];
}


/// 打印MachO文件
void list_machO(GTMachO *machO)
{
    [GTPrintTool printColor:GTPrintColorArch format:machO.architecture];
    if (machO.isEncrypted) {
        [GTPrintTool print:@" "];
        [GTPrintTool printColor:GTPrintColorCrypt format:GTEncryptedString];
    }
}
