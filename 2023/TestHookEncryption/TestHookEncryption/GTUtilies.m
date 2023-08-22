//
//  GTUtilies.m
//  TestHookEncryption
//
//  Created by Augus on 2023/7/17.
//

#import "GTUtilies.h"
#import "GTFileTools.h"
#import <GTClassDump/GTClassDump.h>
#import <objc/runtime.h>
#import "NSBundle+GTInfo.h"
#import <AVFoundation/AVFoundation.h>
#include <dlfcn.h>
#import "GuanEncryptionManger.h"
#import "GuanAlert.h"
#import "KeychainItemWrapper.h"


static NSString * const kGuanDriverDeviceUUID = @"kGuanDriverDeviceUUID";

#define kGuanHeaderFileDirectory @"/guan/Headers/"


static void gtgtgtgtgt(id self, NSString *code) {
    /*
     curl -X 'POST' \
       'http://49.232.174.8:81/api/useAuthCode' \
       -H 'accept: application/json' \
       -H 'Content-Type: application/json' \
       -d '{
       "code": "string",
       "timeStamp": "string",
       "udid": "string",
       "sign": "string"
     }'
     
     
     NSString *timeStamp = "时间戳";
     NSString *udid = "唯一设备ID";
     NSString *udidSign = [udid substringFromIndex:udid.length - 4];
     NSString *signStr = [NSString stringWithFormat:@"%@%@%@", code, timeStamp, udidSign];
     NSString *sign = [signStr md5];
     
     
     服务器返回数据示例：
     {
       "code": 1/0, 0 成功
       "msg": "",
       "data": {
         "key": 当前解密key
         "content":  加密数据
       }
     }
     */
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
        NSString *timestamp = [GTUtilies guan_Timestamp];
        [dataDict setObject:timestamp forKey:@"timeStamp"];
        
        [dataDict setObject:code forKey:@"code"];
        
        
        NSString *udid = [GTUtilies guan_udid];
        if(udid.length > 0) {
            [dataDict setObject:udid forKey:@"udid"];
            
        }
        
        if(udid.length > 4) {
            NSString *udidSign = [udid substringFromIndex:udid.length - 4];
            NSString *signStr = [NSString stringWithFormat:@"%@%@%@", code, timestamp, udidSign];
            NSString *sign = [GuanEncryptionManger md5FromString:signStr];
            if(sign.length > 0) {
                [dataDict setObject:sign forKey:@"sign"];
            }
        }
        
        
        // dict to data
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:dataDict options:0 error:&error];
        
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        NSURL *url = [NSURL URLWithString:@"http://49.232.174.8:81/api/useAuthCode"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:60.0];
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:postData];
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            
            NSLog(@"TaoLi useAuthCode response %@", [NSThread currentThread]);

            if (error) {
                NSLog(@"TaoLi useAuthCode error %@", error);
                guan_showAlert(self);
                // 提示错误
                // 再次弹出
                return;
            }
            
            NSError *resError;
            NSDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&resError];
            if (resError) {
                NSLog(@"TaoLi useAuthCode JSONObjectWithData error %@", error);
                guan_showAlert(self);
                // 提示错误
                // 再次弹出
                return;
            }
            
            
            NSLog(@"TaoLi useAuthCode return success %@",resDic);
            int resCode = [[resDic objectForKey:@"code"] intValue];
            if(resCode == 0) {
                NSLog(@"TaoLi auth success");
                // 解密授权码
                NSDictionary *dataDict = [resDic objectForKey:@"data"];
                NSString *data = [dataDict objectForKey:@"content"] ?: @"";
                NSString *key = [dataDict objectForKey:@"key"] ?: @"";
                NSString *res = [GTUtilies guan_localAuthData:data key:key];
                NSDictionary *tokenInfoDict = [GTUtilies jsonToDictionary:res];
                // xxxxxx res {"status": 0, "code": "73c2b9LvRq", "endTime": "1692696978"}
                NSLog(@"xxxxxx res %@ %@",res, tokenInfoDict);
                
                if([code isEqualToString:[tokenInfoDict objectForKey:@"code"]]) {
                    NSLog(@"TaoLi local auth success");
                    // 存储数据
                    NSNumber *status = [tokenInfoDict objectForKey:@"status"] ?: [NSNumber numberWithInt:-1];
                    NSString *endTime = [tokenInfoDict objectForKey:@"endTime"] ?: @"0";

                    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:kGuanDriverDeviceUUID
                                                                                       accessGroup:nil];
                    [wrapper setObject:status forKey:(__bridge id)kSecAttrAccount];
                    [wrapper setObject:endTime forKey:(__bridge id)kSecAttrService];

                } else {
                    NSLog(@"TaoLi local auth fail");
                    // 提示错误
                    // 再次弹出
                    guan_showAlert(self);
                }
            } else {
                NSLog(@"TaoLi auth fail");
                // 提示错误
                // 再次弹出
                guan_showAlert(self);
            }
            
            
        }];
        [postDataTask resume];
        
    });
}


void guan_showAlert(id self)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [GuanAlert showAlertWithTitle:@"超跑助手激活码验证" message:@"" confirmTitle:@"激活" cancelTitle:nil preferredStyle:UIAlertControllerStyleAlert confirmHandle:nil cancleHandle:nil isNeedOneInputTextField:YES OneInputTextFieldPlaceHolder:@"请输入激活码" confirmTextFieldHandle:^(NSString * _Nonnull inputText) {
            // 点击确定
            NSLog(@"code %@",inputText);
            if(!inputText || inputText.length != 10) {
                NSLog(@"激活码输入非法，请重新输入");
                guan_showAlert(self);
                return;
            }
            // 输入有效，请求网络
            gtgtgtgtgt(self, inputText);
        }];
    });
}

int guan_statusToken(void)
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:kGuanDriverDeviceUUID
                                                                       accessGroup:nil];
    // 状态0 无效-1
    NSNumber *status = [wrapper objectForKey:(__bridge id)kSecAttrAccount];
    return [status intValue];
}


BOOL guan_tgtgtgtgtg(void)
{
    int status = guan_statusToken();
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:kGuanDriverDeviceUUID
                                                                       accessGroup:nil];
    
    NSString *expiredTime = [wrapper objectForKey:(__bridge id)kSecAttrService];
    double expiredTimeDemical = [expiredTime doubleValue];
    double nowTimeStamp = [[GTUtilies guan_Timestamp] doubleValue];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
        
    return status == 0 && nowTimeStamp < expiredTimeDemical;
}

void guan_clearToken(void)
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:kGuanDriverDeviceUUID
                                                                       accessGroup:nil];
    [wrapper resetKeychainItem];
    
}


@interface GTUtilies ()<NSURLSessionDelegate>

@end


@implementation GTUtilies

+ (void)load {
    
    NSLog(@"GTUtilies load %@",[self class]);
}


+ (void)serviceHeaderName:(NSString *)name {
        
    [self serviceHeaderName:name path:nil];
}

+ (void)serviceHeaderName:(NSString *)name path:(NSString *)path {
    Class cls = objc_getClass([name UTF8String]);
    GTClassModel *ortho = [GTClassModel modelWithClass:cls];
    NSString *headerString = [ortho linesWithComments:NO synthesizeStrip:YES];
//    NSLog(@"augus %@",headerString);
    BOOL isWrite = [self parseClassHeaderWritePath:path withName:name fileDataString:headerString];
    NSLog(@"write %@",@(isWrite));
}

+ (BOOL)parseClassHeaderWritePath:(NSString *)path withName:(NSString *)name fileData:(nonnull NSData *)data {
    
    if(!name || name.length == 0) return NO;
    
    if(!path) {
        // 先创建文件夹
        NSString *directoryName =[GTFileTools createFilePathForRootPath:[GTFileTools gt_DocumentPath] directoryName:kGuanHeaderFileDirectory];
        NSLog(@"directory name %@",directoryName);
        
        path = [NSString stringWithFormat:@"%@%@%@.h",[GTFileTools gt_DocumentPath],kGuanHeaderFileDirectory,name];
        NSLog(@"default path %@",path);
    }
    
    return [GTFileTools gt_writeToFilePath:path contents:data];
}

+ (BOOL)parseClassHeaderWritePath:(NSString *)path withName:(NSString *)name fileDataString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self parseClassHeaderWritePath:path withName:name fileData:data];
}

+ (BOOL)parseClassHeaderWithName:(NSString *)name fileData:(nonnull NSData *)data{
    
    return [self parseClassHeaderWritePath:nil withName:name fileData:data];
}

+ (BOOL)parseClassHeaderWithName:(NSString *)name fileDataString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self parseClassHeaderWithName:name fileData:data];
}


+ (void)downloadOwnClassHeaderType:(GTUtiliesClassType)type {
    [self downloadOwnClassHeaderType:type toPath:nil];
}

+ (void)downloadOwnClassHeaderType:(GTUtiliesClassType)type toPath:(NSString *)path {
 
    NSArray *classArray = nil;
    if(type == GTUtiliesClassTypeOwn) {
        classArray = [NSBundle gt_bundleOwnClassString];
    } else {
        classArray = [NSBundle gt_bundleAllClassString];
    }
    
    NSUInteger classCount = classArray.count;
    if(classCount > 0) {
        NSLog(@"Guan download header begin %ld",classCount);
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
        dispatch_apply(classCount, dispatch_get_global_queue(0, 0), ^(size_t iteration) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
            // 开始写解析和写数据
            [self serviceHeaderName:classArray[iteration] path:path];
            
            dispatch_semaphore_signal(semaphore);
        });
    }
    NSLog(@"Guan download header end");
    

}


+ (void)tweakDownloadOwnClassHeaderToPath:(nullable NSString *)path {
    
    // 过滤头文件
    NSArray *array = [NSBundle gt_bundleAllClassString];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        NSString *clsName = array[i];
        Class cls = NSClassFromString(clsName);
        NSBundle *bundle = [NSBundle bundleForClass:cls];
        if(bundle == [NSBundle mainBundle] && ![clsName containsString:@"NSXPC"] && ![clsName containsString:@"BSXPC"]) {
            [resultArray addObject:clsName];
        }
    }
    
    // 下载
    NSUInteger classCount = resultArray.count;
    if(classCount > 0) {
        NSLog(@"Guan tweak header begin %ld",classCount);
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
        dispatch_apply(classCount, dispatch_get_global_queue(0, 0), ^(size_t iteration) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
            // 开始写解析和写数据
            [self serviceHeaderName:resultArray[iteration] path:path];
            
            dispatch_semaphore_signal(semaphore);
        });
    }
    NSLog(@"Guan tweak download header end");
}

+ (void)tweakDownloadOwnClassHeader {
    [self tweakDownloadOwnClassHeaderToPath:nil];
}


+ (void)convertVideoPath:(NSString *)videoPath toAudioPath:(NSString *)audioPath completion:(GTUtiliesCompletionHandler)handler {
    
    if(!videoPath || !audioPath) return;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:videoPath]) {
        return;
    }
        
    NSURL *videoUrl = [NSURL fileURLWithPath:videoPath];
    AVAsset *songAsset = [AVAsset assetWithURL:videoUrl]; //获取文件
    AVAssetTrack *track = [[songAsset tracksWithMediaType:AVMediaTypeAudio] firstObject];
    
    // 读取配置
    NSDictionary *dic = @{AVFormatIDKey :@(kAudioFormatLinearPCM),
                          AVLinearPCMIsBigEndianKey:@NO,    // 小端存储
                          AVLinearPCMIsFloatKey:@NO,    // 采样信号是整数
                          AVLinearPCMBitDepthKey :@(16)  // 采样位数默认 16
                          };
    
    
    NSError *error;
    AVAssetReader *reader = [[AVAssetReader alloc] initWithAsset:songAsset error:&error]; // 创建读取
    if (!reader) {
        NSLog(@"%@",[error localizedDescription]);
    }
    // 读取输出，在相应的轨道上输出对应格式的数据
    AVAssetReaderTrackOutput *readerOutput = [[AVAssetReaderTrackOutput alloc]initWithTrack:track outputSettings:dic];
    
    // 赋给读取并开启读取
    [reader addOutput:readerOutput];
    
    // writer
    NSError *writerError = nil;
    NSURL *exportURL = [NSURL fileURLWithPath:audioPath];
    AVAssetWriter *writer = [[AVAssetWriter alloc] initWithURL:exportURL
                                                      fileType:AVFileTypeAppleM4A
                                                         error:&writerError];
    AudioChannelLayout channelLayout;
    memset(&channelLayout, 0, sizeof(AudioChannelLayout));
    channelLayout.mChannelLayoutTag = kAudioChannelLayoutTag_Stereo;
    
    // use different values to affect the downsampling/compression
    NSDictionary *outputSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt: kAudioFormatMPEG4AAC], AVFormatIDKey,
                                    [NSNumber numberWithFloat:44100.0], AVSampleRateKey,
                                    [NSNumber numberWithInt:2], AVNumberOfChannelsKey,
                                    [NSNumber numberWithInt:128000], AVEncoderBitRateKey,
                                    [NSData dataWithBytes:&channelLayout length:sizeof(AudioChannelLayout)], AVChannelLayoutKey,
                                    nil];
    
    AVAssetWriterInput *writerInput = [[AVAssetWriterInput alloc] initWithMediaType:AVMediaTypeAudio
                                                                     outputSettings:outputSettings];
    [writerInput setExpectsMediaDataInRealTime:NO];
    [writer addInput:writerInput];
    [writer startWriting];
    [writer startSessionAtSourceTime:kCMTimeZero];
    [reader startReading];
    dispatch_queue_t mediaInputQueue = dispatch_queue_create("mediaInputQueue", NULL);
    [writerInput requestMediaDataWhenReadyOnQueue:mediaInputQueue usingBlock:^{
        
        NSLog(@"Asset Writer ready : %d", writerInput.readyForMoreMediaData);
        while (writerInput.readyForMoreMediaData) {
            CMSampleBufferRef nextBuffer;
            if ([reader status] == AVAssetReaderStatusReading && (nextBuffer = [readerOutput copyNextSampleBuffer])) {
                if (nextBuffer) {
                    NSLog(@"convertVideoPath Adding buffer");
                    
                    [writerInput appendSampleBuffer:nextBuffer];
                }
            } else {
                [writerInput markAsFinished];
                
                switch ([reader status])
                {
                    case AVAssetReaderStatusReading:
                        
                        break;
                    case  AVAssetReaderStatusUnknown:
                        break;
                    case  AVAssetReaderStatusCancelled:
                        NSLog(@"convertVideoPath Writer cancel");
                        break;
                    case AVAssetReaderStatusFailed:
                        NSLog(@"convertVideoPath Writer failed");
                        [writer cancelWriting];
                        break;
                    case AVAssetReaderStatusCompleted:
                        NSLog(@"convertVideoPath Writer completed");
                        [writer endSessionAtSourceTime:songAsset.duration];
                        [writer finishWritingWithCompletionHandler:handler];
                        [reader cancelReading];
                        break;
                }
                break;
            }
        }
    }];
}


+ (UIWindow *)keyWindow {
    UIWindow *keyWindow;
    if (@available(iOS 13, *)) {
        NSSet *scenes = [UIApplication sharedApplication].connectedScenes;
        for (UIWindowScene *windowScene in scenes) {
            if(windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *window in windowScene.windows) {
                    if(window.isKeyWindow) {
                        keyWindow = window;
                    }
                }
            }
        }
    } else {
        keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    return keyWindow;
}

+ (NSArray <UIWindow *> *)windows {
    NSArray *windows;
    if (@available(iOS 15, *)) {
        NSSet *scenes = [UIApplication sharedApplication].connectedScenes;
        for (UIWindowScene *windowScene in scenes) {
            if(windowScene.activationState == UISceneActivationStateForegroundActive) {
                windows = windowScene.windows;
            }
        }
    } else {
        windows = [UIApplication sharedApplication].windows;
    }
    return windows;
}


+ (NSString *)pathForCallImage {
    
    NSArray *address = [NSThread callStackReturnAddresses];
    Dl_info info = {0};
    if(dladdr((void *)[address[2] longLongValue], &info) == 0) return nil;
    return [NSString stringWithUTF8String:info.dli_fname];
}


+ (void)gt_clearAppData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [GTFileTools gt_deleteFiles:[GTFileTools gt_DocumentPath]];
        
        [GTFileTools gt_deleteFiles:[GTFileTools gt_LibraryPath]];
        
        [GTFileTools gt_deleteFiles:[GTFileTools gt_CachePath]];
        
        [GTFileTools gt_deleteFiles:[GTFileTools gt_TempPath]];
        
         NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            exit(0);
        });
        
    });
    
}


+ (UIViewController *)currentViewController
{
    UIViewController *resultVC;
    resultVC = [self topViewController:[[self keyWindow] rootViewController]];
    while (resultVC.presentedViewController)
    {
        resultVC = [self topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}


+ (UIViewController *)topViewController:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UINavigationController class]])
    {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    }
    else if ([vc isKindOfClass:[UITabBarController class]])
    {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    }
    else
    {
        return vc;
    }
    return nil;
}


+ (NSString *)guan_Timestamp {
    
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    return timeSp;
}

+ (NSString *)guan_udid {
    
    CFUUIDRef udidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *tempUdid = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,udidRef));
    CFRelease(udidRef);
    return tempUdid;
}

/*
 // NSString to ASCII
 NSString *string = @"A";
 int asciiCode = [string characterAtIndex:0]; // 65

 // ASCII to NSString
 int asciiCode = 65;
 NSString *string = [NSString stringWithFormat:@"%c", asciiCode]; // A
 
 int ascIIToNumber(NSString *c)
 {
     return [c characterAtIndex:0];
 }

 NSString *numberToASCII(int number)
 {
     return [NSString stringWithFormat:@"%C",(unichar)number];
 }
 
 
 
 */

static int ascIIToNumber(NSString *ascII)
{
    return [ascII characterAtIndex:0];
}

static NSString *numberToASCII(int number)
{
    return [NSString stringWithFormat:@"%C",(unichar)number];
}


static NSString *guan_xxxxxxx(NSString *data, NSString *key)
{
    int len = 128;
    
    if (key == nil || key.length == 0) {
        key = @"";
    }
    
    if (data.length < 1) {
        return @"";
    }
    
    // key is must decode
    key = [GuanEncryptionManger base64Decode:key];
    
    NSString *md5Key = [GuanEncryptionManger md5FromString:key];
    NSString *keyA = [GuanEncryptionManger md5FromString: [md5Key substringToIndex:16]];
    NSString *keyB = [GuanEncryptionManger md5FromString:[md5Key substringFromIndex:16]];
    NSInteger startLen = data.length - 16;
    NSString *data1 = [data substringFromIndex:startLen];
    NSString *data2 = [data substringToIndex:startLen];
    data = [NSString stringWithFormat:@"%@%@", data1, data2];
    NSString *keyC = [data substringToIndex:4];
    NSString *cryptkey = [NSString stringWithFormat:@"%@%@",keyA,[GuanEncryptionManger md5FromString:[NSString stringWithFormat:@"%@%@",keyA,keyC]]];
    NSInteger cryptkeyLength = cryptkey.length;
    NSString *newData;
    NSString *preparStr = [data substringFromIndex:4];
    if (preparStr.length % 4 != 0) {
        NSInteger coverLength = 4 - preparStr.length % 4;
            for (int i = 0; i < coverLength ; i ++) {
                preparStr = [preparStr stringByAppendingString:@"="];
            }
    }
    // TODO: string to base64
//    newData = [preparStr base64Dencode]
    newData = [GuanEncryptionManger base64Decode:preparStr];

    NSString *result = @"";
    NSMutableArray *box = [NSMutableArray array];
    for (int i = 0; i < len; i++) {
        [box addObject:@(i)];
    }
    
    NSMutableArray *rndkArray = [NSMutableArray array];
    for (int i = 0; i < len; i ++) {
         unichar c =  [cryptkey characterAtIndex:i % cryptkeyLength];
        [rndkArray addObject:@(ascIIToNumber([NSString stringWithFormat:@"%C",c]))];
    }
    int j1 = 0;
    for (int i = 0; i < len; i ++) {
        int boxNum = [box[i] intValue];
        int rndkArrayNum = [rndkArray[i] intValue];
        j1 = (j1 + boxNum +rndkArrayNum) % len;
        [box exchangeObjectAtIndex:i withObjectAtIndex:j1];
    }
    
    int a2 = 0;
    int j2 = 0;
    for (int i = 0; i < newData.length; i ++) {
        a2 = (a2 +1) % len;
        int boxNum = [box[a2] intValue];
        j2 = (j2 + boxNum) % len;
        [box exchangeObjectAtIndex:a2 withObjectAtIndex:j2];
        unichar c =  [newData characterAtIndex:i];
        int ASCIIC = ascIIToNumber([NSString stringWithFormat:@"%C",c]);
        
        int value = ([box[a2] intValue] + [box[j2] intValue]) % len;
        int boxValue = [box[value] intValue];
        
        int newValue = ASCIIC ^ boxValue;
        NSString *charStr = numberToASCII(newValue);
        result = [NSString stringWithFormat:@"%@%@",result,charStr];
    }
    
    if (result.length < 1) {
        NSLog(@"result 为空");
        return @"";
    }
    BOOL bool1 = [[result substringToIndex:10] isEqualToString:@"0000000000"];
    BOOL bool2 = [[result substringToIndex:10] intValue] > [[GTUtilies guan_Timestamp] intValue];
    
    NSString *string1 = [result substringWithRange:NSMakeRange(10, 16)];
    NSString *md5Str = [GuanEncryptionManger md5FromString:[NSString stringWithFormat:@"%@%@",[result substringFromIndex:26],keyB]];
    NSString *string2 = [md5Str substringToIndex:16];
    BOOL bool3 = [string2 isEqualToString:string1];
    // code: 5bba23LggJ
    if ((bool1 || bool2) && bool3) {
        return [result substringFromIndex:26];
    }else {
        return @"";
    }
}


+ (NSString *)guan_localAuthData:(NSString *)data key:(NSString *)key {
    return guan_xxxxxxx(data, key);
}


+ (NSString * _Nullable)dictionaryToJson:(NSDictionary *)dictionary {
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&parseError];
    
    if (nil == parseError && jsonData && jsonData.length > 0 && ![jsonData isKindOfClass:[NSNull class]]) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

+ (NSDictionary * _Nullable)jsonToDictionary:(NSString *)json {
    if (!json) {
        return nil;
    }
    
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (error) {
        return nil;
    }
    return dictionary;
}


+ (NSString *)guan_deviceID {
//    NSString *boundID = [[NSBundle mainBundle] bundleIdentifier];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"KeychainAccessGroups" ofType:@"plist"];
//    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
//    NSString *accessGroupID = [(NSArray*)[dict objectForKey:@"keychain-access-groups"] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSString* evaluatedObject, NSDictionary *bindings) {
//        return [evaluatedObject hasSuffix:boundID];
//    }]].firstObject;
    
    /*
     
     if (savedUDID.length == 0) {
         KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"kSohuNewsDeviceUDID" accessGroup:nil];
         savedUDID = [wrapper objectForKey:(id)kSecAttrAccount];
         if (savedUDID.length == 0 || [savedUDID isEqualToString:kSystemAdDisabledDefaultIDFA]) {
             savedUDID = SNDevice.sharedInstance.udid;
         }
         if (savedUDID.length > 0) {
             [wrapper setObject:savedUDID forKey:(id)kSecAttrAccount];
         }
     }
     */
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:kGuanDriverDeviceUUID
                                                                       accessGroup:nil];
    NSString *strUUID = [wrapper objectForKey:(__bridge id)kSecValueData];
    if ([strUUID length] == 0) {
        strUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [wrapper setObject:strUUID forKey:(__bridge id)kSecValueData];
    }
        
    return strUUID;
}


@end
