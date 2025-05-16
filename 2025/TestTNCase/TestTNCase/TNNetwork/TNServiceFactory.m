//
//  TNServiceFactory.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import "TNServiceFactory.h"
#import <TNMediator/TNMediator.h>


@interface TNServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id<TNServiceProtocol>> *serviceStorage;

@end

@implementation TNServiceFactory

#pragma mark - 懒加载
- (NSMutableDictionary *)serviceStorage {
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}

#pragma mark - 生命周期
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static TNServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TNServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - 公共方法
- (id<TNServiceProtocol>)serviceWithIdentifier:(NSString *)identifier {
    if (self.serviceStorage[identifier] == nil) {
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    return self.serviceStorage[identifier];
}


#pragma mark - 私有方法
- (id<TNServiceProtocol>)newServiceWithIdentifier:(NSString *)identifier {
    // 尝试通过CTMediator创建服务
    id<TNServiceProtocol> service = [TNMS() performTarget:identifier
                                                                       action:identifier
                                                                       params:nil
                                                            shouldCacheTarget:NO];
    return service;
}

@end
