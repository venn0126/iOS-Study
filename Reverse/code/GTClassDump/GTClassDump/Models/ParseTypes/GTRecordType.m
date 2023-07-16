//
//  GTRecordType.m
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTRecordType.h"


@implementation GTRecordType

- (GTSemanticString *)semanticStringForVariableName:(NSString *)varName {
    GTSemanticString *build = [GTSemanticString new];
    GTSemanticString *modifiersString = [self modifiersSemanticString];
    if (modifiersString.length > 0) {
        [build appendSemanticString:modifiersString];
        [build appendString:@" " semanticType:GTSemanticTypeStandard];
    }
    [build appendString:(self.isUnion ? @"union" : @"struct") semanticType:GTSemanticTypeKeyword];
    if (self.name != nil) {
        [build appendString:@" " semanticType:GTSemanticTypeStandard];
        [build appendString:self.name semanticType:GTSemanticTypeRecordName];
    }
    if (self.fields != nil) {
        [build appendString:@" { " semanticType:GTSemanticTypeStandard];
        
        unsigned fieldName = 0;
        
        for (GTVariableModel *variableModel in self.fields) {
            NSString *variableName = variableModel.name;
            if (variableName == nil) {
                variableName = [NSString stringWithFormat:@"x%u", fieldName++];
            }
            [build appendSemanticString:[variableModel.type semanticStringForVariableName:variableName]];
            [build appendString:@"; " semanticType:GTSemanticTypeStandard];
        }
        [build appendString:@"}" semanticType:GTSemanticTypeStandard];
    }
    if (varName != nil) {
        [build appendString:@" " semanticType:GTSemanticTypeStandard];
        [build appendString:varName semanticType:GTSemanticTypeVariable];
    }
    return build;
}

- (NSSet<NSString *> *)classReferences {
    NSMutableSet<NSString *> *build = [NSMutableSet set];
    for (GTVariableModel *variableModel in self.fields) {
        NSSet<NSString *> *paramReferences = [variableModel.type classReferences];
        if (paramReferences != nil) {
            [build unionSet:paramReferences];
        }
    }
    return build;
}

- (NSSet<NSString *> *)protocolReferences {
    NSMutableSet<NSString *> *build = [NSMutableSet set];
    for (GTVariableModel *variableModel in self.fields) {
        NSSet<NSString *> *paramReferences = [variableModel.type protocolReferences];
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
        (self.name == casted.name || [self.name isEqualToString:casted.name]) &&
        self.isUnion == casted.isUnion &&
        (self.fields == casted.fields || [self.fields isEqualToArray:casted.fields]);
    }
    return NO;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p> {modifiers: '%@', name: '%@', isUnion: %@, fields: %@}",
            [self class], self, [self modifiersString], self.name, self.isUnion ? @"YES" : @"NO", self.fields.debugDescription];
}

@end
