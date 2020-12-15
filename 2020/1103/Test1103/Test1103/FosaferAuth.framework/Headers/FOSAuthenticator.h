//
//  FOSAuthenticator.h
//  Fosafer
//
//  Created by Fosafer on 8/5/15.
//  Copyright (c) 2015 Fosafer Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "FOSFosafer.h"

@class FOSAuthenticator;

/** 认证类型，TAuthType（FOSFosafer.h），默认ESpeaker（声纹） */
FOUNDATION_EXPORT NSString * const FOS_KEY_AUTH_TYPE;
/** 认证时是否启用活体检测，BOOL，默认开启 */
FOUNDATION_EXPORT NSString * const FOS_KEY_ENABLE_ALIVE_DETECT;
/** 辨识身份时返回top n个用户名，必须设置`FOS_KEY_GROUP_ID`（FOSFosafer.h）才会有意义 */
FOUNDATION_EXPORT NSString * const FOS_KEY_IDENTIFY_TOP_N;

/**
 *  认证事件监听代理，所有回调都在主线程
 */
@protocol FOSAuthenticatorDelegate <NSObject>

@optional

/**
 *  认证器开始工作
 *
 *  @param authenticator  认证器对象
 */
- (void)authenticatorDidStartWorking:(FOSAuthenticator *)authenticator;

/**
 *  数据采集阶段完成，可以提示用户正在等待最终处理
 *
 *  @param modeler  认证器对象
 */
- (void)authenticatorDidEndCollecting:(FOSAuthenticator *)modeler;

/**
 *  采集到了有效的语音
 *
 *  @param authenticator 认证器对象
 *  @param audios  语音数据
 */
- (void)authenticator:(FOSAuthenticator *)authenticator collectedAudios:(NSArray *)audios;

/**
 *  检测到新的人脸状态
 *
 *  @param authenticator  认证器对象
 *  @param faceInfo 人脸状态，包含index，当前人脸状态等信息
 */
- (void)authenticator:(FOSAuthenticator *)authenticator faceInfo:(NSDictionary *)faceInfo;

/**
 *  采集到了有效的人脸图片
 *
 *  @param authenticator 认证器对象
 *  @param images  人脸图片
 */
- (void)authenticator:(FOSAuthenticator *)authenticator collectedImages:(NSArray *)images;

/**
 *  发生错误
 *
 *  @param authenticator  认证器对象
 *  @param error      错误信息
 */
- (void)authenticator:(FOSAuthenticator *)authenticator error:(NSError *)error;

/**
 *  认证器完成工作
 *
 *  @param authenticator  认证器对象
 *  @param result 认证结果信息
 */
- (void)authenticator:(FOSAuthenticator *)authenticator result:(NSDictionary *)result;

@end

@interface FOSAuthenticator : NSObject

@property (nonatomic, weak) id<FOSAuthenticatorDelegate> delegate;

/**
 *  初始化认证器实例
 *
 *  @param params 参数
 *
 *  @return FOSAuthenticator实例
 */
- (instancetype)initWithParams:(NSDictionary *)params;

/**
 *  初始化认证器实例
 *
 *  @param params 参数

 *  @param view 显示相机预览的view，请设置为一个全屏尺寸的view，除非参数`FOS_KEY_AUTH_TYPE`设置为`ESpeaker`，否则该参数不能为nil
 *  @param videoSession 相机的videoSession，如果该参数为nil，将尝试新建videoSession
 *
 *  @return FOSAuthenticator实例
 */
- (instancetype)initWithParams:(NSDictionary *)params preview:(UIView *)view videoSession:(AVCaptureSession *)videoSession NS_DESIGNATED_INITIALIZER;

/**
 *  当前工作的相机的videoSession，只要没有调用cancel，可以尝试复用session，减少相机的开关
 *
 *  @return 相机的videoSession
 */
- (AVCaptureSession *)videoSession;

/**
 *  准备好认证器，该方法阻塞等待网络请求响应，不能在主线程调用
 */
- (id)prepare;

/**
 *  开始工作
 */
- (void)startWorking;

/**
 *  准备工作
 */
- (void)finishWorking;

/**
 *  获取当前录音的AudioQueueRef，只有在`- (void)authenticatorDidStartWorking:(FOSAuthenticator *)authenticator;`回调之后
 *  才能够保证正常获取到
 *
 *  @return AudioQueueRef
 */
- (AudioQueueRef)queue;

/**
 *  取消认证
 */
- (void)cancel;

@end
