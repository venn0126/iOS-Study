//
//  GTControllableThead.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/20.
//

#import "GTControllableThead.h"


@interface GTInnerThead : NSThread

@end


@implementation GTInnerThead

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end

@interface GTControllableThead ()

/// 内部的子线程
@property (nonatomic, strong) GTInnerThead *innerThead;

/// 是否已经停止
@property (nonatomic, assign) BOOL isStoped;

@end

@implementation GTControllableThead

- (instancetype)init {
    self = [super init];
    if(!self) return nil;
    
    _isStoped = NO;
    
    __weak typeof(self)weakself = self;
    _innerThead = [[GTInnerThead alloc] initWithBlock:^{
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        while (weakself && !self.isStoped) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }];
    
    [_innerThead start];
    
    return self;
}


#pragma mark - Public Methods


- (void)gt_stopThead {
    
    if(!self.innerThead) return;
    [self performSelector:@selector(gt_innerStopThread) onThread:self.innerThead withObject:nil waitUntilDone:YES];
    
}


- (void)gt_executeTask:(void (^)(void))task {
    
    if(!self.innerThead || !task) return;
    
    [self performSelector:@selector(gt_innerExecuteTask:) onThread:self.innerThead withObject:task waitUntilDone:NO];
    
}



#pragma mark - Private Methods

- (void)gt_innerExecuteTask:(void (^)(void))task {
    
    task();
}


- (void)gt_innerStopThread {
    
    self.isStoped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThead = nil;
}


- (void)dealloc {
    
    NSLog(@"%s",__func__);
    [self gt_stopThead];
}
@end
