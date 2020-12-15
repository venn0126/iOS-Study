//
//  NSTimer+Extension.m
//  BioSaferID
//
//  Created by Wei Niu on 2018/8/30.
//  Copyright © 2018年 Fosafer. All rights reserved.
//

#import "NSTimer+Extension.h"

@implementation NSTimer (Extension)

+ (NSTimer *)fos_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval repeats:(BOOL)repeats block:(void (^)(NSTimer *))block{
    
    return [NSTimer scheduledTimerWithTimeInterval:inerval target:self selector:@selector(fos_blcokInvoke:) userInfo:[block copy] repeats:repeats];

}

+ (void)fos_blcokInvoke:(NSTimer *)timer {
    void (^block)(NSTimer *timer) = timer.userInfo;
    if (block) {
        block(timer);
    }
}



@end
