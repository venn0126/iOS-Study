//
//  GTArrayType.m
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTArrayType.h"

@implementation GTArrayType

- (GTSemanticString *)semanticStringForVariableName:(NSString *)varName {
    GTSemanticString *build = [GTSemanticString new];
    GTSemanticString *modifiersString = [self modifiersSemanticString];
    if (modifiersString.length > 0) {
        [build appendSemanticString:modifiersString];
        [build appendString:@" " semanticType:GTSemanticTypeStandard];
    }
    
    NSMutableArray<GTArrayType *> *arrayStack = [NSMutableArray array];
    
    GTParseType *headType = self;
    while ([headType isKindOfClass:[GTArrayType class]]) {
        GTArrayType *arrayType = (__kindof GTParseType *)headType;
        [arrayStack addObject:arrayType];
        headType = arrayType.type;
    }
    
    [build appendSemanticString:[headType semanticStringForVariableName:varName]];
    
    [arrayStack enumerateObjectsUsingBlock:^(GTArrayType *arrayType, NSUInteger idx, BOOL *stop) {
        [build appendString:@"[" semanticType:GTSemanticTypeStandard];
        [build appendString:[NSString stringWithFormat:@"%lu", (unsigned long)arrayType.size] semanticType:GTSemanticTypeNumeric];
        [build appendString:@"]" semanticType:GTSemanticTypeStandard];
    }];
    
    return build;
}

- (NSSet<NSString *> *)classReferences {
    return [self.type classReferences];
}

- (NSSet<NSString *> *)protocolReferences {
    return [self.type protocolReferences];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        __typeof(self) casted = (__typeof(casted))object;
        return (self.modifiers == casted.modifiers || [self.modifiers isEqualToArray:casted.modifiers]) &&
        (self.type == casted.type || [self.type isEqual:casted.type]) &&
        (self.size == casted.size);
    }
    return NO;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p> {modifiers: '%@', type: %@, size: %lu}",
            [self class], self, [self modifiersString], self.type.debugDescription, (unsigned long)self.size];
}

@end
