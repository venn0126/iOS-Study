//
//  FOSProxy.m
//  JRTT
//
//  Created by Augus on 2020/6/22.
//  Copyright © 2020 fosafer. All rights reserved.
//

#import "FOSProxy.h"

@implementation FOSProxy

+ (instancetype)proxyWithTarget:(id)aTarget {
    FOSProxy *proxy = [FOSProxy alloc];
    proxy.target = aTarget;
    NSLog(@"0--%s",__func__);
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    
    NSLog(@"1--%s",__func__);
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    NSLog(@"2--%s",__func__);
    [invocation invokeWithTarget:self.target];
}

@end
