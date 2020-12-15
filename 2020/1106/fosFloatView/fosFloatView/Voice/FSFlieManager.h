//
//  FSFlieManager.h
//  fosFloatView
//
//  Created by Augus on 2020/11/10.
//

#import <Foundation/Foundation.h>
#import "FSGlobal.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSFlieManager : NSObject

singtonInterface;
// 文件夹路径
+ (NSString *)FSFolderPath;
// 变声保存的文件路径
+ (NSString *)soundTouchSavePathWithFileName:(NSString *)fileName;
// 音频文件保存的整个路径
+ (NSString *)filePath;
// 删除文件
+ (void)removeFile:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
