//
//  GTIvarModel.m
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTIvarModel.h"
#import "GTTypeParser.h"
#import "GTParseType.h"

@implementation GTIvarModel

+ (instancetype)modelWithIvar:(Ivar)ivar {
    return [[self alloc] initWithIvar:ivar];
}

- (instancetype)initWithIvar:(Ivar)ivar {
    if (self = [self init]) {
        _backing = ivar;
        _name = @(ivar_getName(ivar));
        _type = [GTTypeParser typeForEncoding:(ivar_getTypeEncoding(ivar) ?: "")];
    }
    return self;
}

- (GTSemanticString *)semanticString {
    return [self.type semanticStringForVariableName:self.name];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        __typeof(self) casted = (__typeof(casted))object;
        Ivar const sVar = self.backing, cVar = casted.backing;
        return [self.name isEqual:casted.name] &&
        (strstr(ivar_getTypeEncoding(sVar), ivar_getTypeEncoding(cVar)) == 0);
    }
    return NO;
}

- (NSString *)description {
    return [self.type stringForVariableName:self.name];
}

@end
