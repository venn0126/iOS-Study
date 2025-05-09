//
//  NSURLRequest+TNAdditions.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import "NSURLRequest+TNAdditions.h"
#import <objc/runtime.h>

static const void *TNServiceKey = &TNServiceKey;


@implementation NSURLRequest (TNAdditions)

- (void)setService:(id<TNServiceProtocol>)service {
    objc_setAssociatedObject(self, TNServiceKey, service, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<TNServiceProtocol>)service {
    return objc_getAssociatedObject(self, TNServiceKey);
}

@end
