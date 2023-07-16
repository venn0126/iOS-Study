//
//  GTBitFieldType.m
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTBitFieldType.h"

@implementation GTBitFieldType

- (GTSemanticString *)semanticStringForVariableName:(NSString *)varName {
    GTSemanticString *build = [GTSemanticString new];
    GTSemanticString *modifiersString = [self modifiersSemanticString];
    if (modifiersString.length > 0) {
        [build appendSemanticString:modifiersString];
        [build appendString:@" " semanticType:GTSemanticTypeStandard];
    }
    
    NSUInteger const bitWidth = self.width;
    
    NSString *type = nil;
#ifndef __CHAR_BIT__
#   error __CHAR_BIT__ must be defined
#endif
    /* all bitwidth base-types are unsigned, because that's the typical use case */
    if (bitWidth <= __CHAR_BIT__) {
        type = @"unsigned char";
    }
#ifdef __SIZEOF_SHORT__
    else if (bitWidth <= (__SIZEOF_SHORT__ * __CHAR_BIT__)) {
        type = @"unsigned short";
    }
#endif
#ifdef __SIZEOF_INT__
    else if (bitWidth <= (__SIZEOF_INT__ * __CHAR_BIT__)) {
        type = @"unsigned int";
    }
#endif
#ifdef __SIZEOF_LONG__
    else if (bitWidth <= (__SIZEOF_LONG__ * __CHAR_BIT__)) {
        type = @"unsigned long";
    }
#endif
#ifdef __SIZEOF_LONG_LONG__
    else if (bitWidth <= (__SIZEOF_LONG_LONG__ * __CHAR_BIT__)) {
        type = @"unsigned long long";
    }
#endif
#ifdef __SIZEOF_INT128__
    else if (bitWidth <= (__SIZEOF_INT128__ * __CHAR_BIT__)) {
        type = @"unsigned __int128";
    }
#endif
    else {
        NSAssert(NO, @"width of bit-field exceeds width of any known type");
        type = @"unsigned";
    }
    
    [build appendString:type semanticType:GTSemanticTypeKeyword];
    
    if (varName != nil) {
        [build appendString:@" " semanticType:GTSemanticTypeStandard];
        [build appendString:varName semanticType:GTSemanticTypeVariable];
    }
    
    [build appendString:@" : " semanticType:GTSemanticTypeStandard];
    [build appendString:[NSString stringWithFormat:@"%lu", (unsigned long)self.width] semanticType:GTSemanticTypeNumeric];
    return build;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        __typeof(self) casted = (__typeof(casted))object;
        return (self.modifiers == casted.modifiers || [self.modifiers isEqualToArray:casted.modifiers]) &&
        (self.width == casted.width);
    }
    return NO;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p> {modifiers: '%@', width: %lu}",
            [self class], self, [self modifiersString], (unsigned long)self.width];
}

@end
