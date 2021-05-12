//
//  NWDispatchQueue.h
//  YPYDemo
//
//  Created by Augus on 2021/4/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NWDispatchQueue : NSObject

/**
 全局并发队列的最大并发数，默认4
 
 */
+ (NWDispatchQueue *)mainThreadQueue;

+ (NWDispatchQueue *)defaultThreadQueue;

+ (NWDispatchQueue *)lowGlobalQueue;

+ (NWDispatchQueue *)highGlobalQueue;

+ (NWDispatchQueue *)backGroundGlobalQueue;

#pragma mark -

/// max concurrent count,dafault 1
@property (nonatomic, assign, readonly)  NSUInteger concurrentCount;

- (instancetype)init;

/// a func return NWDispatchQueue instance by dispatch_queue_t
/// @param queue a queue
- (instancetype)initWithQueue:(dispatch_queue_t)queue;


/// a func return NWDispatchQueue instance by dispatch_queue_t and concurrentCount
/// @param queue a dispatch_queue_t
/// @param concurrentCount max concurrent count, > 1
- (instancetype)initWithQueue:(dispatch_queue_t)queue
              concurrentCount:(NSUInteger)concurrentCount;


/// sync
/// @param block a task of block
- (void)sync:(dispatch_block_t)block;


/// async
/// @param block a task of block
- (void)async:(dispatch_block_t)block;






@end

NS_ASSUME_NONNULL_END
