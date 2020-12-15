//
//  FSFlieManager.m
//  fosFloatView
//
//  Created by Augus on 2020/11/10.
//

#import "FSFlieManager.h"

@implementation FSFlieManager

singtonImplement(FSFlieManager);

+ (NSString *)FSFolderPath {
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fsFolderPath = [NSString stringWithFormat:@"%@/FSVoice",documentDir];
    BOOL isExist =  [[NSFileManager defaultManager]fileExistsAtPath:fsFolderPath];
    if (!isExist) {
         [[NSFileManager defaultManager] createDirectoryAtPath:fsFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return fsFolderPath;
}

+ (NSString *)soundTouchSavePathWithFileName:(NSString *)fileName {
//    NSString *fileName = [self fileName];
    
    NSString *wavfilepath = [NSString stringWithFormat:@"%@/SoundTouch",[FSFlieManager FSFolderPath]];
    
    NSString *writeFilePath = [NSString stringWithFormat:@"%@/%@",wavfilepath, fileName];
    BOOL isExist =  [[NSFileManager defaultManager] fileExistsAtPath:writeFilePath];
    if (isExist) {
        //如果存在则移除 以防止 文件冲突
//        NSError *err = nil;
        [FSFlieManager removeFile:writeFilePath];
//        [[NSFileManager defaultManager] removeItemAtPath:writeFilePath error:&err];
    }
    
    BOOL isExistDic =  [[NSFileManager defaultManager] fileExistsAtPath:wavfilepath];
    if (!isExistDic) {
        [[NSFileManager defaultManager] createDirectoryAtPath:wavfilepath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return writeFilePath;
}


+ (NSString *)fileName {
    NSString *fileName = [NSString stringWithFormat:@"CWVoice%lld.wav",(long long)[NSDate timeIntervalSinceReferenceDate]];
    return fileName;
}

+ (NSString *)filePath {
    NSString *path = [FSFlieManager FSFolderPath];
    NSString *fileName = [FSFlieManager fileName];
    return [path stringByAppendingPathComponent:fileName];
}

+ (void)removeFile:(NSString *)filePath{
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}


@end
