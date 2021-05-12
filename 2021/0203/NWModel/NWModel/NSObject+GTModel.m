//
//  NSObject+GTModel.m
//  NWModel
//
//  Created by Augus on 2021/3/17.
//

#import "NSObject+GTModel.h"
#import <objc/message.h>

@implementation NSObject (GTModel)

+ (id)gt_modelWithDictionary:(NSDictionary *)dictionary {
    
    if (!dictionary || dictionary == (id)kCFNull) {
        return nil;
    }
    
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    // 创建对应模型对象
    id model = [[self alloc] init];
    unsigned int count;
    
    // 获取成员变量数组
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        
        const char *name = ivar_getName(ivar);
        NSString *ivarName = [NSString stringWithUTF8String:name];
        // _name
        NSString *key = [ivarName substringFromIndex:1];
        // 从字典中根据key取出对应的value赋值给模型
        id value = dictionary[key];
        
        // 计算成员变量类型
        const char *type = ivar_getTypeEncoding(ivar);
        NSString *ivarType = [NSString stringWithUTF8String:type];
        
        // 二级变换 字典中有字典属性 与需要变换
        // 根据value 判断是否是字典
        
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType containsString:@"NS"]) {// 二级属性是字典
            
            // 字典对象 并且属性名对应的是自定义类型
            // 处理类型字符串 // @"NWUser"---》NWUser
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            // 自定义对象 并且值是字典
            // vaule:user
            // 获取模型 （user）类对象
            
            Class modelClass = NSClassFromString(ivarType);
            
            // 字典转模型
            if (modelClass) {
                value = [modelClass gt_modelWithDictionary:value];
            }

        }
        
        // 三级转换 NSArray中也是字典
        if ([value isKindOfClass:[NSArray class]]) {
            // [user,user,user]
            // 先从数组中取出
            NSArray *tmpArray = (NSArray *)value;
            NSMutableArray *dataArray = [NSMutableArray array];
            for (id item in tmpArray) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    id md = [self gt_modelWithDictionary:item];
                    [dataArray addObject:md];
                }
            }
        }
        
        // kvc 字典转模型
        if (value) {
            [model setValue:value forKey:key];
        }
    }
    return model;
    
}



@end
