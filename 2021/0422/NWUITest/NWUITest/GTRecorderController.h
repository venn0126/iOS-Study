//
//  GTRecorderController.h
//  NWUITest
//
//  Created by Augus on 2021/4/30.
//

#import <Foundation/Foundation.h>

@class GTMemo;

typedef void(^GTRecordingStopCompletionHander) (BOOL success);
typedef void (^GTRecordingSaveCompletionHander) (BOOL success,id  _Nullable memo);



NS_ASSUME_NONNULL_BEGIN

@interface GTRecorderController : NSObject

@property (nonatomic, copy, readonly) NSString *formattedCurrentTime;

// Record methods
- (BOOL)record;

- (void)pause;

- (void)stopWithCompletionHander:(GTRecordingStopCompletionHander)hander;

- (void)saveRecordingWithName:(NSString *)name completionHander:(GTRecordingSaveCompletionHander)hander;

// player method
- (BOOL)playbackMemo:(GTMemo *)memo;
@end

NS_ASSUME_NONNULL_END
