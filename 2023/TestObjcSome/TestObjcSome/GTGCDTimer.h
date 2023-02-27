//
//  GTGCDTimer.h
//  TestObjcSome
//
//  Created by Augus on 2023/2/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTGCDTimer : NSObject

+ (NSString *)gt_executeTask:(void(^)(void))task
                 start:(NSTimeInterval)start
              interval:(NSTimeInterval)interval
               repeats:(BOOL)repeats
                 async:(BOOL)async;


+ (NSString *)gt_executeTask:(id)target
                 selector:(SEL)selector
                 start:(NSTimeInterval)start
              interval:(NSTimeInterval)interval
               repeats:(BOOL)repeats
                 async:(BOOL)async;


+ (void)gt_cancelTask:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
