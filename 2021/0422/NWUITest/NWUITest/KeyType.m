//
//  KeyType.m
//  NWUITest
//
//  Created by Augus on 2021/6/11.
//

#import "KeyType.h"

@implementation KeyType

- (instancetype)initWithKeyName:(NSString *)keyName {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _keyName = keyName;
    return self;
}

- (NSUInteger)hash {
    NSLog(@"%s : %d",__func__,__LINE__);
    return [super hash];
}

- (BOOL)isEqual:(id)object {
    /**
     重写equal的规则
     1.判断对象是否相等
     2.判断是否为空
     3.判断类型是否相当
     4.判断内部属性是否相等
     
     */
    NSLog(@"%s : %d",__func__,__LINE__);
    
    if (self == object) {
        return YES;
    } else if(self == nil || object == nil || ![object isKindOfClass:[self class]]){
        return NO;
    } else {
        KeyType *temp = (KeyType *)object;
        return _keyName == temp.keyName;
    }
    
//    return [super isEqual:object];
}


- (id)copyWithZone:(NSZone *)zone {
    

    NSLog(@"%s : %d",__func__,__LINE__);
    KeyType *type = [[KeyType alloc] initWithKeyName:self.keyName];
    return type;
}
@end
