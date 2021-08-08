//
//  NWDispatchQueue.m
//  YPYDemo
//
//  Created by Augus on 2021/4/14.
//

#import "NWDispatchQueue.h"

/// Default the smallest concurrent count
static const NSUInteger kDefaultConcurrentCount = 1;

/// Default global queue concurrent count
static const NSUInteger kGlobalConcurrentCount = 4;

/// The max concurrent count
static const NSUInteger kMaxConcurrentCount = 32;

@interface NWDispatchQueue ()

@property (nonatomic, strong) dispatch_queue_t serialQueue;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, assign)  NSUInteger concurrentCount;



@end

@implementation NWDispatchQueue

+ (NWDispatchQueue *)mainThreadQueue {
    
    static NWDispatchQueue *queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[NWDispatchQueue alloc] initWithQueue:dispatch_get_main_queue()];
    });
    
    return queue;
}

+ (NWDispatchQueue *)highGlobalQueue {
    
    static NWDispatchQueue *queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[NWDispatchQueue alloc] initWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0) concurrentCount:kGlobalConcurrentCount];
    });
    return queue;
}

+ (NWDispatchQueue *)defaultThreadQueue {
    static NWDispatchQueue *queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[NWDispatchQueue alloc] initWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) concurrentCount:kGlobalConcurrentCount];
    });
    return queue;
}

+ (NWDispatchQueue *)lowGlobalQueue {
    
    static NWDispatchQueue *queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        queue = [[NWDispatchQueue alloc] initWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0) concurrentCount:kGlobalConcurrentCount];

    });
    
    return queue;
}

+ (NWDispatchQueue *)backGroundGlobalQueue {
    static NWDispatchQueue *queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        queue = [[NWDispatchQueue alloc] initWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) concurrentCount:kGlobalConcurrentCount];

    });
    
    return queue;
}

#pragma mark - Life

- (instancetype)init {
    return [self initWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) concurrentCount:kDefaultConcurrentCount];
}

- (instancetype)initWithQueue:(dispatch_queue_t)queue {
    return [self initWithQueue:queue concurrentCount:kDefaultConcurrentCount];
}

- (instancetype)initWithQueue:(dispatch_queue_t)queue concurrentCount:(NSUInteger)concurrentCount {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    if (!queue) {
        _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
    }else {
        _queue = queue;
    }
    
    _concurrentCount = MIN(concurrentCount, kMaxConcurrentCount);
    if (concurrentCount < kDefaultConcurrentCount) {
        concurrentCount = kDefaultConcurrentCount;
    }
    
    _concurrentCount = concurrentCount;
    
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(concurrentCount);
    }
    
    if (!_serialQueue) {
        const char *label = [[NSString stringWithFormat:@"com.augus.serial_%p",self] UTF8String];
        _serialQueue = dispatch_queue_create(label, 0);
    }
    
    return self;
}

- (void)sync:(dispatch_block_t)block {
    if (!block) {
        return;
    }
    dispatch_sync(_serialQueue, ^{
       
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER); // semaphore -1
        dispatch_sync(self.queue, ^{
           
            if (block) {
                block();
            }
            
            dispatch_semaphore_signal(self.semaphore); // semaphore +1
        });
    });
    
}

- (void)async:(dispatch_block_t)block {
    
    if (!block) {
        return;
    }
    
    dispatch_async(_serialQueue, ^{
       
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(self.queue, ^{
           
            if (block) {
                block();
            }
            dispatch_semaphore_signal(self.semaphore);
        });
    });
}

@end
