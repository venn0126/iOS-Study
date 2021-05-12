//
//  GTPlayerController.m
//  NWUITest
//
//  Created by Augus on 2021/4/30.
//

#import "GTPlayerController.h"
#import <AVFoundation/AVFoundation.h>


@interface GTPlayerController ()

@property (nonatomic, assign)  BOOL nPlaying;
@property (nonatomic, copy) NSArray<AVAudioPlayer *> *nw_players;

@end

@implementation GTPlayerController

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    AVAudioPlayer *guitarPlayer = [self playerForFile:@"sample1"];
    AVAudioPlayer *bassPlayer = [self playerForFile:@"sample3"];
    AVAudioPlayer *drumsPlayer = [self playerForFile:@"sample4"];
    _nw_players = @[guitarPlayer,bassPlayer,drumsPlayer];
    
    
    // 注册中断通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(handleInterruption:)
                   name:AVAudioSessionInterruptionNotification
                 object:[AVAudioSession sharedInstance]];
    
    [center addObserver:self
               selector:@selector(handleRouteChange:)
                   name:AVAudioSessionRouteChangeNotification
                 object:[AVAudioSession sharedInstance]];
    
    return self;
}

- (AVAudioPlayer *)playerForFile:(NSString *)name {
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:name withExtension:@"caf"];
    NSError *error;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&error];
    if (!player) {
        NSLog(@"init player error %@",[error localizedDescription]);
        return nil;
    }
    
    player.numberOfLoops = -1;
    player.enableRate = YES;
    [player prepareToPlay];
    
    return player;
}




#pragma mark - Global methods

- (void)play {
    if (!self.nPlaying) {
        NSTimeInterval delayTime = [self.nw_players[0] deviceCurrentTime] + 0.01;
        for (AVAudioPlayer *player in self.nw_players) {
            [player playAtTime:delayTime];
        }
        self.nPlaying = YES;
    }
}


- (void)stop {
    
    if (self.nPlaying) {
        for (AVAudioPlayer *player in self.nw_players) {
            [player stop];
            player.currentTime = 0.0f;
        }
        self.nPlaying = NO;
    }
}

- (void)adjustRate:(float)rate {
    
    for (AVAudioPlayer *player in self.nw_players) {
        player.rate = rate;
    }
}

#pragma mark - Spec methods

- (void)adjustPan:(float)pan forPlayerAtIndex:(NSUInteger)index {
    
    if (![self isValidIndex:index]) {
        NSLog(@"index is error");
        return;
    }
    AVAudioPlayer *player = self.nw_players[index];
    [player setPan:pan];
    
}

- (void)adjustVolume:(float)volume forPlayerAtIndex:(NSUInteger)index {
    
    if (![self isValidIndex:index]) {
        NSLog(@"index is error");
        return;
    }
    
    AVAudioPlayer *player = self.nw_players[index];
    [player setVolume:volume];
    
}

- (BOOL)isValidIndex:(NSUInteger)index {
    
    return index == 0 || index < self.nw_players.count;
}


- (void)testRecorder {
    
    NSString *directory = NSHomeDirectory();
    NSString *filePath = [directory stringByAppendingPathComponent:@"voice.m4a"];
    NSURL *url = [NSURL URLWithString:filePath];
    
    /**
     
     音频格式
     AVFormatIDKey:写入内容的音频格式
     kAudioFormatLinearPCM：将未压缩的的音频流数据写入到文件中，保真度最高
     kAudioFormatMPEG4AAC：显著缩小文件，还能保证质量
     kAudioFormatAppleLossless
     kAudioFormatAppleIMA4：显著缩小文件，还能保证质量
     kAudioFormatULaw
     kAudioFormatiLBC
     
     注意：你所指定的音频格式一定要和URL参数定义的文件类型兼容
     比如：你指定的是test.wav，隐含的意思就会死录制的音频必须满足waveform audio file format的格式要求，
     即低字节序，Linear PCM，为key指定其他值会有如下错误信息
     ‘The operation couldn't be completed.(OSStatus error 1718449215)1718449215是4字节编码的整数值
     
     */
    NSDictionary *settings = @{AVFormatIDKey : @(kAudioFormatMPEG4AAC),
                               AVSampleRateKey: @22050.0f,
                               AVNumberOfChannelsKey : @1,
    };
    
    NSError *error;
    
    AVAudioRecorder *recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if (error) {
        NSLog(@"init audio recorder error %@",error.localizedDescription);
        return;
    }
    
    // 在audio queue底层执行一些初始化的必要过程，还会在url参数指定位置创建一个文件，将初始化延迟降低到最小
    [recorder prepareToRecord];
}

#pragma mark - Notification handle

- (void)handleInterruption:(NSNotification *)notification {
    
    NSLog(@"%@---%@",@(__PRETTY_FUNCTION__),@(__LINE__));
    
    NSDictionary *userInfo = notification.userInfo;
    AVAudioSessionInterruptionType type = [userInfo[AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
    
    if (type == AVAudioSessionInterruptionTypeBegan) {
        // handle AVAudioSessionInterruptionTypeBegan
        [self stop];
        if (self.delegate && [self.delegate respondsToSelector:@selector(playbackStoppedForPlayerController:)]) {
            
            [self.delegate playbackStoppedForPlayerController:self];
        }
        
    } else {
        // handle  AVAudioSessionInterruptionTypeEnded
        
        // userInfo 字典会包含一个AVAudioSessionInterruptionOptions值来表明音频回话是否已经重新激活
        // 以及是否可以再次播放
        AVAudioSessionInterruptionOptions options = [userInfo[AVAudioSessionInterruptionOptionKey] unsignedIntegerValue];
        if (options == AVAudioSessionInterruptionOptionShouldResume) {
            [self play];
            if (self.delegate && [self.delegate respondsToSelector:@selector(playbackBeganForPlayerController:)]) {
                [self.delegate playbackBeganForPlayerController:self];
            }
        }
    }
}

- (void)handleRouteChange:(NSNotification *)notification {
    
    NSDictionary *info = notification.userInfo;
    AVAudioSessionRouteChangeReason reason = [info[AVAudioSessionRouteChangeReasonKey] unsignedIntegerValue];
    
    // 耳机断开事件
    // 需求：在耳际断开时，停止播放
    if (reason == AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        
        // 获取前一个线路
        AVAudioSessionRouteDescription *previousRoute = info[AVAudioSessionRouteChangePreviousRouteKey];
        // 获取前一个线路的输出设备
        AVAudioSessionPortDescription *previousOutput = previousRoute.outputs[0];
        // 获取输出设备端口类型
        NSString *portType = previousOutput.portType;
        // 与目标耳机进行匹配
        if ([portType isEqualToString:AVAudioSessionPortHeadphones]) {
            [self stop];
            if (self.delegate && [self.delegate respondsToSelector:@selector(playbackStoppedForPlayerController:)]) {
                [self.delegate playbackStoppedForPlayerController:self];
            }
        }
    }
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
