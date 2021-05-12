//
//  NWSpeechController.h
//  NWUITest
//
//  Created by Augus on 2021/4/30.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NWSpeechController : NSObject

@property (nonatomic, strong, readonly) AVSpeechSynthesizer *synthesizer;

+ (instancetype)speechController;

- (void)beginConversation;


@end

NS_ASSUME_NONNULL_END
