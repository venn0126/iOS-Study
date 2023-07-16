//
//  GTPropertyAttribute.m
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTPropertyAttribute.h"

@implementation GTPropertyAttribute

+ (instancetype)attributeWithName:(NSString *)name value:(NSString *)value {
    return [[self alloc] initWithName:name value:value];
}

- (instancetype)initWithName:(NSString *)name value:(NSString *)value {
    if (self = [self init]) {
        _name = name;
        _value = value;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        __typeof(self) casted = (__typeof(casted))object;
        return (self.name == casted.name || [self.name isEqual:casted.name]) &&
        (self.value == casted.value || [self.value isEqual:casted.value]);
    }
    return NO;
}

- (NSString *)description {
    NSString *name = self.name;
    NSString *value = self.value;
    if (value != nil) {
        return [[name stringByAppendingString:@"="] stringByAppendingString:value];
    }
    return name;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p> {name: '%@', value: '%@'}",
            [self class], self, self.name, self.value];
}

@end
