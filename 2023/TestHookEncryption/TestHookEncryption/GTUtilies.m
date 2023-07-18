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

@end
