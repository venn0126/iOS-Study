//
//  GTPrimitiveType.m
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTPrimitiveType.h"

NSString *NSStringFromGTPrimitiveRawType(GTPrimitiveRawType rawType) {
    switch (rawType) {
        case GTPrimitiveRawTypeVoid:
            return @"void";
        case GTPrimitiveRawTypeChar:
            return @"char";
        case GTPrimitiveRawTypeInt:
            return @"int";
        case GTPrimitiveRawTypeShort:
            return @"short";
        case GTPrimitiveRawTypeLong:
            return @"long";
        case GTPrimitiveRawTypeLongLong:
            return @"long long";
        case GTPrimitiveRawTypeInt128:
            return @"__int128";
        case GTPrimitiveRawTypeUnsignedChar:
            return @"unsigned char";
        case GTPrimitiveRawTypeUnsignedInt:
            return @"unsigned int";
        case GTPrimitiveRawTypeUnsignedShort:
            return @"unsigned short";
        case GTPrimitiveRawTypeUnsignedLong:
            return @"unsigned long";
        case GTPrimitiveRawTypeUnsignedLongLong:
            return @"unsigned long long";
        case GTPrimitiveRawTypeUnsignedInt128:
            return @"unsigned __int128";
        case GTPrimitiveRawTypeFloat:
            return @"float";
        case GTPrimitiveRawTypeDouble:
            return @"double";
        case GTPrimitiveRawTypeLongDouble:
            return @"long double";
        case GTPrimitiveRawTypeBool:
            return @"BOOL";
        case GTPrimitiveRawTypeClass:
            return @"Class";
        case GTPrimitiveRawTypeSel:
            return @"SEL";
        case GTPrimitiveRawTypeFunction:
            return @"void /* function */";
        case GTPrimitiveRawTypeBlank:
            return @"void /* unknown type, blank encoding */";
        case GTPrimitiveRawTypeEmpty:
            return @"void /* unknown type, empty encoding */";
    }
}

@implementation GTPrimitiveType

+ (nonnull instancetype)primitiveWithRawType:(GTPrimitiveRawType)rawType {
    GTPrimitiveType *ret = [self new];
    ret.rawType = rawType;
    return ret;
}

- (GTSemanticString *)semanticStringForVariableName:(NSString *)varName {
    GTSemanticString *build = [GTSemanticString new];
    GTSemanticString *modifiersString = [self modifiersSemanticString];
    if (modifiersString.length > 0) {
        [build appendSemanticString:modifiersString];
        [build appendString:@" " semanticType:GTSemanticTypeStandard];
    }
    switch (self.rawType) {
        case GTPrimitiveRawTypeVoid:
            [build appendString:@"void" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeChar:
            [build appendString:@"char" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeInt:
            [build appendString:@"int" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeShort:
            [build appendString:@"short" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeLong:
            [build appendString:@"long" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeLongLong:
            [build appendString:@"long long" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeInt128:
            [build appendString:@"__int128" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeUnsignedChar:
            [build appendString:@"unsigned char" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeUnsignedInt:
            [build appendString:@"unsigned int" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeUnsignedShort:
            [build appendString:@"unsigned short" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeUnsignedLong:
            [build appendString:@"unsigned long" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeUnsignedLongLong:
            [build appendString:@"unsigned long long" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeUnsignedInt128:
            [build appendString:@"unsigned __int128" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeFloat:
            [build appendString:@"float" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeDouble:
            [build appendString:@"double" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeLongDouble:
            [build appendString:@"long double" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeBool:
            [build appendString:@"BOOL" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeClass:
            [build appendString:@"Class" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeSel:
            [build appendString:@"SEL" semanticType:GTSemanticTypeKeyword];
            break;
        case GTPrimitiveRawTypeFunction:
            [build appendString:@"void" semanticType:GTSemanticTypeKeyword];
            [build appendString:@" " semanticType:GTSemanticTypeStandard];
            [build appendString:@"/* function */" semanticType:GTSemanticTypeComment];
            break;
        case GTPrimitiveRawTypeBlank:
            [build appendString:@"void" semanticType:GTSemanticTypeKeyword];
            [build appendString:@" " semanticType:GTSemanticTypeStandard];
            [build appendString:@"/* unknown type, blank encoding */" semanticType:GTSemanticTypeComment];
            break;
        case GTPrimitiveRawTypeEmpty:
            [build appendString:@"void" semanticType:GTSemanticTypeKeyword];
            [build appendString:@" " semanticType:GTSemanticTypeStandard];
            [build appendString:@"/* unknown type, empty encoding */" semanticType:GTSemanticTypeComment];
            break;
    }
    if (varName != nil) {
        [build appendString:@" " semanticType:GTSemanticTypeStandard];
        [build appendString:varName semanticType:GTSemanticTypeVariable];
    }
    return build;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        __typeof(self) casted = (__typeof(casted))object;
        return (self.modifiers == casted.modifiers || [self.modifiers isEqualToArray:casted.modifiers]) &&
        self.rawType == casted.rawType;
    }
    return NO;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p> {modifiers: '%@', rawType: '%@'}",
            [self class], self, [self modifiersString], NSStringFromGTPrimitiveRawType(self.rawType)];
}


@end
