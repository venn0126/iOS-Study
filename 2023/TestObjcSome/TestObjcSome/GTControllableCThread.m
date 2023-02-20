//
//  GTControllableCThread.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/20.
//

#import "GTControllableCThread.h"

@interface GTInnerCThead : NSThread

@end


@implementation GTInnerCThead

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end


@interface GTControllableCThread ()

/// 内部的子线程
@property (nonatomic, strong) GTInnerCThead *innerThead;

@end

@implementation GTControllableCThread

- (instancetype)init {
    self = [super init];
    if(!self) return nil;
    
    _innerThead = [[GTInnerCThead alloc] initWithBlock:^{
        
            // 创建runloop的source的上下文
            CFRunLoopSourceContext context = {0};
            
            // 创建runloop的source
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
            
            // 为当前的runloop添加source
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            
            
            // 释放source
            CFRelease(source);
            
            // 启动runloop
            // Boolean returnAfterSourceHandled:false>>>代表执行完source后，就退出runloop
            // Boolean returnAfterSourceHandled:true>>>代表执行完source后，不退出runloop
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
    }];
    
    [_innerThead start];
    
    return self;
}


#pragma mark - Public Methods


- (void)gt_cstopThead {
    
    if(!self.innerThead) return;
    [self performSelector:@selector(gt_cinnerStopThread) onThread:self.innerThead withObject:nil waitUntilDone:YES];
    
}


- (void)gt_cexecuteTask:(void (^)(void))task {
    
    if(!self.innerThead || !task) return;
    
    [self performSelector:@selector(gt_cinnerExecuteTask:) onThread:self.innerThead withObject:task waitUntilDone:NO];
    
}



#pragma mark - Private Methods

- (void)gt_cinnerExecuteTask:(void (^)(void))task {
    
    task();
}


- (void)gt_cinnerStopThread {
    
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThead = nil;
}


- (void)dealloc {
    
    NSLog(@"%s",__func__);
    [self gt_cstopThead];
}




@end
