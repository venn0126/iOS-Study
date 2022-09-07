//
//  SNAugusSiriHandler.h
//  TestSiriDemo
//
//  Created by Augus on 2022/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNAugusSiriHandler : NSObject


/// 询问用户siri权限，是否允许访问
+ (void)askUserSiriPermissions;

@end

NS_ASSUME_NONNULL_END
