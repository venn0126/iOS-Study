//
//  NSTimer+Extension.h
//  TestGuideLayout
//
//  Created by Augus on 2020/12/5.
//

#import <Foundation/Foundation.h>

typedef void(^timerBlock) (NSTimer * _Nullable timer);

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (Extension)

/**
 
 可以看把target由之前原始的vc对象，转换成了timer对象，从而打破了双向引用。
 
 */

+ (NSTimer *)weak_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         repeats:(BOOL)repeats
                                           block:(timerBlock)block;


@end

NS_ASSUME_NONNULL_END
