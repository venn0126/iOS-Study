//
//  FSVoiceView.h
//  fosFloatView
//
//  Created by Augus on 2020/11/10.
//

#import <UIKit/UIKit.h>


typedef void (^voiceBlock)(void);

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,FSVoiceState) {
    FSVoiceStateDefault = 0, // 默认状态
    FSVoiceStateRecord,      // 录音
    FSVoiceStatePlay         // 播放
} ;

@interface FSVoiceView : UIView

@property (nonatomic,assign) FSVoiceState state;
@property (nonatomic, copy) voiceBlock voiceBlock;


@end

NS_ASSUME_NONNULL_END
