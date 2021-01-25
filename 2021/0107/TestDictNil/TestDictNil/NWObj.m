//
//  NWObj.m
//  TestDictNil
//
//  Created by Augus on 2021/1/8.
//

#import "NWObj.h"
#import <objc/runtime.h>
#import "TianObj.h"

void (gOriginalViewDidAppear)(id, SEL, BOOL);

@interface NWObj ()

@property (nonatomic, copy) NSString *requestId;
@property (nonatomic, copy) NSString *name;



@end


@implementation NWObj

+ (void)load {
    
    NSLog(@"nw obj--%s",__func__);
}

- (instancetype)init{
    return [super init];
}

- (instancetype)initWithRequestId:(NSString *)requestId name:(NSString *)name {
    if (self = [super init]) {
        _requestId = requestId;
        _name = name;
        
    }
    return self;
}

- (instancetype)initWithRequestId:(NSString *)requestId {
    return [self initWithRequestId:requestId name:nil];
}

- (void)fooMethod {
    
    NSLog(@"foo method");

}


+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(foo)) {
    
        IMP fooIMP = imp_implementationWithBlock(^(id _self){
            NSLog(@"foo block");
            });
        
        
//        Method origMethod = class_getInstanceMethod(self, @selector(fooMethod));
//        class_addMethod([self class], sel, class_getMethodImplementation([self class], @selector(fooMethod)), method_getTypeEncoding(origMethod));
        
//        class_addMethod([self class], sel, fooIMP, "v@:");
        
        return NO;
    }
    return [super resolveInstanceMethod:sel];
}

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//
//
//    if (aSelector == @selector(foo)) {
////        return [TianObj new];
//        return nil;
//    }
//
//    return [super forwardingTargetForSelector:aSelector];
//}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
        
    NSString *sel = NSStringFromSelector(aSelector);
    //手动生成签名
    if ([sel isEqualToString:@"foo"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }else {
        return [super methodSignatureForSelector:aSelector];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    SEL sel = anInvocation.selector;
    if ([[TianObj new] respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:[TianObj new]];
    }else{
        [self doesNotRecognizeSelector:sel];
    }
    
}


@end
