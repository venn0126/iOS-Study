//
//  Global.h
//  QQPage
//
//  Created by 李海群 on 2017/7/6.
//  Copyright © 2017年 李海群. All rights reserved.
//

#ifndef Global_h
#define Global_h

#define HQInitH(name) \
- (instancetype) initWithDict:(NSDictionary *) dict;\
+ (instancetype) name##WithDict:(NSDictionary *) dict;

#define HQNameH(name)\
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

#endif /* Global_h */
