//
//  GTBlockType.m
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTBlockType.h"

@implementation GTBlockType

- (GTSemanticString *)semanticStringForVariableName:(NSString *)varName {
    GTSemanticString *build = [GTSemanticString new];
    GTSemanticString *modifiersString = [self modifiersSemanticString];
    
    if (self.returnType != nil && self.parameterTypes != nil) {
        [build appendSemanticString:[self.returnType semanticStringForVariableName:nil]];
        [build appendString:@" (^" semanticType:GTSemanticTypeStandard];
        
        if (modifiersString.length > 0) {
            [build appendSemanticString:modifiersString];
        }
        if (modifiersString.length > 0 && varName != nil) {
            [build appendString:@" " semanticType:GTSemanticTypeStandard];
        }
        if (varName != nil) {
            [build appendString:varName semanticType:GTSemanticTypeVariable];
        }
        [build appendString:@")(" semanticType:GTSemanticTypeStandard];
        
        NSUInteger const paramCount = self.parameterTypes.count;
        if (paramCount == 0) {
            [build appendString:@"void" semanticType:GTSemanticTypeKeyword];
        } else {
            [self.parameterTypes enumerateObjectsUsingBlock:^(GTParseType *paramType, NSUInteger idx, BOOL *stop) {
                [build appendSemanticString:[paramType semanticStringForVariableName:nil]];
                if ((idx + 1) < paramCount) {
                    [build appendString:@", " semanticType:GTSemanticTypeStandard];
                }
            }];
        }
        [build appendString:@")" semanticType:GTSemanticTypeStandard];
    } else {
        if (modifiersString.length > 0) {
            [build appendSemanticString:modifiersString];
            [build appendString:@" " semanticType:GTSemanticTypeStandard];
        }
        [build appendString:@"id" semanticType:GTSemanticTypeKeyword];
        [build appendString:@" " semanticType:GTSemanticTypeStandard];
        [build appendString:@"/* block */" semanticType:GTSemanticTypeComment];
        if (varName != nil) {
            [build appendString:@" " semanticType:GTSemanticTypeStandard];
            [build appendString:varName semanticType:GTSemanticTypeVariable];
        }
    }
    return build;
}

- (NSSet<NSString *> *)classReferences {
    NSMutableSet<NSString *> *build = [NSMutableSet set];
    NSSet<NSString *> *returnReferences = [self.returnType classReferences];
    if (returnReferences != nil) {
        [build unionSet:returnReferences];
    }
    for (GTParseType *paramType in self.parameterTypes) {
        NSSet<NSString *> *paramReferences = [paramType classReferences];
        if (paramReferences != nil) {
            [build unionSet:paramReferences];
        }
    }
    return build;
}

- (NSSet<NSString *> *)protocolReferences {
    NSMutableSet<NSString *> *build = [NSMutableSet set];
    NSSet<NSString *> *returnReferences = [self.returnType protocolReferences];
    if (returnReferences != nil) {
        [build unionSet:returnReferences];
    }
    for (GTParseType *paramType in self.parameterTypes) {
        NSSet<NSString *> *paramReferences = [paramType protocolReferences];
        if (paramReferences != nil) {
            [build unionSet:paramReferences];
        }
    }
    return build;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        __typeof(self) casted = (__typeof(casted))object;
        return (self.modifiers == casted.modifiers || [self.modifiers isEqualToArray:casted.modifiers]) &&
        (self.returnType == casted.returnType || [self.returnType isEqual:casted.returnType]) &&
        (self.parameterTypes == casted.parameterTypes || [self.parameterTypes isEqualToArray:casted.parameterTypes]);
    }
    return NO;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p> {modifiers: '%@', returnType: %@, parameterTypes: %@}",
            [self class], self, [self modifiersString], self.returnType, self.parameterTypes];
}

@end
