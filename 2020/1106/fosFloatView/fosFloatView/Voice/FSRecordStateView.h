//
//  FSRecordStateView.h
//  fosFloatView
//
//  Created by Augus on 2020/11/10.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FSRecordState) {
    FSRecordStateDefault = 0,       // 按住说话
    FSRecordStateClickRecord,       // 点击录音
    FSRecordStateTouchChangeVoice,  // 按住变声
    FSRecordStateListen ,           // 试听
    FSRecordStateCancel,            // 取消
    FSRecordStateSend,              // 发送
    FSRecordStatePrepare,           // 准备中
    FSRecordStateRecording,         // 录音中
    FSRecordStatePreparePlay,       // 准备播放
    FSRecordStatePlay               // 播放
} ;

#define WeakSelf(type)  __weak typeof(type) weak##type = type;

#define MaxRecordTime 6

NS_ASSUME_NONNULL_BEGIN

@interface FSRecordStateView : UIView

@property (nonatomic,assign) FSRecordState recordState; // 录音状态

@property (nonatomic,copy) void(^playProgress)(CGFloat progress);

@property (nonatomic,copy) void(^recordDurationProgress)(NSInteger progress);

@property (nonatomic,assign, readonly) NSInteger recordDuration;      // 录音时长

// 开始录音
- (void)beginRecord;

// 结束录音
- (void)endRecord;


@end

NS_ASSUME_NONNULL_END
