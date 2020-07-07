//
//  ZIMResponse.h
//  ZolozIdentityManager
//
//  Created by yukun.tyk on 28/06/2017.
//  Copyright © 2017 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ZIMResponseCode) {
    ZIMResponseSuccess  = 1000,     //采集成功并且服务端成功(人脸比对成功，或者证件宝服务端OCR/质量检测成功)[zim不会弹框处理]
    ZIMInternalError    = 1001,     //用户被动退出(极简核身没有取到协议、toyger启动失败、协议解析失败)[zim不会弹框处理]
    ZIMInterrupt        = 1003,     //用户主动退出(无相机权限、超时、用户取消)[zim会弹框处理]
    ZIMNetworkfail      = 2002,     //网络失败(标准zim流程，请求协议错误)[zim不会弹框处理]
    ZIMResponseFail     = 2006,     //服务端validate失败(人脸比对失败或者证件宝OCR/质量检测失败)[zim不会弹框处理]
};

@interface ZIMResponse : NSObject

@property(nonatomic, assign, readonly)ZIMResponseCode code;
@property(nonatomic, assign, readonly)ZIMResponseCode retCode;
@property(nonatomic, copy, readonly)NSString *reason;
@property(nonatomic, copy, readonly)NSString *retCodeSub;
@property(nonatomic, copy, readonly)NSString *retMessageSub;
@property(nonatomic, strong, readonly)NSDictionary *extInfo;
@property(nonatomic, strong, readonly)NSString * bizData;



-(instancetype)initWithResponseCode:(ZIMResponseCode) code
                            retCode:(ZIMResponseCode) retCode
                         retCodeSub:(NSString *) retCodeSub
                      retMessageSub:(NSString *) retMessageSub
                             reason:(NSString *) reason
                           extParam:(NSDictionary *) extInfo
                            bizData:(NSString *) bizData;

@end
