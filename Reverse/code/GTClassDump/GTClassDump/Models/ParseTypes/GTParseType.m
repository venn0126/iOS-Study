//
//  GTParseType.m
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTParseType.h"


NSString *NSStringFromGTTypeModifier(GTTypeModifier modifier) {
    switch (modifier) {
        case GTTypeModifierConst:
            return @"const";
        case GTTypeModifierComplex:
            return @"_Complex";
        case GTTypeModifierAtomic:
            return @"_Atomic";
        case GTTypeModifierIn:
            return @"in";
        case GTTypeModifierInOut:
            return @"inout";
        case GTTypeModifierOut:
            return @"out";
        case GTTypeModifierBycopy:
            return @"bycopy";
        case GTTypeModifierByref:
            return @"byref";
        case GTTypeModifierOneway:
            return @"oneway";
        default:
            NSCAssert(NO, @"Unknown GTTypeModifier value");
            return nil;
    }
}

@implementation GTParseType

- (NSString *)stringForVariableName:(NSString *)varName {
    return [[self semanticStringForVariableName:varName] string];
}

- (GTSemanticString *)semanticStringForVariableName:(NSString *)varName {
    NSAssert(NO, @"Subclasses must implement %@", NSStringFromSelector(_cmd));
    return [GTSemanticString new];
}

- (NSString *)modifiersString {
    NSArray<NSNumber *> *const modifiers = self.modifiers;
    NSMutableArray<NSString *> *strings = [NSMutableArray arrayWithCapacity:modifiers.count];
    [modifiers enumerateObjectsUsingBlock:^(NSNumber *value, NSUInteger idx, BOOL *stop) {
        strings[idx] = NSStringFromGTTypeModifier(value.unsignedIntegerValue);
    }];
    return [strings componentsJoinedByString:@" "];
}

- (GTSemanticString *)modifiersSemanticString {
    NSArray<NSNumber *> *const modifiers = self.modifiers;
    GTSemanticString *build = [GTSemanticString new];
    NSUInteger const modifierCount = self.modifiers.count;
    [modifiers enumerateObjectsUsingBlock:^(NSNumber *value, NSUInteger idx, BOOL *stop) {
        NSString *string = NSStringFromGTTypeModifier(value.unsignedIntegerValue);
        [build appendString:string semanticType:GTSemanticTypeKeyword];
        if ((idx + 1) < modifierCount) {
            [build appendString:@" " semanticType:GTSemanticTypeStandard];
        }
    }];
    return build;
}

- (NSSet<NSString *> *)classReferences {
    return nil;
}

- (NSSet<NSString *> *)protocolReferences {
    return nil;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        __typeof(self) casted = (__typeof(casted))object;
        return (self.modifiers == casted.modifiers || [self.modifiers isEqualToArray:casted.modifiers]);
    }
    return NO;
}

- (NSString *)description {
    return [self stringForVariableName:nil];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p> {modifiers: '%@'}",
            [self class], self, [self modifiersString]];
}

@end
