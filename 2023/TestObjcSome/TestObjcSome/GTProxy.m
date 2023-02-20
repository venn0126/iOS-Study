//
//  GTProxy.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/20.
//

#import "GTProxy.h"

@implementation GTProxy

+ (instancetype)proxyWithTarget:(id)target {
    GTProxy *proxy = [[GTProxy alloc] init];
    proxy.target = target;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    return self.target;
}



@end
