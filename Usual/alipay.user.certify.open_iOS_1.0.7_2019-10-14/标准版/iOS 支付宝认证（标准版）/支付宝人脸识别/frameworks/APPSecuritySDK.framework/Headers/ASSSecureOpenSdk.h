//
//  ASSSecureOpenSdk.h
//  APPSecuritySDK
//
//  Created by msq on 16/6/1.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @typedef ASSStatusCode
 
 Possible return codes
 @constant ASSStatusCodeOk                       Completed, No errors
 @constant ASSStatusCodeInvalidParam             input param invalid
 @constant ASSStatusCodeAppNameNil               appName is nil
 @constant ASSStatusCodeAppKeyNil                appKeyClient is nil
 @constant ASSStatusCodeConnectionError          network connection failure
 */
typedef NS_ENUM(NSInteger, ASSStatusCode)
{
    ASSStatusCodeOk = 0,
    ASSStatusCodeInvalidParam,
    ASSStatusCodeAppNameNil,
    ASSStatusCodeAppKeyNil,
    ASSStatusCodeConnectionError,
    
};

typedef void(^ASSSecureSdkCallbackOpen)(NSString* token, int errorCode);

@interface ASSSecureOpenSdk : NSObject

/*
 异步初始化vkeyid，推荐在app启动时和收银台页面加载时调用，SDK内部会根据时间戳和设备信息进行判断是否需要进行网络请求，无线程要求
 @param appName      应用名称
 
 @param appKeyClient 应用客户端密钥
 
 @param callback     初始化完成后的结果回调，以Token作为参数
 
 */
+ (void)initToken:(NSString *)appName appKeyClient:(NSString *)appKeyClient callback:(ASSSecureSdkCallbackOpen)callback;

@end
