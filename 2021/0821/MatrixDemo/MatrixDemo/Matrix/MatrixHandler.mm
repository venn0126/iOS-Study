/*
 * Tencent is pleased to support the open source community by making wechat-matrix available.
 * Copyright (C) 2019 THL A29 Limited, a Tencent company. All rights reserved.
 * Licensed under the BSD 3-Clause License (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "MatrixHandler.h"
//#import <matrix-wechat/WCCrashBlockFileHandler.h>
#import <Matrix/WCCrashBlockFileHandler.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TextViewController.h"
#import "Utility.h"

void kscrash_crashCallback(const KSCrashReportWriter *writer)
{
    writer->beginObject(writer, "WeChat");
    writer->addUIntegerElement(writer, "uin", 21002);
    writer->endContainer(writer);
}

@interface MatrixHandler () <WCCrashBlockMonitorDelegate, MatrixAdapterDelegate, MatrixPluginListenerDelegate,NSURLSessionDelegate>
{
    WCCrashBlockMonitorPlugin *m_cbPlugin;
    WCMemoryStatPlugin *m_msPlugin;
}

@end

@implementation MatrixHandler

+ (MatrixHandler *)sharedInstance
{
    static MatrixHandler *g_handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_handler = [[MatrixHandler alloc] init];
    });
    
    return g_handler;
}

- (void)installMatrix
{
    // Get Matrix's log
    [MatrixAdapter sharedInstance].delegate = self;
     
    Matrix *matrix = [Matrix sharedInstance];

    MatrixBuilder *curBuilder = [[MatrixBuilder alloc] init];
    curBuilder.pluginListener = self;
    
    WCCrashBlockMonitorConfig *crashBlockConfig = [[WCCrashBlockMonitorConfig alloc] init];
    crashBlockConfig.enableCrash = YES;
    crashBlockConfig.enableBlockMonitor = YES;
    crashBlockConfig.blockMonitorDelegate = self;
    crashBlockConfig.onAppendAdditionalInfoCallBack = kscrash_crashCallback;
    crashBlockConfig.reportStrategy = EWCCrashBlockReportStrategy_All;
    
    WCBlockMonitorConfiguration *blockMonitorConfig = [WCBlockMonitorConfiguration defaultConfig];
    blockMonitorConfig.bMainThreadHandle = YES;
    blockMonitorConfig.bFilterSameStack = YES;
    blockMonitorConfig.triggerToBeFilteredCount = 10;
    blockMonitorConfig.bGetCPUHighLog = NO;
    blockMonitorConfig.bGetPowerConsumeStack = YES;
    
    crashBlockConfig.blockMonitorConfiguration = blockMonitorConfig;
    
    WCCrashBlockMonitorPlugin *crashBlockPlugin = [[WCCrashBlockMonitorPlugin alloc] init];
    crashBlockPlugin.pluginConfig = crashBlockConfig;
    [curBuilder addPlugin:crashBlockPlugin];
    
    
    
//    WCMemoryStatConfig *msConfig = [[WCMemoryStatConfig alloc] init];
//    msConfig.dumpCallStacks = 1;
//    msConfig.reportStrategy = EWCMemStatReportStrategy_Manual;
    
    WCMemoryStatPlugin *memoryStatPlugin = [[WCMemoryStatPlugin alloc] init];
    memoryStatPlugin.pluginConfig = [WCMemoryStatConfig defaultConfiguration];
//    memoryStatPlugin.pluginConfig = msConfig;
    [curBuilder addPlugin:memoryStatPlugin];
    
    [matrix addMatrixBuilder:curBuilder];
    
    [crashBlockPlugin start];
    [memoryStatPlugin start];
    
    m_cbPlugin = crashBlockPlugin;
    m_msPlugin = memoryStatPlugin;
}

- (WCCrashBlockMonitorPlugin *)getCrashBlockPlugin;
{
    return m_cbPlugin;
}

- (WCMemoryStatPlugin *)getMemoryStatPlugin
{
    return m_msPlugin;
}

// ============================================================================
#pragma mark - MatrixPluginListenerDelegate
// ============================================================================

- (void)onReportIssue:(MatrixIssue *)issue
{
    NSLog(@"(%@):(%@) > get issue: %@", @(__func__),@(__LINE__),issue);
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    TextViewController *textVC = nil;
    
    NSString *currentTilte = @"unknown";
    
    // crash & lag
    if ([issue.issueTag isEqualToString:[WCCrashBlockMonitorPlugin getTag]]) {
        // lag
        if (issue.reportType == EMCrashBlockReportType_Lag) {
            NSMutableString *lagTitle = [@"Lag" mutableCopy];
            if (issue.customInfo != nil) {
                NSString *dumpTypeDes = @"";
                NSNumber *dumpType = [issue.customInfo objectForKey:@g_crash_block_monitor_custom_dump_type];
                switch (EDumpType(dumpType.integerValue)) {
                    case EDumpType_MainThreadBlock:
                        dumpTypeDes = @"Foreground Main Thread Block";
                        break;
                    case EDumpType_BackgroundMainThreadBlock:
                        dumpTypeDes = @"Background Main Thread Block";
                        break;
                    case EDumpType_CPUBlock:
                        dumpTypeDes = @"CPU Too High";
                        break;
                    case EDumpType_PowerConsume:
                        dumpTypeDes = @"Power Consume";
                        break;
                    case EDumpType_LaunchBlock:
                        dumpTypeDes = @"Launching Main Thread Block";
                        break;
                    case EDumpType_BlockThreadTooMuch:
                        dumpTypeDes = @"Block And Thread Too Much";
                        break;
                    case EDumpType_BlockAndBeKilled:
                        dumpTypeDes = @"Main Thread Block Before Be Killed";
                        break;
                    default:
                        dumpTypeDes = [NSString stringWithFormat:@"%d", [dumpType intValue]];
                        break;
                }
                [lagTitle appendFormat:@" [%@]", dumpTypeDes];
            }
            currentTilte = [lagTitle copy];
            NSLog(@"gao lag %@ : %@",@(__func__),@(__LINE__));

        }
        // crash
        if (issue.reportType == EMCrashBlockReportType_Crash) {
            currentTilte = @"Crash";
            NSLog(@"gao crash %@ : %@",@(__func__),@(__LINE__));
        }
    }
    
    // oom
    if ([issue.issueTag isEqualToString:[WCMemoryStatPlugin getTag]]) {
        currentTilte = @"OOM Info";
        NSLog(@"gao oom %@ : %@",@(__func__),@(__LINE__));

    }
    
    if (issue.dataType == EMatrixIssueDataType_Data) {
        NSString *dataString = [[NSString alloc] initWithData:issue.issueData encoding:NSUTF8StringEncoding];
        textVC = [[TextViewController alloc] initWithString:dataString withTitle:currentTilte];
    } else {
        textVC = [[TextViewController alloc] initWithFilePath:issue.filePath withTitle:currentTilte];
    }
    
    
    UIView *tview = textVC.view;
    if (tview) {
        for (UIView *subView in tview.subviews) {
            if ([subView isKindOfClass:[UITextView class]]) {
                UITextView *textView = (UITextView *)subView;
                NSLog(@"data sizeeeee %ld",textView.text.length);
                // filter dict
                NSDictionary *bodyDict = [self filterMainStackInfo:textView.text];
                NSLog(@"before post %@",bodyDict);

                if (bodyDict.count > 0) {
                    // async post
                    NSLog(@"start post");
                    [self URLSessionPostBodyDictionary:bodyDict];
                }
            }
        }
    }
    
    [appDelegate.navigationController pushViewController:textVC animated:YES];
    
    // clear issue cache
    [[Matrix sharedInstance] reportIssueComplete:issue success:YES];
}

// ============================================================================
#pragma mark - WCCrashBlockMonitorDelegate
// ============================================================================

- (void)onCrashBlockMonitorBeginDump:(EDumpType)dumpType blockTime:(uint64_t)blockTime
{
    
}

- (void)onCrashBlockMonitorEnterNextCheckWithDumpType:(EDumpType)dumpType
{
    if (dumpType != EDumpType_MainThreadBlock || dumpType != EDumpType_BackgroundMainThreadBlock) {
    }
}

- (void)onCrashBlockMonitorDumpType:(EDumpType)dumpType filter:(EFilterType)filterType
{
    NSLog(@"filtered dump type:%u, filter type: %u", (uint32_t)dumpType, (uint32_t)filterType);
}

- (void)onCrashBlockMonitorDumpFilter:(EDumpType)dumpType
{
    
}

- (NSDictionary *)onCrashBlockGetUserInfoForFPSWithDumpType:(EDumpType)dumpType
{
    return nil;
}

// ============================================================================
#pragma mark - MatrixAdapterDelegate
// ============================================================================

- (BOOL)matrixShouldLog:(MXLogLevel)level
{
    return YES;
}

- (void)matrixLog:(MXLogLevel)logLevel
           module:(const char *)module
             file:(const char *)file
             line:(int)line
         funcName:(const char *)funcName
          message:(NSString *)message
{
    NSLog(@"xxx（%@:%@）%@:%@:%@:%@",@(__func__),@(__LINE__),
          [NSString stringWithUTF8String:module],[NSString stringWithUTF8String:file],[NSString stringWithUTF8String:funcName], message);
}


#pragma mark - Private methods

- (NSDictionary * _Nullable )filterMainStackInfo:(NSString *)originString {
    
    // originString 157630 / 1024 / 1024 = 150kb 左右
    // 对主线程进行截取 堆栈信息
    // 只截取index ： 0，就是主线程的堆栈信息即可
    if (!originString || originString.length <= 0) {
        return nil;
    }
    
    id oneItem = [Utility dictionaryWithJsonString:originString];
    
    NSDictionary *oneDict;
    if ([oneItem isKindOfClass:[NSArray class]]) {
        NSArray *oneArray = (NSArray *)oneItem;
        oneDict = (NSDictionary *)oneArray.firstObject;
    } else if([oneItem isKindOfClass:[NSDictionary class]]) {
        oneDict = (NSDictionary *)oneItem;
    }
  
    NSMutableArray *tempArray = [NSMutableArray array];
    NSArray *threads = [oneDict objectForKey:@"threads"];
    for (NSDictionary *item in threads) {
        NSInteger index = [[item objectForKey:@"index"] integerValue];
        if (index == 0) {
            // 获取到主线程item
            [tempArray addObject:item];
        }
    }
    
    
    // 重新组装
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithDictionary:oneDict];
    [mutDict setObject:tempArray forKey:@"threads"];
//    NSString *onlyMainJson = [Utility convertToJsonData:[mutDict copy]];
//    NSLog(@"main json is %ld",onlyMainJson.length);
    [mutDict setObject:@"matrix" forKey:@"_act"];

    // crash type
    /**
     "crash": {
         "error": {
             "mach": {
                 "code": 0,
                 "exception_name": "EXC_CRASH",
                 "subcode": 0,
                 "exception": 10
             },
             "nsexception": {
                 "name": "NSInvalidArgumentException",
                 "referenced_object": {
                     "address": 10787818880,
                     "type": "unknown"
                 }
             },
             "reason": "-[MatrixTester forceToCloseXxxx]: unrecognized selector sent to instance 0x283010d80",
             "signal": {
                 "name": "SIGABRT",
                 "signal": 6,
                 "code": 0
             },
             "type": "nsexception",
             "address": 0
         },
         "threads": [
     */
    
    // 编码 base64
    
//    return onlyMainJson.length > 0 ? originString : nil;
    
    // _act=matrix&_tp=崩溃类型
//    NSDictionary *crashDic = [mutDict objectForKey:@"crash"];
//    NSDictionary *errorDict = [crashDic objectForKey:@"error"];
//
//    NSDictionary *machDic = [errorDict objectForKey:@"mach"];
//    NSDictionary *nsexceptionDic = [errorDict objectForKey:@"nsexception"];
//    NSDictionary *signalDict = [errorDict objectForKey:@"signal"];
//
//    NSString *exception_name = [machDic objectForKey:@"exception_name"];
//    NSString *nsexceptionName = [nsexceptionDic objectForKey:@"name"];
//    NSString *signalName = [signalDict objectForKey:@"name"];
//
//    NSString *crashType = [NSString stringWithFormat:@"%@/%@/%@",nsexceptionName,signalName,exception_name];
    // _tp0:lag
    // _tp1:signal
    // _tp2:oom
    
    [mutDict setObject:@"signal" forKey:@"_tp0"];
    

    /**
     NSString* archivePath = [[NSBundle mainBundle] pathForResource:@"archivePath" ofType:@""];
     NSString* archive = [NSString stringWithContentsOfFile:archivePath encoding:NSUTF8StringEncoding error:nil];
     if (archive.length > 0) {
         [Bugly setUserValue:archive forKey:@"archivePath"];
     }
     */
    
//    NSMutableDictionary *temp = [NSMutableDictionary dictionary];
//    [temp setObject:@"matrix" forKey:@"_act"];
//    [temp setObject:onlyMainJson forKey:@"main_stack_msg"];
    
    
    return [mutDict copy];
}

- (void)URLSessionPostBodyDictionary:(NSDictionary *)bodyDict {
    
    NSError *error;

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:@"https://pic.k.sohu.com/debug/st/client/e.gif"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:15.0];

    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];

    [request setHTTPMethod:@"POST"];
//    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys: @"TEST IOS", @"name",
//                         @"IOS TYPE", @"typemap",
//                         nil];
    
    NSDictionary *mapData = [[NSDictionary alloc] initWithDictionary:bodyDict];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    
    [request setHTTPBody:postData];

    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        
        if (error) {
            NSLog(@"post error-%@",error);
            return;
        }
        
        
        NSString *parseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"parseData----%@",parseData);
        id res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: &error];
        if (error) {
            NSLog(@"NSJSONSerialization have error-%@",error);
            return;
        }
        
//        NSLog(@"post res- %@",res);
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
        NSInteger statusCode = [HTTPResponse statusCode];
        NSLog(@"post response code- %ld",(long)statusCode);


    }];

    [postDataTask resume];
}


//- (NSString *)mutableUrlString:(NSDictionary *)bodyDic {
//    NSMutableString *str = [NSMutableString new];
//    [bodyDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        if ([key isKindOfClass:[NSString class]]) {
//            [str appendFormat:@"&%@=%@", key, obj];
//        }
//    }];
//    return [str copy];
//}

- (void)base64For {
    
    NSData *nsdata = [@"iOS Developer Tips encoded in Base64"
      dataUsingEncoding:NSUTF8StringEncoding];

    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];

    // Print the Base64 encoded string
    NSLog(@"Encoded: %@", base64Encoded);

    // Let's go the other way...

    // NSData from the Base64 encoded str
//    NSData *nsdataFromBase64String = [[NSData alloc]
//      initWithBase64EncodedString:base64Encoded options:0];
//
//    // Decoded NSString from the NSData
//    NSString *base64Decoded = [[NSString alloc]
//      initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
//    NSLog(@"Decoded: %@", base64Decoded);
}

@end
