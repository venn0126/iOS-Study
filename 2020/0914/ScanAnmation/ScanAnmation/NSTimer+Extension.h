//
//  NSTimer+Extension.h
//  BioSaferID
//
//  Created by Wei Niu on 2018/8/30.
//  Copyright © 2018年 Fosafer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Extension)

+ (NSTimer *)fos_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval
                                   repeats:(BOOL)repeats
                                     block:(void(^)(NSTimer *timer))block;

@end
