//
//  FSGlobal.h
//  fosFloatView
//
//  Created by Augus on 2020/11/11.
//

#ifndef FSGlobal_h
#define FSGlobal_h

// 单例
#define singtonInterface  + (instancetype)shareInstance;

#define singtonImplement(class) \
\
static class *_shareInstance; \
\
+ (instancetype)shareInstance { \
\
if(_shareInstance == nil) {\
_shareInstance = [[class alloc] init]; \
} \
return _shareInstance; \
} \
\
+(instancetype)allocWithZone:(struct _NSZone *)zone { \
\
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_shareInstance = [super allocWithZone:zone]; \
}); \
\
return _shareInstance; \
\
}

//  模型序列化
#define FSModelInit(name) \
- (instancetype) initWithDict:(NSDictionary *) dict;\
+ (instancetype) name##WithDict:(NSDictionary *) dict;

#define FSModelImplement(name)\
-(instancetype)initWithDict:(NSDictionary *)dict\
{\
    if (self = [super init]) {\
        [self setValuesForKeysWithDictionary:dict];\
    }\
    return self;\
}\
+(instancetype)name##WithDict:(NSDictionary *)dict\
{\
    return [[self alloc] initWithDict:dict];\
}




#endif /* FSGlobal_h */
