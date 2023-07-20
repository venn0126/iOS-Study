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

#define kGuanHeaderFileDirectory @"/guan/Headers/"


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

@end
