//
//  NWSpeechController.m
//  NWUITest
//
//  Created by Augus on 2021/4/30.
//

#import "NWSpeechController.h"

@interface NWSpeechController ()

@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
@property (nonatomic, copy) NSArray *voices;
@property (nonatomic, copy) NSArray *speechStrings;


@end

@implementation NWSpeechController

+ (instancetype)speechController {
    return [[self alloc] init];
}

- (id)init {
    self = [super init];
    if (!self) return nil;
    _synthesizer = [[AVSpeechSynthesizer alloc] init];
    _voices = @[[AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"],[AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"]];
    _speechStrings = [self buildSpeechStrings];
    
    

    
    
    return self;
}

- (NSArray *)buildSpeechStrings {
    
    return @[@"Hi,AVFoundation. How are you",
             @"I am well,thank you,and you",
             @"Are you exctied about the book",
             @"Very! i ahve always flet"];
}


- (void)beginConversation {
    
    for (int i = 0; i < _speechStrings.count; i++) {
        
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:_speechStrings[i]];
        
        utterance.voice = self.voices[i % 2];
        // 播放语音内容的速率
        utterance.rate = 0.4f;
        // 播放特定语句时，改变声音的音调
        utterance.pitchMultiplier = 0.8f;
        // 播放下一句之前有段时间的暂停
        utterance.postUtteranceDelay = 0.1f;
        
        NSLog(@"---%@",@(i));
        [self.synthesizer speakUtterance:utterance];
        
    }
}
@end
