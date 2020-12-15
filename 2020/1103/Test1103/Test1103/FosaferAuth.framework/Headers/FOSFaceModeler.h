//
//  FOSFaceModeler.h
//  Fosafer
//
//  Created by Fosafer on 7/31/15.
//  Copyright (c) 2015 Fosafer Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "FOSFosafer.h"

@class FOSFaceModeler;

/**
 *  人脸注册事件监听代理，所有回调都在主线程
 */
@protocol FOSFaceModelerDelegate <NSObject>

@optional

/**
 *  人脸注册器开始工作
 *
 *  @param modeler 注册器对象
 */
- (void)modelerDidReadyForModeling:(FOSFaceModeler *)modeler;

/**
 *  检测到新的人脸状态
 *
 *  @param modeler  注册器对象
 *  @param faceInfo 人脸状态，包含index，当前人脸状态等信息
 */
- (void)modeler:(FOSFaceModeler *)modeler faceInfo:(NSDictionary *)faceInfo;

/**
 *  人脸数据采集阶段完成，可以提示用户正在等待最终处理
 *
 *  @param modeler  注册器对象
 */
- (void)modelerDidEndCollecting:(FOSFaceModeler *)modeler;

/**
 *  采集到了有效的人脸图片
 *
 *  @param modeler 注册器对象
 *  @param images  人脸图片
 */
- (void)modeler:(FOSFaceModeler *)modeler collectedImages:(NSArray *)images;

/**
 *  发生错误
 *
 *  @param modeler  注册器对象
 *  @param error      错误信息
 */
- (void)modeler:(FOSFaceModeler *)modeler error:(NSError *)error;

/**
 *  人脸注册器完成工作
 *
 *  @param modeler  注册器对象
 *  @param result 注册结果信息
 */
- (void)modeler:(FOSFaceModeler *)modeler result:(NSDictionary *)result;


@end

@interface FOSFaceModeler : NSObject

@property (nonatomic, weak) id<FOSFaceModelerDelegate> delegate;

/**
 *  初始化注册器实例
 *
 *  @param params 参数
 *  @param view 显示相机预览的view，请设置为一个全屏尺寸的view
 *  @param videoSession 相机的videoSession，如果该参数为nil，将尝试新建videoSession
 *
 *  @return FOSFaceModeler实例
 */
- (instancetype)initWithParams:(NSDictionary *)params preview:(UIView *)view videoSession:(AVCaptureSession *)videoSession NS_DESIGNATED_INITIALIZER;

/**
 *  当前工作的相机的videoSession，只要没有调用cancel，可以尝试复用session，减少相机的开关
 *
 *  @return 相机的videoSession
 */
- (AVCaptureSession *)videoSession;

/**
 * 准备好注册器，该方法阻塞等待网络请求响应，不能在主线程调用
 */
- (id)prepare;

/**
 *  开始工作
 */
- (void)startWorking;

/**
 *  结束工作
 */
- (void)finishWorking;

/**
 *  取消注册
 */
- (void)cancel;

@end
