//
//  GTAppTool.h
//  GTiTools
//
//  Created by Augus on 2022/12/1.
//

#import <Foundation/Foundation.h>
#import "GTApp.h"

typedef enum : NSUInteger {
    /// 下载的所有app
    GTListAppsTypeUser,
    /// 未脱壳的app
    GTListAppsTypeUserEncrypted,
    /// 已脱壳的app
    GTListAppsTypeUserDecrypted,
    /// 系统app
    GTListAppsTypeSystem
} GTListAppsType;



NS_ASSUME_NONNULL_BEGIN

@interface GTAppTool : NSObject

+ (void)listUserAppsWithType:(GTListAppsType)type regex:(NSString *)regex operation:(void (^)(NSArray *apps))operation;

@end

NS_ASSUME_NONNULL_END
