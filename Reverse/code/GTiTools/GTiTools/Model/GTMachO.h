//
//  GTMachO.h
//  GTiTools
//
//  Created by Augus on 2022/12/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTMachO : NSObject

/// 架构名
@property (copy, nonatomic) NSString *architecture;

/// 是否被加密
@property (assign, nonatomic, getter=isEncrypted) BOOL encrypted;

/// 是否是胖文件（armv7，armv7s，arm64混合）
@property (assign, nonatomic, getter=isFat) BOOL fat;

/// MachO文件的组成部分（Header，Load commands，data等）
@property (strong, nonatomic) NSArray *machOs;

+ (instancetype)machOWithFileHandle:(NSFileHandle *)handle;
- (instancetype)initWithFileHandle:(NSFileHandle *)handle;

@end

NS_ASSUME_NONNULL_END
