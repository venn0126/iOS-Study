//
//  FSRecorder.h
//  fosFloatView
//
//  Created by Augus on 2020/11/10.
//

#import <Foundation/Foundation.h>
#import "FSGlobal.h"

#define FSDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

typedef void(^Success)(BOOL ret);


@protocol FSRecorderDelegate <NSObject>

/**
 * 准备中
 */
- (void)recorderPrepare;

/**
 * 录音中
 */
- (void)recorderRecording;

/**
 * 录音失败
 */
- (void)recorderFailed:(NSString *)failedMessage;

@end

//NS_ASSUME_NONNULL_BEGIN

@interface FSRecorder : NSObject

@property (nonatomic,copy, readonly) NSString *recordPath;
@property (nonatomic,weak) id<FSRecorderDelegate> delegate; // 代理
@property (nonatomic,assign) BOOL isRecording;


/**
 *  单例
 */
singtonInterface;

/**
 *  开始录音
 */
- (void)beginRecordWithRecordPath:(NSString *)recordPath;

/**
 *  结束录音
 */
- (void)endRecord;

/**
 *  暂停录音
 */
- (void)pauseRecord;

/**
 *  删除录音
 */
- (void)deleteRecord;

/**
 *  返回分贝值
 */
- (float)levels;

@end

//NS_ASSUME_NONNULL_END
