//
//  GTObjectType.m
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTObjectType.h"

@implementation GTObjectType

- (GTSemanticString *)semanticStringForVariableName:(NSString *)varName {
    GTSemanticString *build = [GTSemanticString new];
    GTSemanticString *modifiersString = [self modifiersSemanticString];
    if (modifiersString.length > 0) {
        [build appendSemanticString:modifiersString];
        [build appendString:@" " semanticType:GTSemanticTypeStandard];
    }
    
    BOOL const hasClassName = (self.className != nil);
    
    if (hasClassName) {
        [build appendString:self.className semanticType:GTSemanticTypeClass];
    } else {
        [build appendString:@"id" semanticType:GTSemanticTypeKeyword];
    }
    
    NSArray<NSString *> *protocolNames = self.protocolNames;
    NSUInteger const protocolNameCount = protocolNames.count;
    if (protocolNames.count > 0) {
        [build appendString:@"<" semanticType:GTSemanticTypeStandard];
        [protocolNames enumerateObjectsUsingBlock:^(NSString *protocolName, NSUInteger idx, BOOL *stop) {
            [build appendString:protocolName semanticType:GTSemanticTypeProtocol];
            if ((idx + 1) < protocolNameCount) {
                [build appendString:@", " semanticType:GTSemanticTypeStandard];
            }
        }];
        [build appendString:@">" semanticType:GTSemanticTypeStandard];
    }
    if (hasClassName) {
        [build appendString:@" *" semanticType:GTSemanticTypeStandard];
    }
    
    if (varName != nil) {
        if (!hasClassName) {
            [build appendString:@" " semanticType:GTSemanticTypeStandard];
        }
        [build appendString:varName semanticType:GTSemanticTypeVariable];
    }
    return build;
}

- (NSSet<NSString *> *)classReferences {
    NSString *className = self.className;
    if (className != nil) {
        return [NSSet setWithObject:className];
    }
    return nil;
}

- (NSSet<NSString *> *)protocolReferences {
    NSArray<NSString *> *protocolNames = self.protocolNames;
    if (protocolNames != nil) {
        return [NSSet setWithArray:protocolNames];
    }
    return nil;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        __typeof(self) casted = (__typeof(casted))object;
        return (self.modifiers == casted.modifiers || [self.modifiers isEqualToArray:casted.modifiers]) &&
        (self.className == casted.className || [self.className isEqualToString:casted.className]) &&
        (self.protocolNames == casted.protocolNames || [self.protocolNames isEqualToArray:casted.protocolNames]);
    }
    return NO;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p> {modifiers: '%@', className: '%@', protocolNames: %@}",
            [self class], self, [self modifiersString], self.className, self.protocolNames];
}


@end
