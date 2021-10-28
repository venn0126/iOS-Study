//
//  CTID_Verification.h
//  CTID_Verification
//
//  Created by 万启鹏 on 2020/6/17.
//  Copyright © 2020 万启鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CTIDReq;

@interface CtidVerifySdk : NSObject

#pragma - mark 对外Block
typedef void(^ResultDictBlock)(NSDictionary *resultDict);
@property (nonatomic, copy) ResultDictBlock resultDictBlock;     // 获取加密数据

/// 0 获取控件版本号
+(NSString *)getAuthIDCardDataVer;

/// 1 仅初始化此类
- (instancetype)init;

/// 2 获取网证开通数据
/// @param IdCardData CTIDReq对象：需包含 randomNumber、organizeID、appID
- (NSDictionary *)getEnrollmentIDCardData:(CTIDReq *)IdCardData;

/// 3 获取身份认证数据
/// @param IdCardData CTIDReq对象：需包含 randomNumber、organizeID、appID、code
- (void)getAuthIDCardData:(CTIDReq *)IdCardData;

/// 4 获取二维码赋码/验码申请数据
/// @param ApplyData CTIDReq对象：需包含organizeID、appID、
-(NSDictionary *)getApplyData:(CTIDReq *)ApplyData;

/// 5 获取二维码赋码数据
/// @param ReqCodeData CTIDReq对象：需包含organizeID、appID、
-(NSDictionary *)getReqQRCodeData:(CTIDReq *)ReqCodeData;

/// 6 获取二维码验码数据
/// @param QRCodeData CTIDReq对象：需包含organizeID、appID、
-(NSDictionary *)getAuthQRCodeData:(CTIDReq *)QRCodeData;


/// 7 生成二维码图片
/// @param ImgStreamStr 赋码请求获取到的imgStream
/// @param width 赋码请求获取到的width
/// @param frame  自定义的图片frame
+(UIImageView *)creatQRCodeImageWithImgStreamStr:(NSString*)ImgStreamStr width:(NSInteger)width  withFrame:(CGRect)frame;


/// 8 用于获取凭证编号和有效期
/// @param ctidStr 用于获取凭证编号和有效期
-(NSDictionary *)getCtidNum:(NSString *)ctidStr;


///  9 在CTID APP中获取网证
/// @param urlScheme 你的urlScheme
/// @param appName 你的应用appName
+(void)getLocalCtidWithUrlScheme:(NSString *)urlScheme appName:(NSString *)appName;





@end

