//
//  FSTalkBackView.m
//  fosFloatView
//
//  Created by Augus on 2020/11/10.
//

#import "FSTalkBackView.h"
#import "FSVoiceButton.h"
#import "FSRecordStateView.h"
#import "FSRecorder.h"
#import "FSFlieManager.h"
#import "FSVoiceView.h"

static CGFloat const maxScale = 0.45;


@interface FSTalkBackView ()<FSRecorderDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, weak) FSRecordStateView *stateView; //
@property (nonatomic, strong) FSVoiceButton *micButton;    // 录音按钮
@property (nonatomic, strong) FSVoiceButton *textInputButton;   // 文本输入按钮
@property (nonatomic, strong) FSVoiceButton *cancelButton; // 取消按钮
@property (nonatomic, strong) FSVoiceButton *playButton;   // 播放按钮


@property (nonatomic, strong) UIImageView *voiceLine; // aio_voice_line
@property (nonatomic, strong) UIPanGestureRecognizer *pan; // 手势


@end

@implementation FSTalkBackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor greenColor];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    [self stateView]; // 创建当前状态的view
    [self voiceLine]; // 录音时的曲线
    [self micButton]; // 创建micPhone按钮
    [self playButton]; // 创建播放按钮
    [self cancelButton]; // 创建取消按钮

}


#pragma mark - 拖拽手势
- (void)pan:(UIPanGestureRecognizer *)pan {
    
    if (!self.micButton.isSelected) return;
    
    CGPoint point = [pan locationInView:pan.view.superview];
    if (pan.state == UIGestureRecognizerStateBegan) {
        //        NSLog(@"began");
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        __weak __typeof(self)weakSelf = self;
        
        if (point.x < self.width / 2.0) { // 触摸在左边
            [self transitionButton:self.playButton WithPoint:point containBlock:^(BOOL isContain) {
                if (isContain) {  //触摸到了播放按钮内
                    weakSelf.stateView.recordState = FSRecordStateListen;
                }else {
                    weakSelf.stateView.recordState = FSRecordStateRecording;
                }
            }];
        }else { // 触摸在右边
//            NSLog(@"%@",NSStringFromCGRect(self.cancelButton.backgroudLayer.frame));
            [self transitionButton:self.cancelButton WithPoint:point containBlock:^(BOOL isContain) {
//                NSLog(@"%zd=================",isContain);
                if (isContain) {  //触摸到了播放按钮内
                    weakSelf.stateView.recordState = FSRecordStateCancel;
                }else {
                    weakSelf.stateView.recordState = FSRecordStateRecording;
                }
            }];
        }
    }else {  // 松开手指 或者 手势cancel
        
        [[FSRecorder shareInstance] endRecord]; // 结束录音
        [self.stateView endRecord];
        if (self.stateView.recordState == FSRecordStateListen) {
            NSLog(@"试听...");
//            self.playView = nil;
//            [self playView];
            
            // 操作回传
            self.talkBackBlock();

            
        }else if (self.stateView.recordState == FSRecordStateCancel) {
            NSLog(@"取消发送...");
            [[FSRecorder shareInstance] deleteRecord];
            // 设置状态 显示小圆点和三个标签
//            [(FSVoiceView *)self.superview setState:FSVoiceStateDefault];
        }else {
            NSLog(@"发送语音");
            // 设置状态 显示小圆点和三个标签
//            [(FSVoiceView *)self.superview setState:FSVoiceStateDefault];
        }
        
        self.micButton.selected = NO;
        self.playButton.selected = NO;
        self.cancelButton.selected = NO;
        
        self.playButton.hidden = YES;
        self.cancelButton.hidden = YES;
        self.voiceLine.hidden = YES;
        self.playButton.backgroudLayer.transform = CATransform3DIdentity;
        self.cancelButton.backgroudLayer.transform = CATransform3DIdentity;
        
        self.stateView.recordState = FSRecordStateDefault;
        
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ( [gestureRecognizer isEqual:_pan] ) {
        if (!self.micButton.isSelected) {
            return NO;
        }
    }
    return YES;
}


#pragma mark - 录音按钮 点击事件
// 开始录音
- (void)starRecorde:(UIButton *)btn {
    NSLog(@"开始录音");
    
    btn.enabled = NO;
    NSTimeInterval t = 0.3;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(t * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.enabled = YES;
    });
    
    [FSRecorder shareInstance].delegate = self;
    btn.selected = YES;
    
    // 设置状态 隐藏小圆点和三个标签
//    [(FSVoiceView *)self.superview setState:FSVoiceStateRecord];
    
    [self animationMicBtn:^(BOOL finished) {
//        NSString *path = [CWDocumentPath stringByAppendingPathComponent:@"test.wav"];
        //        @"/Users/chavez/Desktop/test.wav"
        NSString *filePath = [FSFlieManager filePath];

        [[FSRecorder shareInstance] beginRecordWithRecordPath:filePath];
    }];
    
}

// 手指松开 发送录音
- (void)sendRecorde:(UIButton *)btn {
    NSTimeInterval t = 0;
    if (![FSRecorder shareInstance].isRecording) {
        t = 0.3;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(t * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.selected = NO;
        self.playButton.hidden = YES;
        self.cancelButton.hidden = YES;
        self.voiceLine.hidden = YES;
        self.stateView.recordState = FSRecordStateDefault;
        [[FSRecorder shareInstance] endRecord];
        [self.stateView endRecord];
        // 设置状态 显示小圆点和三个标签
//        [(FSVoiceView *)self.superview setState:FSVoiceStateDefault];
//        if (t == 0) {
//            NSLog(@"发送录音111111");
//        }else {
//            NSLog(@"录音时间太短");
//            [CWFlieManager removeFile:[CWRecorder shareInstance].recordPath];
//        }
    });
}

#pragma mark 按钮的形变以及动画
- (void)transitionButton:(FSVoiceButton *)btn WithPoint:(CGPoint)point containBlock:(void(^)(BOOL isContain))block{
    
    CGFloat distance = [self distanceWithPointA:btn.center pointB:point];
    CGFloat d = btn.width * 3 / 4;
    CGFloat x = distance * maxScale / d;
    CGFloat scale = 1 - x;
    scale = scale > 0 ?  scale > maxScale ? maxScale : scale : 0;
    CGPoint p = [self.layer convertPoint:point toLayer:btn.backgroudLayer];
    if ([btn.backgroudLayer containsPoint:p]) {
        btn.selected = YES;
        btn.backgroudLayer.transform = CATransform3DMakeScale(1 + maxScale, 1 + maxScale, 1);
        if (block) {
            block(YES);
        }
    }else {
        btn.backgroudLayer.transform = CATransform3DMakeScale(1 + scale, 1 + scale, 1);
        btn.selected = NO;
        if (block) {
            block(NO);
        }
    }
}
#pragma mark 按钮的动画
// 麦克风按钮动画
- (void)animationMicBtn:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:0.10 animations:^{
        self.micButton.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.05 animations:^{
            self.micButton.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
        
    }];
}


// 播放与取消按钮动画
- (void)animationPlayAndCancelBtn {
    
    [self animationWithStarPoint:CGPointMake(self.playButton.centerX + 20, self.playButton.centerY) endPoint:self.playButton.center view:self.playButton];
    [self animationWithStarPoint:CGPointMake(self.cancelButton.centerX - 20, self.cancelButton.centerY) endPoint:self.cancelButton.center view:self.cancelButton];
    
}

- (void)animationWithStarPoint:(CGPoint)starP endPoint:(CGPoint)endP view:(UIView *)view {
    view.hidden = NO;
    CABasicAnimation *positionAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnim.fromValue = [NSValue valueWithCGPoint:starP];
    positionAnim.toValue = [NSValue valueWithCGPoint:endP];
    positionAnim.duration = 0.15;
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.toValue = @1;
    opacityAnim.fromValue = @0;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[positionAnim,opacityAnim];
    animationGroup.duration = 0.15;
    [view.layer addAnimation:animationGroup forKey:nil];
}
// 曲线动画
- (void)animationVoiceLine {
    self.voiceLine.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self.voiceLine.hidden = NO;
    [UIView animateWithDuration:0.15 animations:^{
        self.voiceLine.transform = CGAffineTransformIdentity;
    }];
}

// 计算两点之间的距离
- (CGFloat)distanceWithPointA:(CGPoint)pointA pointB:(CGPoint)pointB {
    CGFloat distance = sqrt(pow((pointA.x - pointB.x), 2) + pow((pointA.y - pointB.y), 2));
    
    return distance;
}

#pragma mark - CWRecorderDelegate
- (void)recorderPrepare {
//    NSLog(@"准备中......");
    self.stateView.recordState = FSRecordStatePrepare;
}

- (void)recorderRecording {
    self.stateView.recordState = FSRecordStateRecording;
    [self animationPlayAndCancelBtn]; // 播放按钮 和 取消按钮的动画
    [self animationVoiceLine]; // 曲线动画
    // 设置状态view开始录音
    [self.stateView beginRecord];
}

- (void)recorderFailed:(NSString *)failedMessage {
    self.stateView.recordState = FSRecordStateDefault;
    NSLog(@"失败：%@",failedMessage);
}

#pragma mark - block
- (void)handleRecordDurationCallback:(NSInteger)recordDuration {
    NSLog(@"recordDuration -- %@", @(recordDuration));
    if ( recordDuration > MaxRecordTime ) {
        [self sendRecorde:_micButton];
    }
}


#pragma mark - Lazy

- (UIImageView *)voiceLine {
    if (_voiceLine == nil) {
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aio_voice_line"]];
//        imageV.cw_centerX = self.cw_width / 2.0;
        imageV.hidden = YES;
//        imageV.backgroundColor = [UIColor redColor];
        [self addSubview:imageV];
        _voiceLine = imageV;
    }
    return _voiceLine;
}

- (FSRecordStateView *)stateView {
    if (_stateView == nil) {
        FSRecordStateView *stateView = [[FSRecordStateView alloc] initWithFrame:CGRectMake(0, 10, self.width, 50)];
//        stateView.backgroundColor = [UIColor blueColor];
        WeakSelf(self)
        stateView.recordDurationProgress = ^(NSInteger progress) {
            [weakself handleRecordDurationCallback:progress];
        };
        [self addSubview:stateView];
        _stateView = stateView;
    }
    return  _stateView;
}

- (FSVoiceButton *)micButton {
    if (_micButton == nil) {
        FSVoiceButton *btn = [FSVoiceButton buttonWithBackImageNor:@"aio_voice_button_nor" backImageSelected:@"aio_voice_button_press" imageNor:@"aio_voice_button_icon" imageSelected:@"aio_voice_button_icon" frame:CGRectMake(0, self.stateView.fs_bottom, 0, 0) isMicPhone:YES];
        // 手指按下
        [btn addTarget:self action:@selector(starRecorde:) forControlEvents:UIControlEventTouchDown];
        // 松开手指
        [btn addTarget:self action:@selector(sendRecorde:) forControlEvents:UIControlEventTouchUpInside];
        // 拖动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        pan.delegate = self;
        _pan = pan;
        [btn addGestureRecognizer:pan];

        btn.centerX = self.width / 2.0;
        self.voiceLine.center = btn.center;
        [self addSubview:btn];
        _micButton = btn;
    }
    return _micButton;
}

- (FSVoiceButton *)cancelButton {
    if (_cancelButton == nil) {
        FSVoiceButton *btn = [FSVoiceButton buttonWithBackImageNor:@"aio_voice_operate_nor" backImageSelected:@"aio_voice_operate_press" imageNor:@"aio_voice_operate_delete_nor" imageSelected:@"aio_voice_operate_delete_press" frame:CGRectMake(self.width - 35 , self.stateView.fs_bottom + 10, 0, 0) isMicPhone:NO];
        btn.frame = CGRectMake(self.width - 35 - btn.norImage.size.width, self.stateView.fs_bottom + 10, btn.norImage.size.width, btn.norImage.size.height);
        [self addSubview:btn];
//        btn.backgroundColor = [UIColor redColor];
        btn.hidden = YES;
        _cancelButton = btn;
    }
    return _cancelButton;
}

- (FSVoiceButton *)playButton {
    if (_playButton == nil) {
        FSVoiceButton *btn = [FSVoiceButton buttonWithBackImageNor:@"aio_voice_operate_nor" backImageSelected:@"aio_voice_operate_press" imageNor:@"aio_voice_operate_listen_nor" imageSelected:@"aio_voice_operate_listen_press" frame:CGRectMake(35, self.stateView.fs_bottom + 10, 0, 0) isMicPhone:NO];
        [self addSubview:btn];
        btn.hidden = YES;
        _playButton = btn;
    }
    return _playButton;
}
@end
