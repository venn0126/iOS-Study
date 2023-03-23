//
//  NSObject+SNSafeKVO.m
//  TestObjcSome
//
//  Created by Augus on 2023/3/22.
//

#import "NSObject+SNSafeKVO.h"
#import <objc/runtime.h>

/// 监听者的代理
@interface SNObserverProxy : NSObject {
    __weak id _observer;
    __weak id _observeredObj;
    NSMutableSet *_keypaths;
    dispatch_semaphore_t _semaphoreForKeyPath;
}


/// 构造便利方法
/// - Parameters:
///   - obj: 监听者
///   - observeredObj: 被监听者
- (instancetype)initWithObserver:(id)obj observeredObj:(id)observeredObj;

- (void)proxy_addKeyPath:(NSString *)keyPath
                 options:(NSKeyValueObservingOptions)options
                 context:(void *)context;

- (void)proxy_removeObserver:(NSObject *)observer
                  forKeyPath:(NSString *)keyPath
                     context:(void *)context;

@end

/// 被监听者的释放监听者
@interface SNObserveredDeallocListener : NSObject


/// 构造便利方法
/// - Parameter obj: 被监听者
- (instancetype)initWithObserveredObject:(id)obj;
- (void)addProxy:(SNObserverProxy *)proxy;

@end

#pragma mark - NSObject (SNSafeKVO)

static dispatch_semaphore_t kAugusKVOProxySemaphore;

@implementation NSObject (SNSafeKVO)

- (void)augus_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(void *)context {
    if (!observer || !keyPath.length ||
        ![observer respondsToSelector:@selector(observeValueForKeyPath:ofObject:change:context:)]) {
        return;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kAugusKVOProxySemaphore = dispatch_semaphore_create(1);
    });
    
    // Using lock to prevent error of calling in multithread
    dispatch_semaphore_wait(kAugusKVOProxySemaphore, DISPATCH_TIME_FOREVER);
    SNObserverProxy *proxy = [observer augus_observerProxyWithKey:(__bridge const void *)(self)];
    if (!proxy) {
        proxy = [[SNObserverProxy alloc] initWithObserver:observer observeredObj:self];
        [observer setAugus_observerProxy:proxy key:(__bridge const void *)(self)];
    }
    SNObserveredDeallocListener *listener = [self augus_observeredDeallocLinstener];
    if (!listener) {
        listener = [[SNObserveredDeallocListener alloc] initWithObserveredObject:self];
        [self setAugus_observeredDeallocLinstener:listener];
    }
    dispatch_semaphore_signal(kAugusKVOProxySemaphore);
    
    [listener addProxy:proxy];
    [proxy proxy_addKeyPath:keyPath
                    options:options
                    context:context];
}

- (void)augus_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context {
    if (!observer || !keyPath.length) {
        return;
    }
    SNObserverProxy *proxy = [observer augus_observerProxyWithKey:(__bridge const void *)(self)];
    [proxy proxy_removeObserver:observer forKeyPath:keyPath context:context];
}

- (void)augus_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    [self augus_removeObserver:observer forKeyPath:keyPath context:nil];
}

- (SNObserverProxy *)augus_observerProxyWithKey:(const void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)setAugus_observerProxy:(SNObserverProxy *)proxy key:(const void *)key {
    objc_setAssociatedObject(self, key, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SNObserveredDeallocListener *)augus_observeredDeallocLinstener {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAugus_observeredDeallocLinstener:(SNObserveredDeallocListener *)obj {
    objc_setAssociatedObject(self, @selector(augus_observeredDeallocLinstener), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end


@implementation SNObserverProxy

- (instancetype)initWithObserver:(id)obj observeredObj:(id)observeredObj {
    self = [super init];
    if (self) {
        _observer = obj;
        _observeredObj = observeredObj;
        _keypaths = [NSMutableSet set];
        _semaphoreForKeyPath = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)dealloc {
    [self removeSelfOberseringWhenSelfDealloc];
}

- (void)removeSelfOberseringWhenSelfDealloc {
    [self removeSelfObserveringInfoWithObserveredObject:_observeredObj];
}

- (void)removeSelfObserveringInfoWithObserveredObject:(id)observeredObj {
    dispatch_semaphore_wait(_semaphoreForKeyPath, DISPATCH_TIME_FOREVER);
    if (!observeredObj) {
        dispatch_semaphore_signal(_semaphoreForKeyPath);
        return;
    }
    id obj = observeredObj;
    for (NSString *keypath in _keypaths) {
        [obj removeObserver:self forKeyPath:keypath];
    }
    [_keypaths removeAllObjects];
    [_observer setAugus_observerProxy:nil key:(__bridge const void *)obj];
    dispatch_semaphore_signal(_semaphoreForKeyPath);
}

#pragma mark - KVO transmit
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([_keypaths containsObject:keyPath]) {
        if (_observer && [_observer respondsToSelector:@selector(observeValueForKeyPath:ofObject:change:context:)]) {
            [_observer observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}

#pragma mark - Public methods
- (void)proxy_addKeyPath:(NSString *)keyPath
                 options:(NSKeyValueObservingOptions)options
                 context:(void *)context {
    dispatch_semaphore_wait(_semaphoreForKeyPath, DISPATCH_TIME_FOREVER);
    if (![_keypaths containsObject:keyPath]) {
        [_keypaths addObject:keyPath];
        [_observeredObj addObserver:self forKeyPath:keyPath options:options context:context];
    }
    dispatch_semaphore_signal(_semaphoreForKeyPath);
}

- (void)proxy_removeObserver:(NSObject *)observer
                  forKeyPath:(NSString *)keyPath
                     context:(void *)context {
    dispatch_semaphore_wait(_semaphoreForKeyPath, DISPATCH_TIME_FOREVER);
    if (_observeredObj && [_keypaths containsObject:keyPath]) {
        [_observeredObj removeObserver:self forKeyPath:keyPath context:context];
        [_keypaths removeObject:keyPath];
    }
    if (_keypaths.count <= 0 && _observer && _observeredObj) {
        [_observer setAugus_observerProxy:nil key:(__bridge const void *)(_observeredObj)];
    }
    dispatch_semaphore_signal(_semaphoreForKeyPath);
}

- (void)augus_removeObersersWhenObserveredObjectDealloc:(id)observeredObj {
    [self removeSelfObserveringInfoWithObserveredObject:observeredObj];
}

@end


@implementation SNObserveredDeallocListener {
    __unsafe_unretained id _observeredObj;
    // Save proxy in weak way
    NSHashTable *_proxyHashTable;
}

- (instancetype)initWithObserveredObject:(id)obj {
    self = [super init];
    if (self) {
        _observeredObj = obj;
        _proxyHashTable = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (void)dealloc {
    NSArray *array = [_proxyHashTable allObjects];
    for (SNObserverProxy *proxy in array) {
        [proxy augus_removeObersersWhenObserveredObjectDealloc:_observeredObj];
    }
    _observeredObj = nil;
}

- (void)addProxy:(SNObserverProxy *)proxy {
    if (![_proxyHashTable containsObject:proxy]) {
        [_proxyHashTable addObject:proxy];
    }
}

@end




