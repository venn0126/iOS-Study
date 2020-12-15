//
//  FOSSpeakerModeler.h
//  Fosafer
//
//  Created by Fosafer on 7/22/15.
//  Copyright (c) 2015 Fosafer Co.,Ltd. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "FOSFosafer.h"

@class FOSSpeakerModeler;

/**
 *  声纹注册事件监听代理，所有回调都在主线程
 */
@protocol FOSSpeakerModelerDelegate <NSObject>

@optional

/**
 *  录音开始
 *
 *  @param modeler 声纹注册器对象
 */
- (void)modelerDidReadyForRecording:(FOSSpeakerModeler *)modeler;

/**
 *  录音结束
 *
 *  @param modeler 声纹注册器对象
 */
- (void)modelerDidEndRecording:(FOSSpeakerModeler *)modeler;

/**
 *  采集到了有效的语音
 *
 *  @param modeler 认证器对象
 *  @param audios  语音数据
 */
- (void)modeler:(FOSSpeakerModeler *)modeler collectedAudios:(NSArray *)audios;

/**
 *  发生错误
 *
 *  @param modeler 声纹注册器对象
 *  @param error   错误对象
 */
- (void)modeler:(FOSSpeakerModeler *)modeler error:(NSError *)error;

/**
 *  一步注册完成（无论是否发生error，一定会回调）
 *
 *  @param modeler 声纹注册器对象
 *  @param result 注册信息，包含了当前步数，总共步数等信息
 */
- (void)modeler:(FOSSpeakerModeler *)modeler result:(NSDictionary *)result;

@end

@interface FOSSpeakerModeler : NSObject

@property (nonatomic, weak) id<FOSSpeakerModelerDelegate> delegate;

/**
 * 初始化声纹注册器实例
 *
 * @param params 参数
 *
 * @return FOSSpeakerModeler实例
 */
- (instancetype)initWithParams:(NSDictionary *)params NS_DESIGNATED_INITIALIZER;

/**
 * 准备好声纹注册器，该方法阻塞等待网络请求响应，不能在主线程调用
 */
- (id)prepare;

/**
 * 下一步声纹注册
 */
- (void)nextStep;

/**
 * 完成一步
 */
- (void)finishStep;

/**
 *  获取当前录音的AudioQueueRef，只有在`- (void)modelerDidReadyForRecording:(FOSSpeakerModeler *)modeler;`回调之后
 *  才能够保证正常获取到
 *
 *  @return AudioQueueRef
 */
- (AudioQueueRef)queue;

/**
 * 取消当前步骤注册
 */
- (void)cancel;

@end
