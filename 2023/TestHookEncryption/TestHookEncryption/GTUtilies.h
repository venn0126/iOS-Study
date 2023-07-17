//
//  GTUtilies.h
//  TestHookEncryption
//
//  Created by Augus on 2023/7/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTUtilies : NSObject


/// 解析，下载到沙盒
/// - Parameter name: 头文件名
+ (void)serviceHeaderName:(NSString *)name;

+ (BOOL)parseClassHeaderWritePath:(nullable NSString *)path withName:(NSString *)name fileDataString:(NSString *)string;

+ (BOOL)parseClassHeaderWritePath:(nullable NSString *)path withName:(NSString *)name fileData:(NSData *)data;

+ (BOOL)parseClassHeaderWithName:(NSString *)name fileData:(NSData *)data;

+ (BOOL)parseClassHeaderWithName:(NSString *)name fileDataString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
