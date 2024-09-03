//
//  GTControllableCThread.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2024/9/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTControllableCThread : NSObject

/// 停止当前开启的子线程
- (void)gt_cstopThead;


/// 在当前子线程执行任务
- (void)gt_cexecuteTask:(void(^)(void))task;

@end

NS_ASSUME_NONNULL_END
