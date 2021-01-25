//
//  UserCenter.m
//  TestDictNil
//
//  Created by Augus on 2021/1/10.
//

#import "UserCenter.h"

@interface UserCenter ()

{
    // 定义一个并发队列
    dispatch_queue_t concurrent_queue;
    
    // 用户数据中心
    NSMutableDictionary *_userMulDict;
}

@end

@implementation UserCenter

- (instancetype)init{
    if (self = [super init]) {
        const char * read_write_queue;
        concurrent_queue = dispatch_queue_create(read_write_queue, DISPATCH_QUEUE_CONCURRENT);
        _userMulDict = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (id)nw_objectForKey:(NSString *)key {
    __block id obj;
    dispatch_sync(concurrent_queue, ^{
        obj = [_userMulDict objectForKey:key];
    });
    return  obj;
}


- (void)nw_setObject:(id)object forKey:(id)key {
    
    dispatch_async(concurrent_queue, ^{
        [_userMulDict setObject:object forKey:key];
    });
    
}
@end
