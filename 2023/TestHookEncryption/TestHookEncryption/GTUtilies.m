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

#define kGuanHeaderFileDirectory @"/guan/Headers/"


@implementation GTUtilies

+ (void)load {
    
    NSLog(@"GTUtilies load %@",[self class]);
}


+ (void)serviceHeaderName:(NSString *)name {
    
    Class cls = objc_getClass([name UTF8String]);
    GTClassModel *ortho = [GTClassModel modelWithClass:cls];
    NSString *headerString = [ortho linesWithComments:NO synthesizeStrip:YES];
    NSLog(@"augus %@",headerString);
    
    BOOL isWrite = [GTUtilies parseClassHeaderWithName:name fileDataString:headerString];
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




@end
