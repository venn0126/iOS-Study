//
//  Toyger.h
//  ToygerAlgorithm
//
//  Created by 王伟伟 on 2018/1/22.
//  Copyright © 2018年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToygerPublicDefine.h"
#import "ToygerConfig.h"

#ifdef USE_SENSOR

#import "ToygerSensorHandler.h"

#endif

@class ToygerServiceInstance;
@class ToygerFrame;

//extern NSString *const kCipherDataKey;
//extern NSString *const kZolozPubKey;
//extern NSString *const kUserIDKey;

@protocol ToygerServiceInstanceDelegate<NSObject>

/**
 ToygerService处理完一帧后的状态更新的回调

 @param instance 算法实例
 @param frame 返回的帧
 */
- (void)toygerService:(ToygerServiceInstance *)instance frameDidUpdate:(ToygerFrame *)frame;

/**
 ToygerService事件触发

 @param instance 算法实例
 @param eventDict 触发的事件Dictionary
 */
- (void)toygerService:(ToygerServiceInstance *)instance triggerEvent:(NSDictionary *)eventDict;

/**
 ToygerService埋点
 
 @param instance 算法实例
 @param eventDict
 */
- (void)toygerService:(ToygerServiceInstance *)instance triggerMonitor:(NSDictionary *)monitorDataDict;

/**
 ToygerService采集结束

 @param instance 算法实例
 @param completionDict 算法结束回调
 */
- (void)toygerService:(ToygerServiceInstance *)instance captureDidComplete:(NSDictionary *)completionDict;

@optional

/**
 ToygerService采集到一张高清人脸大图（人脸算法才有）

 @param instance 算法实例
 @param image 采集到的Image
 */
- (void)toygerService:(ToygerServiceInstance *)instance didGetHighQualityImage:(UIImage *)image;

@end

@interface ToygerServiceInstance : NSObject

/**
 设置算法的配置
 */
@property (nonatomic, strong) ToygerConfig *config;

/**
 ToygerInstace的代理
 */
@property (nonatomic, weak) id<ToygerServiceInstanceDelegate> delegate;
/**
 密文秘钥
 */
@property (nonatomic, strong)NSString *aesCipher;

/**
 初始化Toyger算法.
 提前初始化可以加快算法的启动速度

 @return Toyger算法实例
 */
- (instancetype)initWithType:(ToygerServiceType)type andExtInfo:(NSDictionary *)extInfo NS_DESIGNATED_INITIALIZER;

/**
 初始化Toyger算法.(老接口)
 提前初始化可以加快算法的启动速度
 
 @return Toyger算法实例
 */
- (instancetype)initWithType:(ToygerServiceType)type AndPubKey:(NSString *)pubKey NS_DESIGNATED_INITIALIZER;

/**
 Toyger算法处理图片

 @param sampleBuffer 摄像头传入的SampleBuffer
 */
- (void)processImage:(CMSampleBufferRef)sampleBuffer byOrientation:(UIImageOrientation)orientation extraInfo:(NSDictionary *)extra;

#ifdef USE_SENSOR

- (void)processSensorData:(ToygerSensorData *) sensorData withExtraInfo:(NSDictionary *)extra;

#endif
/**
 对于算法不支持的类型，需要组装数据

 @param image 传入的图片
 @return 返回要上传的内容
 */
- (NSData *)dataWithSurveillance:(NSArray<UIImage *> *)surveillance byType:(ToygerServiceType)toygerType  extraInfo:(NSDictionary *)extraInfo;



- (NSData *)dataWithDocCaptureImage:(UIImage *)image andAeskey:(NSString *)aesKey extraInfo:(NSDictionary *)extraInfo;
/**
 重置算法的状态
 */
- (void)reset;

/**
 返回算法的MetaInfo

 @return metaInfo
 */
+ (NSArray<NSString *> *)metaInfo;


@end
