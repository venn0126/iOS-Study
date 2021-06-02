//
//  QiAudioPlayer.h
//  NWUITest
//
//  Created by Augus on 2021/6/2.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QiAudioPlayer : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign)  BOOL needRunBackground;
@property (nonatomic, strong) AVAudioPlayer *player;



@end

NS_ASSUME_NONNULL_END
