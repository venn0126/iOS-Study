//
//  GTFileTools.h
//  TestObjcSome
//
//  Created by Augus on 2023/1/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/// 数据存储位置
typedef enum : NSUInteger {
    GTFileStoreTypeDocument = 1 << 0,
    GTFileStoreTypeCache = 1 << 1,
    GTFileStoreTypeLibrary = 1 << 2,
    GTFileStoreTypeTemp = 1 << 3,
} GTFileStoreType;



@interface GTFileTools : NSObject

/// 获取document路径
+ (NSString *)gt_DocumentPath;

/// 获取cache路径
+ (NSString *)gt_CachePath;

/// 获取Library路径
+ (NSString *)gt_LibraryPath;

/// 获取临时路径
+ (NSString *)gt_TempPath;

/// 文件是否存在
+ (BOOL)gt_fileIsExist:(NSString *)path;


/// 创建目录下文件
/// - Parameters:
///   - fileName: 文件名
///   - type: 存储位置
///   - data: 存储数据
+ (NSString *)gt_createFileName:(NSString *)fileName type:(GTFileStoreType)type contents:(NSData *)contents;


/// 写数据到文件
/// - Parameters:
///   - filePath: 文件路径
///   - data: 数据内容
+ (BOOL)gt_writeToFilePath:(NSString *)filePath contents:(NSData *)contents;


+ (NSString *)createFilePathForRootPath:(NSString *)rootPath directoryName:(NSString *)directoryName;

/// 遍历某个文件夹下的所有文件，查看是否有符合的文件
/// - Parameters:
///   - directory: 某个遍历的文件夹
///   - fileName: 需要查找的文件名
+ (BOOL)enumerateDirectory:(nullable NSString *)directory containsFileName:(NSString *)fileName;

+ (BOOL)enumerateDirectoryContainsFileName:(NSString *)fileName;



@end

NS_ASSUME_NONNULL_END
