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
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}


+ (NSString *)gt_LibraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
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
    
    // 如果文件不存在新建
    if(![self gt_fileIsExist:filePath]) {
        // 创建失败返回NO
        if (![[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil]) {
            return NO;
        }
    }
    
    // 文件存在且有数据则返回NO
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    if(fileData.length >= contents.length) {
        NSLog(@"当前头文件已存在");
        return NO;
    }
    
    // 文件存在写入数据
    if(contents.bytes > 0) {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:contents];
        [fileHandle synchronizeFile];
        [fileHandle closeFile];
        return YES;
    }
    
    return NO;
}

+ (BOOL)enumerateDirectory:(NSString *)directory containsFileName:(NSString *)fileName {
    
    if(!directory || directory.length == 0) {
        directory = @"/Library/MobileSubstrate/DynamicLibraries";
    }
    NSFileManager *fileManger = [NSFileManager defaultManager];
    BOOL isExist = NO;
    NSDirectoryEnumerator *directoryEnumerator = [fileManger enumeratorAtPath:directory];
    for (NSString *path in directoryEnumerator.allObjects) {
        if([path isEqualToString:fileName]) {
            isExist = YES;
            break;
        }
    }
    return isExist;
}

+ (BOOL)enumerateDirectoryContainsFileName:(NSString *)fileName {
    
    return [self enumerateDirectory:nil containsFileName:fileName];
}

+ (void)gt_deleteFiles:(NSString *)path {
    // 1.判断文件还是目录
    NSFileManager *fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {
        // 2.判断是不是目录
        if (isDir) {
            NSArray * dirArray = [fileManger contentsOfDirectoryAtPath:path error:nil];
            NSString * subPath = nil;
                for (NSString * str in dirArray) {
                    subPath  = [path stringByAppendingPathComponent:str];
                    BOOL issubDir = NO;
                    [fileManger fileExistsAtPath:subPath isDirectory:&issubDir];
                    [self gt_deleteFiles:subPath];
                }
        } else {
            NSLog(@"%@",path);
            [fileManger removeItemAtPath:path error:nil];
        }
    } else {
        NSLog(@"TaoLi 你打印的是目录或者不存在");
    }
}



@end