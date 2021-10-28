//
//  DMS_MKAIDBusinessSDK.h
//  BaoTouDemo
//
//  Created by DMS on 2019/10/24.
//  Copyright © 2019 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DMS_MKAIDBusinessSDK : NSObject

/**
 *  回调block
 *
 *  @param data 返回的数据
 *  @param result 错误码 （参考DMS_AID_SDK_errorInfo方法）
 */
typedef void(^DMS_AID_Business_ResultBlock)(id data ,NSString *result);
#pragma mark -------------------主程序接口----------------------------------
/**
 * @brief 单列
 * @author  wangzhenxin
 *
 */
+(DMS_MKAIDBusinessSDK *)DMS_AID_BUSS_sharedManager;
/**
* @brief 获取设备识别功能是否开启
* @author  wangzhenxin
* @return yes打开，no关闭
*
*/
-(BOOL)DMS_AID_BUSS_BioStatus;
/**
* @brief 设备指纹活人脸检查开关（启动设备认证功能调用）
* @author  wangzhenxin
* @param openBio yes打开，no关闭（前提设备认证已开启则可以关闭）
* @param pin pin码
* @param resultBlock 回调black
*
*/
-(void)DMS_AID_BUSS_SwitchBio:(BOOL)openBio withPin:(NSString *)pin withBlack:(DMS_AID_Business_ResultBlock)resultBlock;
/**
* @brief 获取版本编号
* @author  wangzhenxin
* @return 版本编号  如：1.0.1
*
*/
-(NSString *)getSdkVersion;

/**
 * @brief 初始化（启动app调用）
 * @author  wangzhenxin
 * @param oid 机构id（sdk授权颁发）(必填)
 * @param aid appid（sdk授权颁发）(必填)
 * @param appID 应用ID（sdk授权颁发）(必填)
 * @param appProperty 应用属性 (选填)
 * @param userID 用户ID (选填)
 * @param cUrl ctid地址 (必填)
 * @param ahttp aRA地址 (必填)
 * @return int 错误标记位
 */
-(NSDictionary *)sdkInit:(NSString *)oid
                 withAId:(NSString *)aid
               withAppID:(NSString *)appID
         withAppProperty:(NSString *)appProperty
              withUserID:(NSString *)userID
             withCTIDUrl:(NSString *)cUrl
             withAIDHttp:(NSString *)ahttp;

#pragma mark -------------------网证接口----------------------------------------
/**
* @brief   网证下载 (0x14)
* @author  wangzhenxin
* @param faceData 人脸数据base64(必填)
* @param name 身份证名字(必填)
* @param icard 身份证号码(必填)
*
*/
-(void)ctidDownload:(NSString *)name
      withIDCardNum:(NSString *)icard
       withFaceData:(NSString *)faceData
        resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;
/**
* @brief   网证开通下载 (0x13)
* @author  wangzhenxin
* @param faceData 人脸数据base64(必填)
* @param name 身份证名字(必填)
* @param icard 身份证号码(必填)
*
*/
-(void)ctidEnrollmentAndDownload:(NSString *)name
                   withIDCardNum:(NSString *)icard
                    withFaceData:(NSString *)faceData
                     resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;

/**
* @brief   网证开通发送验证码
* @author  wangzhenxin
* @param phone  手机号(必填)
* @param bsn 业务流水号(开通下载0x13返回)(必填)
*
*
*/
-(void)ctidEnrollmentSendVCode:(NSString *)phone 
                       withBsn:(NSString *)bsn
                   resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;

/**
* @brief 网证开通验证验证码
* @author  wangzhenxin
* @param bsn 业务流水号(发送验证码返回)(必填)
* @param phone 手机号(必填)
* @param vCode 验证码(必填)
*
*/
-(void)ctidEnrollmentVerifyVCode:(NSString *)phone
                         withBsn:(NSString *)bsn
                     withSmsCode:(NSString *)vCode
                 withResultBlock:(DMS_AID_Business_ResultBlock)resultBlock;
/**
* @brief   网证+人像认证
* @author  wangzhenxin
* @param faceData 人脸数据base64(必填)
*
*/
-(void)authByCtid:(NSString *)faceData withResultBlock:(DMS_AID_Business_ResultBlock)resultBlock;
/**
* @brief   当前用户是否有网证
* @author  wangzhenxin
* @return 0有网证 1无网证
*
*/
-(int)isHasCtid;
/**
* @brief   获取网证信息(网证编号，到期时间)
* @author  wangzhenxin
*
*
*/
-(NSDictionary *)getCtidMessage;

/**
 * @brief 获取二维码赋码数据
 * @author  wangzhenxin
 * @param resultBlock 回调block 返回base64 UIimage数据
 *
 */
-(void)getCtidQrCode:(DMS_AID_Business_ResultBlock)resultBlock;
/**
 * @brief 网证二维码+人像认证
 * @author  wangzhenxin
 * @param qrcode 通过苹果自带相机 扫描二维码图片获得的字符串 （注意：通过微信扫描出的字符串较短，不正确）
 * @param faceData 人像BASE64数据
 * @param resultBlock 回调block
 *
 */
-(void)ctidQrCodeVerify:(NSString *)qrcode
           withFaceData:(NSString *)faceData
            resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;

#pragma mark ------------------AID可信标识接口(网证)--------——---------------

/**
* @brief  AID可信标识申请(已下载网证)
* @author  wangzhenxin
* @param ctidDict ctid信息集合{bsn =流水号;sdkBid = bid标识;token = 标识;}
* @param pin pin码
* @param resultBlock 成功block(必填)
*
*/
-(void)applyAidByCtid:(NSDictionary *)ctidDict
              withPIN:(NSString *)pin
          resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;

/**
* @brief  重置PIN码(已下载网证)
* @author  wangzhenxin
* @param pin pin码 (必填)
* @param resultBlock 成功block(必填)
*
*/
-(void)pinResetByCtid:(NSString *)pin
         withFaceData:(NSString *)faceData
          resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;

/**
* @brief 下载AID信息
* @author  wangzhenxin
* @param pin PIN码（finger为no必传）
* @param resultBlock 成功block(必填)
*/
-(void)dmsAidDownload:(NSString *)pin
                   resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;
/**
* @brief 返回申请状态
* @author  wangzhenxin
* @return int 设置成功标记 0:未申请 1:未下载 2:已下载
*/
-(int)getAidStatus;
/**
* @brief 清除缓存数据
* @author  wangzhenxin
* @return 处理标记位
*/
-(BOOL)clearIKI;
/**
* @brief 获取AID可信标识详细信息
* @author  wangzhenxin
* @return AID可信标识详细信息
*/
-(NSDictionary *)getAidCertInfo;
/**
* @brief 获取AID可信标识文件以base64 string输出
* @author  wangzhenxin
* @return AID可信标识详细信息
*/
-(NSDictionary *)getAidCertB64;
#pragma mark ------------------AID处理接口(两项数据)--------——---------------
/**
 * @brief AID申请(不带ctid)
 * @author  wangzhenxin
 * @param pin pin码(必填)
 * @param faceData 人脸数据base64(必填)
 * @param name 身份证名字(必填)
 * @param icard 身份证号码(必填)
 * @param resultBlock 成功block(必填)
 *
 *
 */
-(void)applyAidIdcard:(NSString *)name
        withIDCardNum:(NSString *)icard
         withFaceData:(NSString *)faceData
              withPIN:(NSString *)pin
          resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;

/**
 * @brief 二项认证或二项+人像认证
 * @author  wangzhenxin
 * @param faceData 人脸数据base64
 * @param name 身份证名字(必填)
 * @param icard 身份证号码(必填)
 * @param resultBlock 成功block(必填)
 *
 *
 */
-(void)idAuth:(NSString *)name
withIDCardNum:(NSString *)icard
 withFaceData:(NSString *)faceData
  resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;

/**
* @brief 二项+人像认证重置AID可信标识PIN码
* @author  wangzhenxin
* @param name 身份证名字(必填)
* @param icard 身份证号码(必填)
* @param pin pin码(必填)
* @param faceData 人脸数据base64(必填)
* @param resultBlock 成功block
*
*
*/
-(void)resetPinIdcard:(NSString *)name
        withIDCardNum:(NSString *)icard
         withFaceData:(NSString *)faceData
              withPIN:(NSString *)pin
          resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;
#pragma mark ------------------业务处理接口----------------------------------
/**
 * @brief AID数字签名
 * @author  wangzhenxin
 * @param pin pin码 （和人脸数据对应，使用PIN码数据，人脸数据传空）
 * @param inData 签名明文(必填)
 * @param resultBlock 成功block
 */
-(void )signData:(NSString *)inData withPIN:(NSString *)pin resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;
/**
 * @brief 数字签名验签
 * @author  wangzhenxin
 * @param inData 签名明文(必填)
 * @param signResult 签名值(必填)
 * @param ikiCer 证书数据，自签自验，可传NULL
 * @param resultBlock 成功block(必填)
 */
-(void)verifySignedData:(NSString *)inData withSignResult:(NSString *)signResult withikiCer:(NSData *)ikiCer resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;

/**
 * @brief 数字签名验签并验可信标识有效性
 * @author  wangzhenxin
 * @param inData 签名明文(必填)
 * @param signResult 签名值(必填)
 * @param ikiCer 证书数据，自签自验，可传NULL
 * @param resultBlock 成功block(必填)
 */

-(void)verifySignedDataOISP:(NSString *)inData withSignResult:(NSString *)signResult withikiCer:(NSData *)ikiCer resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;

/**
 * @brief AID 消息签名
 * @author  wangzhenxin
 * @param pin pin码 （和人脸数据对应，使用PIN码数据，人脸数据传空）
 * @param inData 消息签名原文数据(必填)
 * @param resultBlock 成功block
 */
-(void)signMessage:(NSString *)inData withPIN:(NSString *)pin resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;
/**
 * @brief 消息签名验签
 * @author  wangzhenxin
 * @param messageData 消息签名明文数据(必填)
 * @param inData 消息签名数据(必填)
 * @param ikiCer 证书数据，自签自验，可传NULL
 * @param resultBlock 成功block(必填)
 */
-(void)verifySignedMessage:(NSString *)messageData withMKInData:(NSString *)inData withikiCer:(NSData *)ikiCer resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;
/**
* @brief   消息签名验签并验OISP
* @author  wangzhenxin
* @param messageData 消息签名明文数据(必填)
* @param inData 消息签名数据(必填)
* @param ikiCer 证书数据，自签自验，可传NULL
* @param resultBlock 成功block(必填)
*/
-(void)verifySignedMessageOISP:(NSString *)messageData withMKInData:(NSString *)inData withikiCer:(NSData *)ikiCer resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;
/**
 * @brief SM2加密
 * @author  wangzhenxin
 * @param inData 明文(必填)
 * @param pin pin码 （和人脸数据对应，使用PIN码数据，人脸数据传空）
 * @param ikiCer 证书数据，自签自验，可传NULL
 * @param resultBlock 成功block
 */
-(void)encrypt:(NSString *)inData withPin:(NSString *)pin withikiCer:(NSData *)ikiCer resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;

/**
 * @brief SM2解密
 * @author  wangzhenxin
 * @param pin pin码 （和人脸数据对应，使用PIN码数据，人脸数据传空）
 * @param inData 加密数据(必填)
 * @param resultBlock 成功block(必填)
 */
-(void)decrypt:(NSString *)pin withMKInData:(NSString *)inData resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;
/**
 * @brief 数字信封加密
 * @author  wangzhenxin
 * @param inData 明文(必填)
 * @param pin pin码 （和人脸数据对应，使用PIN码数据，人脸数据传空）
 * @param ikiCer 证书数据，自签自验，可传NULL
 * @param resultBlock 成功block(必填)
 */
-(void)encryptEnvelop:(NSString *)inData withPin:(NSString *)pin withikiCer:(NSData *)ikiCer resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;
/**
 * @brief 数字信封解密
 * @author  wangzhenxin
 * @param pin pin码 （和人脸数据对应，使用PIN码数据，人脸数据传空）
 * @param inData 数字信封数据(必填)
 * @param resultBlock 成功block(必填)
 */
-(void)decryptEnvelop:(NSString *)pin withInData:(NSString *)inData resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;

#pragma mark ------------------业务接口:网证+人像加解密PIN码功能----------------------------------
/**
* @brief 网证+人像解密PIN码并数字签名
* @author  wangzhenxin
* @param inData 签名明文(必填)
* @param faceData 人脸数据(必填)
* @param resultBlock 成功block
*/
-(void)signDataByFace:(NSString *)inData withFaceData:(NSString *)faceData resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;
/**
 * @brief 网证+人像解密PIN码并消息签名
 * @author  wangzhenxin
 * @param inData 消息签名原文数据(必填)
 * @param faceData 人脸数据(必填)
 * @param resultBlock 成功block
 */
-(void)signMessageByFace:(NSString *)inData withFaceData:(NSString *)faceData resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;

/**
 * @brief 网证+人像解密PIN码并SM2加密
 * @author  wangzhenxin
 * @param inData 明文(必填)
 * @param faceData 人脸数据(必填)
 * @param ikiCer 证书数据，自签自验，可传NULL
 * @param resultBlock 成功block
 */
-(void)encryptByFace:(NSString *)inData withFaceData:(NSString *)faceData withikiCer:(NSData *)ikiCer resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;

/**
 * @brief 网证+人像解密PIN码并SM2解密
 * @author  wangzhenxin
 * @param faceData 人脸数据(必填)
 * @param inData 加密数据(必填)
 * @param resultBlock 成功block(必填)
 */
-(void)decryptByFace:(NSString *)inData withFaceData:(NSString *)faceData resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;
/**
 * @brief 网证+人像解密PIN码并数字信封加密
 * @author  wangzhenxin
 * @param inData 明文(必填)
 * @param faceData 人脸数据(必填)
 * @param resultBlock 成功block(必填)
 * @param ikiCer 证书数据，自签自验，可传NULL
 */
-(void)encryptEnvelopByFace:(NSString *)inData withFaceData:(NSString *)faceData withikiCer:(NSData *)ikiCer resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;
/**
 * @brief 网证+人像解密PIN码并数字信封解密
 * @author  wangzhenxin
 * @param inData 数字信封数据(必填)
 * @param faceData 人脸数据(必填)
 * @param resultBlock 成功block(必填)
 */
-(void)decryptEnvelopByFace:(NSString *)inData withFaceData:(NSString *)faceData resultBlock:(DMS_AID_Business_ResultBlock)resultBlock;

#pragma mark ------------------错误信息编码解析-------------------------
/**
 * @brief 根据错误编码获取错误信息
 * @author  wangzhenxin
 * @param errorCode 错误编码
 * @return NSString 错误信息
 * 0 成功
 * 1 失败
 * 2 身份数据加密失败
 * 4 网络异常
 * 6001 初始化失败
 * 6002 设备信息设置失败
 * 6003 平台地址设置失败
 * 6004 随机数生成失败
 * 6005 获取随机源失败
 * 6006  随机源数据处理失败
 * 6007  输入的PIN码错误
 * 6008  PIN码上锁
 * 6009  授权失败
 * 6010  准备数据失败
 * 6011  RA地址设置失败
 * 6012  身份信息设置失败
 * 6013  非安全设备
 * 6014  参数设置有误
 * 6015 数据缓存失败
 * 6016 数据组装异常
 * 6017 未申请
 * 6018 未下载
 * 6019 已下载
 * 6020 AID可信标识未申请或数据丢失，请重新申请AID可信标识
 * 6021 网证数据不存在
 * 6022 PIN码解密失败
 * 6023 PIN码加密失败
 * 6024 缓存密码获取失败
 * 9001 网证过期，重新下载
 * 9002 身份证过期重新下载
 * 9003 网证已被注销
 * 9004 网证已被冻结
 * 9005 网证认证请求参数有误
 * 9006 PID生成失败
 * 9100 人像比对失败
 * 9101人像数据有误
 * 9102人像比对结果，非同一人
 * 9200 网证下载失败
 * 9201 认证码错误
 * 9202 未开通网证或身份信息错误
 * 9203 网证不在库中
 * 9300 二维码赋码失败
 * 9301 网证不存在
 * 9302 网证已失效
 * 9400 身份信息比对失败
 * 9401 身份信息无效
 * 9402 参数错误
 * 9403 认证接口调用异常
 * 9404 访问次数耗尽
 * 30001 设备未设置指纹或面容ID
 * 30002 设备指纹或面容ID验证不通过
 * 30003 关闭设备指纹或面容ID验证
 * 01A12001 可信标识还未下发，请稍后再试
 * 01A12007 标识状态异常不能进行申请/恢复
 * 01A1200C 可信标识申请失败
 * 01A1400C AID可信标识过期或失效，请重新申请AID可信标识
 * 01A1400D AID可信标识过期或失效，请重新申请AID可信标识
 * 01A12008 AID可信标识过期或失效，请重新申请AID可信标识
 * 01A12009 AID可信标识过期或失效，请重新申请AID可信标识
 * -------------------------------------------------AA开头错误码，为内部解析错误---------------------------
 * AA000001 未知错误
 * AA000002 PIN码错误
 * AA000003 获取服务随机数失败
 * AA000004 获取IP地址失败
 * AA000005 ASN1解密失败
 * AA000006 ASN1加密失败
 * AA000007 base64解密失败
 * AA000008 base64加密失败
 * AA000009 sm2加密失败
 * AA000010 sm2解密失败
 * AA000011 sm2签名失败
 * AA000012 sm2验签失败
 * AA000013 数据存储失败
 * AA000014 打开文件失败
 * AA000015 写入文件失败
 * AA000016 读取文件失败
 * AA000017 获取服务器数据失败
 * AA000018 服务器数据无效
 * AA000019 sm4加密失败
 * AA000020 sm4解密失败
 * AA000021 sm3哈希处理失败
 * AA000022 数据无效
 * AA000029 授权失败
 * AA000032 证书验证失败
 * AA000033 证书无效
 * AA000034 用户证书时间错误
 * AA000035 Json解析失败
 * AA000036 获取Json数据失败
 * AA000043 设置地址有误
 */
@end

NS_ASSUME_NONNULL_END
