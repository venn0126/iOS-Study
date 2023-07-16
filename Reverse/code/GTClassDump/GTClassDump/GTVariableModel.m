//
//  GTVariableModel.m
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTVariableModel.h"
#import "GTParseType.h"

@implementation GTVariableModel

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        __typeof(self) casted = (__typeof(casted))object;
        return (self.name == casted.name || [self.name isEqualToString:casted.name]) &&
        (self.type == casted.type || [self.type isEqual:casted.type]);
    }
    return NO;
}

- (NSString *)description {
    return [self.type stringForVariableName:self.name];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p> {name: '%@', type: %@}",
            [self class], self, self.name, self.type.debugDescription];
}

@end
