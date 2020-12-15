//
//  FOSFosafer.h
//  Fosafer
//
//  Created by Fosafer on 7/31/15.
//  Copyright (c) 2015 Fosafer Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^FOSCompareToolCallBack)(id result, NSError *error);

/** 认证类型 */
typedef enum TAuthType {
    ESpeaker = 1, // 仅声纹
    EFace, // 仅人脸
    ESpeakerAndFace // 声纹人脸复合
} TAuthType;

/** 参数设置key */
/** 创建应用所生成APPKEY，NSString */
FOUNDATION_EXPORT NSString * const FOSAFER_APPKEY;
/**APP_ID，NSString */
FOUNDATION_EXPORT NSString * const FOS_KEY_APP_ID;
/** 服务地址，NSString */
FOUNDATION_EXPORT NSString * const FOS_KEY_SERVER;
/** 用户ID，NSString */
FOUNDATION_EXPORT NSString * const FOS_KEY_USER_ID;
/** 组ID（从一组用户中辨识身份时使用），NSString */
FOUNDATION_EXPORT NSString * const FOS_KEY_GROUP_NAME;
/** 在注册阶段，检查组内是否存在重复（非常相似）的模型，如果存在则禁止注册并返回错误，通过`FOS_KEY_GROUP_ID`指定组 */
FOUNDATION_EXPORT NSString * const FOS_KEY_CHECK_DUP;
/** 人脸对象（如人脸框）标记颜色，UIColor */
FOUNDATION_EXPORT NSString * const FOS_KEY_FACE_OBJECT_COLOR;
/** 是否进行动作活体检测 */
FOUNDATION_EXPORT NSString * const FOS_KEY_ENABLE_ALIVE_DETECT;
/** 交互活体检测类型，
 0 随机一种动作 眨眼 左摇 又摇 点头
 3 眨眼+左摇 5眨眼+右摇 9眨眼+点头
 11 眨眼+左摇+点头 13眨眼+右摇+点头
 */
FOUNDATION_EXPORT NSString * const FOS_INTERACTIVE_ALIVE_DETECT_TYPE;
/** 当前使用SDK类型，默认为交互活体检测，其余待定... */
FOUNDATION_EXPORT NSString * const FOS_KEY_SDK_TYPE;
/** 由服务端分发的key，用于检验用户合法性 */
FOUNDATION_EXPORT NSString * const FOS_KEY_SDK_LICENSE;
/** 由客户指定，服务端生成 license检查校验的bundleId */
FOUNDATION_EXPORT NSString * const FOS_KEY_LICENSE_BUNDLEID;
/** 实名认证私钥密码 */
FOUNDATION_EXPORT NSString * const FOS_KEY_CER_PASSWORD;
/** 实名认证用户名称 */
FOUNDATION_EXPORT NSString * const FOS_KEY_NAME;
/** 实名认证身份证号码 */
FOUNDATION_EXPORT NSString * const FOS_KEY_CADR_NO;
/** 交互活体的有效区域 */
FOUNDATION_EXPORT NSString * const FOS_KEY_EFFECTIVE_AREA;
/** 预览图层的缩放，默认为1.0,范围0-1.0 */
FOUNDATION_EXPORT NSString * const FOS_CAMERA_PREVIEWLAYER_SCALE;
/** 相机位置，默认为前置，1为后置，2为前置*/
FOUNDATION_EXPORT NSString * const FOS_CAMERA_POSITION;
/** 本公司提供给商户的唯一编号*/
FOUNDATION_EXPORT NSString * const FOS_KEY_MEMBER_ID;
/** 本公司提供给商户的唯一终端号*/
FOUNDATION_EXPORT NSString * const FOS_KEY_TERMINAL_ID;
/** 客户端加密私钥密码*/
FOUNDATION_EXPORT NSString * const FOS_KEY_CER_PASSWORD;
/** 商户订单号*/
FOUNDATION_EXPORT NSString * const FOS_KEY_TRANS_ID;
/** 交易时间*/
FOUNDATION_EXPORT NSString * const FOS_KEY_TRADE_DATE;
/** 可选参数*/
FOUNDATION_EXPORT NSString * const FOS_KEY_OPT_PARAM;
/** 注册步数的下标*/
FOUNDATION_EXPORT NSString * const FOS_KEY_STEP;
/** 截取语音时长通知*/
FOUNDATION_EXPORT NSString * const FOS_KEY_SPEAKER_TIME_NOTIFICATION;
/** 保留字段,用于统计*/
FOUNDATION_EXPORT NSString * const FOS_KEY_OPTIONAL_TOKEN;
/** 图片的二进制数据，用户网络传输*/
FOUNDATION_EXPORT NSString * const FOS_KEY_IMAGE_DATA;
/** 视频帧的输出方向,用于OCR采集与识别*/
FOUNDATION_EXPORT NSString * const FOS_KEY_VIDEO_ORIENTATION;
/** 本地上传图片压缩预留参数,用于OCR采集与识别,不传入使用默认值*/
FOUNDATION_EXPORT NSString * const FOS_KEY_COMPRESS_WIDTH;
/** 是否进行图片检测*/
FOUNDATION_EXPORT NSString * const FOS_KEY_CARD_CHECK;
/** 身份证头像面:FRONT,国徽面:BACK*/
FOUNDATION_EXPORT NSString * const FOS_KEY_CARD_SIDE;
/** 云平台参数*/
FOUNDATION_EXPORT NSString * const FOS_KEY_MERCHANT_NO;
// 合同号
FOUNDATION_EXPORT NSString * const FOS_KEY_CONTRACT_ID;
// 产品信息
FOUNDATION_EXPORT NSString * const FOS_KEY_PRODUCT_INFO;
// check in code
FOUNDATION_EXPORT NSString * const FOS_KEY_CC;
// 签名数据
FOUNDATION_EXPORT NSString * const FOS_KEY_SIGN;
// 三项比对主机地址
FOUNDATION_EXPORT NSString * const FOS_KEY_HC_SERVER;
// 离线采集offLine
FOUNDATION_EXPORT NSString * const FOS_KEY_LINE;
// 区分不同组织
FOUNDATION_EXPORT NSString * const FOS_KEY_APP_NAME;
// oauth token
FOUNDATION_EXPORT NSString * const FOS_KEY_AUTHORIZATION;
// 指定采集张数
FOUNDATION_EXPORT NSString * const FOS_KEY_NUM_OF_FACE;



/** 服务响应的key */
/** 状态码 */
FOUNDATION_EXPORT NSString * const FOS_KEY_CODE;
/** 错误描述 */
FOUNDATION_EXPORT NSString * const FOS_KEY_ERROR;
/** 认证分数 */
FOUNDATION_EXPORT NSString * const FOS_KEY_SCORE;
/** 用户注册状态，0表示未注册，1表示声纹已注册，2表示人脸已注册，3表示声纹、人脸都已注册 */
FOUNDATION_EXPORT NSString * const FOS_KEY_STATUS;

/** 错误码 */
typedef NS_ENUM(NSInteger, FOS_ERROR_CODE) {
    FOS_ERROR_MODEL_EXISTS = 201, // 用户已注册
    FOS_ERROR_NO_SPEAKER_MODEL = 301, // 声纹模型不存在
    FOS_ERROR_DIGITS_NOT_MATCH = 202, // 数字内容不符
    FOS_ERROR_SPEAKER_NOT_PASS = 303, // 声纹认证不通过
    FOS_ERROR_WRONG_ARGS = 501, // 参数缺失
    FOS_ERROR_NO_FACE_MODEL = 603, // 人脸模型不存在
    FOS_ERROR_FACE_NOT_PASS = 604, // 人脸认证不通过
    FOS_ERROR_USER_DUPLICATE = 606, // 该用户与现存用户疑似
    FOS_ERROR_AUTH_NOT_PASS = 701, // 复合认证不通过
    FOS_ERROR_PARSE = 1001, // 没有解析到数据
    FOS_ERROR_KEY_NOT_FIND = 1002, // 服务器数据不完整
    FOS_ERROR_SESSION_ID_NOT_FIND = 1003, // 服务器数据不完整（没有session id）
    FOS_ERROR_TEXT_NOT_FIND = 1004, // 服务器数据不完整（没有text）
    FOS_ERROR_CODE_NOT_FIND = 1005, // 服务器数据不完整（没有code）
    FOS_ERROR_DIGITS_NOT_FIND = 1006, // 服务器数据不完整（没有digits）
    FOS_ERROR_BAD_JSON = 1007, // 服务器响应无法解析（无效JSON）
    FOS_ERROR_NO_DATA_SENT = 1008, // 没有发送数据
    FOS_ERROR_BUSY = 1009, // 引擎忙
    FOS_ERROR_CANCELED = 1010, // 已取消
    FOS_ERROR_UNKNOWN = 1011, // 未知错误
    FOS_ERROR_ILLEGAL_STATUS = 1012, //非法状态
    FOS_ERROR_LICENSE_STATUS = 1013, // 引擎license错误
    FOS_ERROR_NOT_PREPARED = 1102, // 未准备好，需要先调用相应的prepare方法
    FOS_ERROR_INIT_FAILED = 1103, // prepare失败，详细错误请查看error localizedDescription
    FOS_ERROR_RES_NOT_FOUND = 1201, // 没有找到资源文件
    FOS_ERROR_CONNECTION_TIMED_OUT = 2001, // 网络连接超时
    FOS_ERROR_CANNOT_CONNECT_TO_HOST = 2002, // 无法连接到服务器
    FOS_ERROR_CONNECTION_LOST = 2003, // 网络连接丢失
    FOS_ERROR_ACCESS_PHOTO = 2004, // 无法访问相册
    FOS_ERROR_ACCESS_CAMERA = 2005, // 无法访问相机
    
    
    // 宝付错误码
    FOS_SUCCESS_CODE = 0, // 成功
    FOS_ERROR_SPEECH_DECODE = 101, // 语音解码错误
    FOS_NOICE_MORE_CODE = 102,  // 噪音太大
    FOS_ERROR_SPEAKER_NOT_MATCH = 104, // 语音内容不符
    FOS_ERROR_SPEECH_LENGTH_LESS = 103, // 语音太短
    FOS_ERROR_USER_SPEECH_NOT_ENOUGH = 105, // 用户语音数据不足
    
    FOS_ERROR_IMAGE_DECODE = 201, // 图像解码错误
    FOS_ERROR_FACE_DETECT_FAIL = 202, // 人脸检测失败
    FOS_ERROR_USER_IMAGE_NOT_ENOUGH = 203, // 用户图像数据不足
    
    FOS_ERROR_PRARMS_NOT_ENOUGH = 301, // 参数缺失
    FOS_UNKNOWN_PARAMS = 302, // 未知参数
    
    FOS_USER_SPEAKER_NOT_EXIST = 401, // 用户声纹不存在
    FOS_USER_SPEAKER_EXIST = 402, // 用户声纹已存在
    FOS_USER_FACE_NOT_EXIST = 403, // 用户人脸不存在
    FOS_USER_FACE_EXIST = 404, // 用户人脸已存在
    FOS_USER_COM_EXIST = 411, // 用户复合已存在
    FOS_USER_COM_NOT_EXIST = 412,// 用户复合不存在
    FOS_GROUP_NOT_EXIST = 406, // group不存在
    FOS_GROUP_EXIST = 405, // group已存在
    FOS_PERSON_EXIST = 407, // person已存在
    FOS_PERSON_NOT_EXIST = 408, // person不存在
    
    FOS_USER_COMPOUND_MODEL_NOT_EXIST = 409, // 用户复合模型不存在
    FOS_USER_COMPOUND_MODEL_EXIST = 410, // 用户复合模型已存在
    FOS_USER_ALVIE_VIDEO_ERROR = 1411, // 没有采集到活体照片
    FOS_COLLECT_TIMED_OUT = 1412, // 采集超时
    FOS_COLLECT_MULTI_FACE = 1413, // 检测到多个人脸
    FOS_COLLECT_FACE_ERROR = 1414, // 未采集到人脸数据
    FOS_ERROR_RSA_HAPPEND = 1415,     // 获取加密串发生错误
    FOS_IDENTIFICATION_PERMISSION_ERROR = 1515,// 未设置FOSAFERAPPID和FOSAFERKEY
    FOS_INTERACTIVE_SDK_TYPE_ERROR = 1516,//sdk license 发生错误
    
};

/**
 *  包含静态方法和常量定义
 */
@interface FOSFosafer : NSObject

/**
 *  获取版本代码，例如@"1.0.0"
 *
 *  @return 版本代码
 */
+ (NSString *)version;

/**
 *  获取用户列表
 *
 *  @param params 参数
 *
 *  @return 用户列表数据（NSError or NSDictionary）
 */
+ (id)getUserList:(NSDictionary *)params;

/**
 *  检查用户id的注册状态
 *
 *  @param params 参数
 *
 *  @return 注册状态（NSError or NSDictionary）
 */
+ (id)checkId:(NSDictionary *)params;

/**
 *  删除声纹模型
 *
 *  @param params 参数
 *
 *  @return 删除状态（NSError or NSDictionary）
 */
+ (id)deleteVoiceModel:(NSDictionary *)params;

/**
 *  删除人脸模型
 *
 *  @param params 参数
 *
 *  @return 删除状态（NSError or NSDictionary）
 */
+ (id)deleteFaceModel:(NSDictionary *)params;
/**
 *  删除复合模型
 *
 *  @param params 参数
 */
+ (void)deleteCompoundModel:(NSDictionary *)params;

/**
 *  随机生成的数字文本
 *
 *  @param count 文本数量
 *
 *  @return 返回的文本数组
 */
+ (NSArray *)randomDigits:(int)count;
/**
 *  sdk http post
 *
 *  @param path 请求路径
 *  @param params 请求参数
 *
 *  @return 返回请求结果
 */
+ (id)httpPost:(NSString *)path params:(NSDictionary *)params;


@end
