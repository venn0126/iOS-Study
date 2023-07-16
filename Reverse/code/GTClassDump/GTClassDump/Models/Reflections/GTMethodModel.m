//
//  GTMethodModel.m
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTMethodModel.h"
#import "GTTypeParser.h"
#import "GTParseType.h"
#import "GTSemanticString.h"



/// Returns the number of times a character occurs in a null-terminated stringb
static size_t characterCount(const char *str, const char c) {
    size_t ret = 0;
    while (*str) {
        if (*str++ == c) {
            ret++;
        }
    }
    return ret;
}

@implementation GTMethodModel

+ (instancetype)modelWithMethod:(struct objc_method_description)methd isClass:(BOOL)isClass {
    return [[self alloc] initWithMethod:methd isClass:isClass];
}

- (instancetype)initWithMethod:(struct objc_method_description)methd isClass:(BOOL)isClass {
    if (self = [self init]) {
        _backing = methd;
        _isClass = isClass;
        _name = NSStringFromSelector(methd.name);
        
        const char *typedesc = methd.types;
        // this code is heavily modified from, but based on encoding_getArgumentInfo
        // https://github.com/apple-oss-distributions/objc4/blob/689525d556/runtime/objc-typeencoding.mm#L168-L272
        const char *type = typedesc;
        typedesc = [GTTypeParser endOfTypeEncoding:type];
        _returnType = [GTTypeParser typeForEncodingStart:type end:typedesc error:NULL];
        
        NSUInteger const expectedArguments = characterCount(sel_getName(methd.name), ':');
        NSMutableArray<GTParseType *> *arguments = [NSMutableArray arrayWithCapacity:expectedArguments + 2];
        
        // skip stack size
        while (isnumber(*typedesc)) {
            typedesc++;
        }
        
        while (*typedesc) {
            type = typedesc;
            typedesc = [GTTypeParser endOfTypeEncoding:type];
            [arguments addObject:[GTTypeParser typeForEncodingStart:type end:typedesc error:NULL]];
            
            // Skip GNU runtime's register parameter hint
            if (*typedesc == '+') {
                typedesc++;
            }
            // Skip negative sign in offset
            if (*typedesc == '-') {
                typedesc++;
            }
            while (isnumber(*typedesc)) {
                typedesc++;
            }
        }
        // if there were less arguments than expected, fill in the rest with empty types
        for (NSUInteger argumentIndex = arguments.count; argumentIndex < expectedArguments; argumentIndex++) {
            [arguments addObject:[GTTypeParser typeForEncoding:""]]; // add an empty encoding
        }
        // if there were more arguments than expected, trim from the beginning.
        // usually `self` (type `id`) and `_cmd` (type `SEL`) are the first two parameters,
        // however they are not included in expectedArguments. `_cmd` may not be included
        // if the method is backed by a block instead of a selector.
        _argumentTypes = [arguments subarrayWithRange:NSMakeRange(arguments.count - expectedArguments, expectedArguments)];
    }
    return self;
}

- (GTSemanticString *)semanticString {
    GTSemanticString *build = [GTSemanticString new];
    [build appendString:(self.isClass ? @"+" : @"-") semanticType:GTSemanticTypeStandard];
    [build appendString:@" (" semanticType:GTSemanticTypeStandard];
    [build appendSemanticString:[self.returnType semanticStringForVariableName:nil]];
    [build appendString:@")" semanticType:GTSemanticTypeStandard];
    
    NSArray<GTParseType *> *argumentTypes = self.argumentTypes;
    NSUInteger const argumentTypeCount = argumentTypes.count;
    if (argumentTypeCount > 0) {
        NSArray<NSString *> *brokenupName = [self.name componentsSeparatedByString:@":"];
        
        [argumentTypes enumerateObjectsUsingBlock:^(GTParseType *argumentType, NSUInteger idx, BOOL *stop) {
            [build appendString:brokenupName[idx] semanticType:GTSemanticTypeStandard];
            [build appendString:@":" semanticType:GTSemanticTypeStandard];
            [build appendString:@"(" semanticType:GTSemanticTypeStandard];
            [build appendSemanticString:[argumentType semanticStringForVariableName:nil]];
            [build appendString:@")" semanticType:GTSemanticTypeStandard];
            [build appendString:[NSString stringWithFormat:@"a%lu", (unsigned long)idx] semanticType:GTSemanticTypeVariable];
            if ((idx + 1) < argumentTypeCount) { // if there are still arguments left, add a space to separate
                [build appendString:@" " semanticType:GTSemanticTypeStandard];
            }
        }];
    } else {
        [build appendString:self.name semanticType:GTSemanticTypeStandard];
    }
    return build;
}

- (NSSet<NSString *> *)classReferences {
    NSMutableSet<NSString *> *build = [NSMutableSet set];
    NSSet<NSString *> *returnReferences = [self.returnType classReferences];
    if (returnReferences != nil) {
        [build unionSet:returnReferences];
    }
    for (GTParseType *paramType in self.argumentTypes) {
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
    for (GTParseType *paramType in self.argumentTypes) {
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
        return [self.name isEqual:casted.name] &&
        [self.argumentTypes isEqual:casted.argumentTypes] &&
        [self.returnType isEqual:casted.returnType];
    }
    return NO;
}

- (NSString *)description {
    return [[self semanticString] string];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p> {signature: '%@', argumentTypes: %@, "
            "returnType: '%@', isClass: %@}",
            [self class], self, self.name, self.argumentTypes,
            self.returnType, self.isClass ? @"YES" : @"NO"];
}


@end
