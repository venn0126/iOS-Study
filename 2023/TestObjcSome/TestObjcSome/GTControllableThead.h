//
//  GTControllableThead.h
//  TestObjcSome
//
//  Created by Augus on 2023/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTControllableThead : NSObject

/// 停止当前开启的子线程
- (void)gt_stopThead;


/// 在当前子线程执行任务
- (void)gt_executeTask:(void(^)(void))task;

@end

NS_ASSUME_NONNULL_END
