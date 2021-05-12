//
//  GTRecorderController.m
//  NWUITest
//
//  Created by Augus on 2021/4/30.
//

#import "GTRecorderController.h"
#import <AVFoundation/AVFoundation.h>
#import "GTMemo.h"

@interface GTRecorderController ()<AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, copy) GTRecordingStopCompletionHander completionHander;





@end

@implementation GTRecorderController

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSString *tmpDir = NSTemporaryDirectory();
    NSString *filePath = [tmpDir stringByAppendingPathComponent:@"memo.caf"];
    NSURL *url = [NSURL URLWithString:filePath];
    
    /**
     
     AVEncoderBitDepthHintKey：采样深度，位宽
     AVEncoderAudioQualityKey
     */
    
    NSDictionary *settings = @{AVFormatIDKey : @(kAudioFormatAppleIMA4),
                               AVSampleRateKey : @44100.0f,
                               AVNumberOfChannelsKey : @1,
                               AVEncoderBitDepthHintKey : @16,
                               AVEncoderAudioQualityKey: @(AVAudioQualityMedium)
                    
    };
    
    NSError *error;
    _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if (_recorder) {
        [_recorder prepareToRecord];
        _recorder.delegate = self;
    } else {
        NSLog(@"init recorder error %@",error.localizedDescription);
    }
    
    return self;
}

#pragma mark - Recorder methods

- (BOOL)record {
    return [self.recorder record];
}

- (void)pause {
    [self.recorder pause];
}

- (void)stopWithCompletionHander:(GTRecordingStopCompletionHander)hander {
    self.completionHander = hander;
    [self.recorder stop];
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (self.completionHander) {
        self.completionHander(flag);
    }
}

- (void)saveRecordingWithName:(NSString *)name completionHander:(GTRecordingSaveCompletionHander)hander {
    
    NSTimeInterval timestamp = [NSDate timeIntervalSinceReferenceDate];
    NSString *fileName = [NSString stringWithFormat:@"%@-%f.caf",name,timestamp];
    NSString *docsDir = [self documentsDirectory];
    NSString *destPath = [docsDir stringByAppendingPathComponent:fileName];
    
    NSURL *srcUrl = self.recorder.url;
    NSURL *destUrl = [NSURL URLWithString:destPath];
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] copyItemAtURL:srcUrl toURL:destUrl error:&error];
    if (success) {
        hander(success,[GTMemo memoWithTitle:name url:destUrl]);
        [self.recorder prepareToRecord];
    } else {
        NSLog(@"save fail--%@",error);
        hander(NO,error);
    }
    
    
}

- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

#pragma mark - Playback audio

- (BOOL)playbackMemo:(GTMemo *)memo {
    
    [self.player stop];
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:memo.url error:&error];
    if (error) {
        return NO;
    }
    
    if (self.player) {
        [self.player play];
        return YES;
    }
    
    return NO;
}





@end
