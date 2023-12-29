//
//  SNSecurityHelper.h
//  TestHookEncryption
//
//  Created by Augus on 2023/12/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNSecurityHelper : NSObject


+ (BOOL)isDebugged;

+ (void)denyDebugger;

+ (BOOL)hasWatchpoint;

+ (BOOL)checkRootFlag;



@end

NS_ASSUME_NONNULL_END
