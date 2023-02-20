//
//  GTProxyTarget.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/20.
//

#import "GTProxyTarget.h"

@implementation GTProxyTarget

+ (instancetype)proxyWithTarget:(id)target {
    GTProxyTarget *proxy = [GTProxyTarget alloc];
    proxy.target = target;
    return proxy;
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    [invocation invokeWithTarget:self.target];
}


- (void)dealloc {
    
    NSLog(@"%s",__func__);
}

@end
