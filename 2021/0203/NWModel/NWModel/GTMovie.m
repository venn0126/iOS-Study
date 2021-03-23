//
//  GTMovie.m
//  NWModel
//
//  Created by Augus on 2021/3/17.
//

#import "GTMovie.h"
#import <objc/message.h>

@implementation GTMovie

- (void)encodeWithCoder:(NSCoder *)coder {
    // 归档
    unsigned int count;
    Ivar *nwIvars = class_copyIvarList([self class], &count);
    if (count <= 0) {
        return;
    }
    for (int i = 0; i < count; i++) {
        Ivar nwIvar = nwIvars[i];
        const char *name = ivar_getName(nwIvar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        
        [coder encodeObject:value forKey:key];
        
    }
    
    free(nwIvars);
    nwIvars = NULL;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    
    // 解档
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // 获取ivar
    unsigned int count;
    Class cls = [self class];
    
    Ivar *nwIvars = class_copyIvarList(cls, &count);
    
    if (count <= 0) {
        return nil;
    }
    
    for (int i = 0; i < count; i++) {
        // 取出i位置对应的成员变量
        Ivar nwIvar = nwIvars[i];
        
        // 从ivar 取出成员变量名字
        const char *nwIvarName = ivar_getName(nwIvar);
        
        // c++ ---> oc
        NSString *key = [NSString stringWithUTF8String:nwIvarName];
        id value = [coder decodeObjectForKey:key];
        
        [self setValue:value forKey:key];
    }
    
    free(nwIvars);
    nwIvars = NULL;
    
    return self;
}


- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@ : %@ (%@-%@-%@-%@)",@(__PRETTY_FUNCTION__),@(__LINE__),_movieName,_movieId,_user,_userArray];
}


@end
