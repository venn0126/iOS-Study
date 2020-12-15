//
//  NSTimer+Extension.m
//  TestGuideLayout
//
//  Created by Augus on 2020/12/5.
//

#import "NSTimer+Extension.h"

@implementation NSTimer (Extension)

+ (NSTimer *)weak_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         repeats:(BOOL)repeats
                                           block:(timerBlock)block
{
    return [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(blockForTimer:) userInfo:[block copy] repeats:repeats];
}


- (void)blockForTimer:(NSTimer *)timer {
    
    void(^block)(NSTimer *timer) = timer.userInfo;
    if (block) {
        block(timer);
    }
    
}

/**
 
 2020-12-07 13:18:45.147140+0800----0------2020-12-07 13:18:46.540683+0800(-8)
 

 2020-12-07 13:18:48.075543+0800 ----1-----2020-12-07 13:18:51.440066+0800-----(2)(-8)
 
 2020-12-07 13:18:55.745434+0800 最后截止时间

 2020-12-07 13:18:55.564700+0800----3------2020-12-07 13:18:55.745434+0800
 
 
                                                                                        
 2020-12-07 17:07:27.081764+0800 -----0------2020-12-07 17:07:25.479989+0800----2020-12-07 17:07:21.718869+0800--0
 130
 
 
 
 
 */

@end
