//
//  GTFileTools.m
//  TestObjcSome
//
//  Created by Augus on 2023/1/30.
//

#import "GTFileTools.h"

@implementation GTFileTools


+ (NSString *)gt_DocumentPath {
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


+ (NSString *)gt_CachePath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];;
}


+ (NSString *)gt_LibraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];;
}


+ (NSString *)gt_TempPath {
    return NSTemporaryDirectory();
}


+ (NSString *)createFilePathForRootPath:(NSString *)rootPath directoryName:(NSString *)directoryName {
    
    if(!directoryName || !rootPath) return nil;
    
    NSString *directryPath  = [rootPath stringByAppendingPathComponent:directoryName];
    if (![self gt_fileIsExist:directryPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return directryPath;
}


+ (NSString *)gt_rootPath:(GTFileStoreType)type {
    
    switch (type) {
        case GTFileStoreTypeDocument:
            return [self gt_DocumentPath];
            break;
        case GTFileStoreTypeLibrary:
            return [self gt_LibraryPath];
            break;
        case GTFileStoreTypeCache:
            return [self gt_CachePath];
            break;
        case GTFileStoreTypeTemp:
            return [self gt_TempPath];
            break;
        default:
            break;
    }
    
    return nil;
}


+ (BOOL)gt_fileIsExist:(NSString *)path {
    
    if(!path || path.length == 0) {
        return NO;
    }
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}


+ (NSString *)gt_createFileName:(NSString *)fileName type:(GTFileStoreType)type contents:(NSData *)contents {
    
    if(!fileName || fileName.length == 0) {
        return nil;
    }
    
    NSString *rootPath = [[self gt_rootPath:type] stringByAppendingString:fileName];
    // 如果已经存在该文件
    if ([self gt_fileIsExist:rootPath]) {
        // 先进行移除操作
        if (![[NSFileManager defaultManager] removeItemAtPath:rootPath error:nil]) {
            // 没有移除成功则返回nil
            return nil;
        }
    }
    
    // 创建路径并写入数据
    if ([[NSFileManager defaultManager] createFileAtPath:rootPath contents:contents attributes:nil]) {
        return rootPath;
    }
    
    return nil;
}


+ (BOOL)gt_writeToFilePath:(NSString *)filePath contents:(NSData *)contents {
    
    // 如果文件不存在直接创建
    if(![self gt_fileIsExist:filePath]) {
        // 创建失败返回NO
        if (![[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil]) {
            return NO;
        }
        return NO;
    }
    
    // 如果是plist文件，则进行判断结构
    if([filePath containsString:@".plist"]) {
        
        
    }else if (contents.bytes > 0) {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:contents];
        [fileHandle synchronizeFile];
        [fileHandle closeFile];
        return YES;
    }
    
    return NO;
}
@end
