//
//  QiAudioPlayer.m
//  NWUITest
//
//  Created by Augus on 2021/6/2.
//

#import "QiAudioPlayer.h"

@implementation QiAudioPlayer

+ (instancetype)sharedInstance {
    static QiAudioPlayer *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[QiAudioPlayer alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    return self;
}


- (void)initPlayer {
    [self.player prepareToPlay];
}

#pragma mark - Getter

- (AVAudioPlayer *)player {
    
    if (!_player) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"SomethingJustLikeThis" withExtension:@"mp3"];
        AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        audioPlayer.numberOfLoops = NSUIntegerMax;
        _player = audioPlayer;
    }
    return _player;
}

@end
