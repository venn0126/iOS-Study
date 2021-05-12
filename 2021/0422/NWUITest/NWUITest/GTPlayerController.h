//
//  GTPlayerController.h
//  NWUITest
//
//  Created by Augus on 2021/4/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GTPlayerController;
@protocol GTPlayerControllerDelegate <NSObject>


/**
 The func to callback to interruption begin for delegate
 
 @param player A intance of GTPlayerController
 
 @discussion this is a test

 */

- (void)playbackStoppedForPlayerController:(GTPlayerController *)player;


/// Handle interruption func for begin
/// @param player intance GTPlayerController
- (void)playbackBeganForPlayerController:(GTPlayerController *)player;


@end

@interface GTPlayerController : NSObject

@property (nonatomic, assign, readonly, getter=isPlaying)  BOOL nPlaying;
@property (nonatomic, weak) id<GTPlayerControllerDelegate> delegate;


// global methods
- (void)play;
- (void)stop;
- (void)adjustRate:(float)rate;

// specific methods
- (void)adjustPan:(float)pan forPlayerAtIndex:(NSUInteger)index;
- (void)adjustVolume:(float)volume forPlayerAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
