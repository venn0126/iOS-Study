//
//  GTPointerType.m
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTPointerType.h"

@implementation GTPointerType

+ (nonnull instancetype)pointerToPointee:(nonnull GTParseType *)pointee {
    GTPointerType *ret = [self new];
    ret.pointee = pointee;
    return ret;
}

- (GTSemanticString *)semanticStringForVariableName:(NSString *)varName {
    GTSemanticString *build = [GTSemanticString new];
    GTSemanticString *modifiersString = [self modifiersSemanticString];
    if (modifiersString.length > 0) {
        [build appendSemanticString:modifiersString];
        [build appendString:@" " semanticType:GTSemanticTypeStandard];
    }
    [build appendSemanticString:[self.pointee semanticStringForVariableName:nil]];
    if (![build endWithChar:'*']) {
        [build appendString:@" " semanticType:GTSemanticTypeStandard];
    }
    [build appendString:@"*" semanticType:GTSemanticTypeStandard];
    if (varName != nil) {
        [build appendString:varName semanticType:GTSemanticTypeVariable];
    }
    return build;
}

- (NSSet<NSString *> *)classReferences {
    return [self.pointee classReferences];
}

- (NSSet<NSString *> *)protocolReferences {
    return [self.pointee protocolReferences];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        __typeof(self) casted = (__typeof(casted))object;
        return (self.modifiers == casted.modifiers || [self.modifiers isEqualToArray:casted.modifiers]) &&
        (self.pointee == casted.pointee || [self.pointee isEqual:casted.pointee]);
    }
    return NO;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p> {modifiers: '%@', pointee: %@}",
            [self class], self, [self modifiersString], self.pointee.debugDescription];
}

@end
