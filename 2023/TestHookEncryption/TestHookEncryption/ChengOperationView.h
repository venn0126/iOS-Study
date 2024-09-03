//
//  ChengOperationView.h
//  TestHookEncryption
//
//  Created by Augus on 2024/9/2.
//

#import <UIKit/UIKit.h>

typedef void(^ChengTimerBlock)(NSTimer * _Nullable timer);

typedef enum : NSUInteger {
    /// 未开始
    ChengOperationViewTaskStatusReady,
    /// 运行中
    ChengOperationViewTaskStatusRunning,
    /// 已停止
    ChengOperationViewTaskStatusStopped,
} ChengOperationViewTaskStatus;

NS_ASSUME_NONNULL_BEGIN

@class ChengOperationView;
@protocol ChengOperationViewDelegate <NSObject>

/// 针对不同的视图的点击事件的回调方法
/// - Parameters:
///   - operationView: 当前的底层视图
///   - tag: 点击某个子视图对应的tag
- (void)operationView:(ChengOperationView *)operationView actionForTag:(NSInteger)tag;

@end

@interface ChengOperationView : UIView

@property(nonatomic, weak) id<ChengOperationViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
