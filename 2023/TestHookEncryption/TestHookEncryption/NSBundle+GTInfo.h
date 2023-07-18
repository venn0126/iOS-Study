//
//  NSBundle+GTInfo.h
//  TestHookEncryption
//
//  Created by Augus on 2023/7/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (GTInfo)

/// 获取当前工程下自己创建的所有类
+ (NSArray <Class> *)gt_bundleOwnClassInfo;


/// 获取当前工程下所有类
+ (NSArray <Class> *)gt_bundleAllClassInfo;


/// 获取当前工程下自己创建的所有类名
+ (NSArray <NSString *> *)gt_bundleOwnClassString;


/// 获取当前工程下所有类名
+ (NSArray <NSString *> *)gt_bundleAllClassString;

/// 获取当前某些不包含系统的类名
+ (NSArray <NSString *> *)gt_bundleExceptSystemClassString;

@end

NS_ASSUME_NONNULL_END
