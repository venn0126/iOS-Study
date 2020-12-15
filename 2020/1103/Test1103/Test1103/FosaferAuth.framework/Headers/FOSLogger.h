//
//  FOSLogger.h
//  Fosafer
//
//  Created by Fosafer on 8/7/15.
//  Copyright (c) 2015 Fosafer Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FOSLogDebug(fmt, ...) [FOSLogger logDebug:[NSString stringWithFormat:@"%s:%d " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__]]
#define FOSLogError(fmt, ...) [FOSLogger logError:[NSString stringWithFormat:@"%s:%d " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__]]
#define FOSLogDebugWithClass(fmt, ...) [FOSLogger logDebug:[NSString stringWithFormat:@"%@ %s:%d " fmt, [[self class] description], __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__]]
#define FOSLogErrorWithClass(fmt, ...) [FOSLogger logError:[NSString stringWithFormat:@"%@ %s:%d " fmt, [[self class] description], __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__]]

typedef NS_OPTIONS(NSInteger, FOSLogLevel) {
    FOS_LOG_OFF = 0,
    FOS_LOG_ERROR = 1,
    FOS_LOG_WARN = 2,
    FOS_LOG_INFO = 3,
    FOS_LOG_DEBUG = 4,
    FOS_LOG_VERBOSE = 5,
};

@interface FOSLogger : NSObject

/**
 * @brief 设置logLevel
 *
 * @param logLevel
 *            日志级别
 */
+ (void)setLogLevel:(FOSLogLevel)logLevel;

/**
 * @brief 设置是否写日志文件
 *
 * @param logToFile
 *            是否写日志文件
 */
+ (void)logToFile:(BOOL)logToFile;

/**
 * @brief 设置是否写数据文件（注：开启后将会降低运行速度）
 *
 * @param flag
 *            是否写数据文件
 */
+ (void)setWriteDataToFile:(BOOL)flag;

/**
 * @return flag
 *            是否写数据文件
 */
+ (BOOL)shouldWriteDataToFile;

/**
 * @brief 当日志级别>=FOS_LOG_DEBUG时输出日志
 *
 * @param logMessage
 *            日志信息
 */
+ (void)logDebug:(NSString *)logMessage;

/**
 * @brief 当日志级别>=FOS_LOG_ERROR时输出日志
 *
 * @param logMessage
 *            日志信息
 */
+ (void)logError:(NSString *)logMessage;

/**
写活体日志到沙盒目录，为了上传到服务器
 @param logName 日志名字
 */

+ (void)writeAliveLog:(NSString *)logName logData:(NSData *)logData;

+ (void)clearAliveDirectory;

@end
