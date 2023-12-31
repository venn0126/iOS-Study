//
//  SNSecurityHelper.h
//  TestHookEncryption
//
//  Created by Augus on 2023/12/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern void callPtraceOfDisambleCode(void);

@interface SNSecurityHelper : NSObject


/// 是否被调试
+ (BOOL)isDebugged;

/// 拒绝调试
+ (void)denyDebugger;

/// 是否有断点
+ (BOOL)hasWatchpoint;


/// 是否是越狱设备
+ (BOOL)checkRootFlag;

/// 是否在运行时进行了钩子
/// - Parameters:
///   - dyldWhiteList: 二进制的白名单数组
///   - detectionClass: 检测的类
///   - selector: 检测的方法
///   - isClassMethod: 是否是类方法
+ (BOOL)amIRuntimeHookWithDyldWhiteList:(NSArray<NSString *> *)dyldWhiteList
                      detectionClass:(Class)detectionClass
                            selector:(SEL)selector
                          isClassMethod:(BOOL)isClassMethod;


@end

NS_ASSUME_NONNULL_END
