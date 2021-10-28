//
//  FOSSpeechRecognizer.h
//  AsrDemo
//
//  Created by Fosafer on 7/8/15.
//  Copyright (c) 2015 FoSafer. All rights reserved.
//

#include <AudioToolbox/AudioToolbox.h>
//#import "FOSFosafer.h"

@class FOSSpeechRecognizer;

@protocol FOSSpeechRecognizerDelegate <NSObject>

@optional

- (void)recognizerDidStartListening:(FOSSpeechRecognizer *)recognizer;

- (void)recognizerDidStopListening:(FOSSpeechRecognizer *)recognizer;

- (void)recognizer:(FOSSpeechRecognizer *)recognizer partialResults:(NSDictionary *)results;

- (void)recognizer:(FOSSpeechRecognizer *)recognizer results:(NSDictionary *)results;

- (void)recognizer:(FOSSpeechRecognizer *)recognizer error:(NSError *)error;

- (void)recognizer:(FOSSpeechRecognizer *)recognizer collectedAudios:(NSArray *)audios;

@end

@interface FOSSpeechRecognizer : NSObject

@property (nonatomic, weak) id<FOSSpeechRecognizerDelegate> delegate;

- (void)startListening:(NSDictionary *)params;

- (void)stopListening;

/**
 *  获取当前录音的AudioQueueRef，只有在`- (void)recognizerDidStartListening:(FOSSpeechRecognizer *)recognizer;`回调之后
 *  才能够保证正常获取到
 *
 *  @return AudioQueueRef
 */
- (AudioQueueRef)queue;

- (void)cancel;

@end
