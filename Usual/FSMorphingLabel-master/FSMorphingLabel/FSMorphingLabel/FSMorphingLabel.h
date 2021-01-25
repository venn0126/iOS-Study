//
//  FSMorphingLabel.h
//  iDraw
//
//  Created by 翁志方 on 2016/12/20.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSEasing.h"
#import "FSCharacterDiffResult.h"
#import "FSCharacterLimbo.h"
#import "FSMorphingEffectPhase.h"
#import "FSEmitterView.h"


typedef void (^FSMorphingStartClosure)(void);

typedef FSCharacterLimbo * (^FSMorphingEffectClosure)(unichar ch, NSInteger index, float progress);

typedef BOOL (^FSMorphingDrawingClosure)(FSCharacterLimbo *limbo);

typedef float (^FSMorphingManipulateProgressClosure)(NSInteger index,float progress, BOOL isNewChar);

typedef int (^FSMorphingSkipFramesClosure)(void);



// 代理
@class FSMorphingLabel;
@protocol FSMorphingLabelDelegate<NSObject>

@optional
- (void)morphingDidStart:(FSMorphingLabel *)label;
- (void)morphingDidComplete:(FSMorphingLabel *)label;
- (void)morphingDidOnProgress:(FSMorphingLabel *)label;

@end



@interface FSMorphingLabel : UILabel
{
    float morphingProgress;             // 当前显示进程
    float morphingDuration;             // 动画时间
    float morphingCharacterDelay;       // 顺序显示相邻字符延迟时间
  
    NSString *previousText;             // 旧字符串
    NSArray *diffResults;               // 旧字符串与新字符串之间状态区分
    
    int currentFrame;                   // 当前所在帧
    int totalFrame;                     // 这次动画所有帧数
    int totalDelayFrame;                // 延迟帧数
    
    float totalWidth;
    CGRect *previousRects;              // 旧字符串的frame数组
    CGRect *newRects;                   // 新字符串的frame数组
    
    float charHeight;                   // 根据font大小计算出的字符高度
    int skipFramesCount;
    
    CADisplayLink *displayLink;
}
@property (nonatomic, assign) BOOL morphingDisable;         // 是否开启效果

@property (nonatomic, assign) FSMorphingEffect morphingEffect;            // 默认scale

@property (nonatomic, strong) NSMutableDictionary *effectDictionary;       // 效果字典

@property (nonatomic, strong) FSEmitterView *emitterView;                  // 粒子视图


@property (nonatomic, weak) id<FSMorphingLabelDelegate> delegate;          // 代理



@end
