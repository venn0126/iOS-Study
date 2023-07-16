//
//  GTSemanticString.m
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTSemanticString.h"

@interface GTSemanticStringStaple : NSObject
@property (strong, nonatomic) NSString *string;
@property (nonatomic) GTSemanticType type;
@end

@implementation GTSemanticStringStaple
@end

@implementation GTSemanticString {

NSMutableArray<GTSemanticStringStaple *> *_components;
}

- (instancetype)init {
if (self = [super init]) {
    _length = 0;
    _components = [NSMutableArray array];
}
return self;
}

- (void)appendSemanticString:(GTSemanticString *)semanticString {
[_components addObjectsFromArray:semanticString->_components];
_length += semanticString.length;
}

- (void)appendString:(NSString *)string semanticType:(GTSemanticType)type {
if (string.length > 0) {
    GTSemanticStringStaple *staple = [GTSemanticStringStaple new];
    staple.string = string;
    staple.type = type;
    [_components addObject:staple];
    _length += string.length;
}
}

- (BOOL)startsWithChar:(char)character {
char *bytes = &character;
NSString *suffix = [[NSString alloc] initWithBytesNoCopy:bytes length:1 encoding:NSASCIIStringEncoding freeWhenDone:NO];
return [_components.firstObject.string hasPrefix:suffix];
}

- (BOOL)endWithChar:(char)character {
char *bytes = &character;
NSString *suffix = [[NSString alloc] initWithBytesNoCopy:bytes length:1 encoding:NSASCIIStringEncoding freeWhenDone:NO];
return [_components.lastObject.string hasSuffix:suffix];
}

- (void)enumerateTypesUsingBlock:(void (NS_NOESCAPE ^)(NSString *string, GTSemanticType type))block {
for (GTSemanticStringStaple *staple in _components) {
    block(staple.string, staple.type);
}
}

- (void)enumerateLongestEffectiveRangesUsingBlock:(void (NS_NOESCAPE ^)(NSString *string, GTSemanticType type))block {
GTSemanticType activeStapleType = GTSemanticTypeStandard;
NSMutableString *concatString = nil;
for (GTSemanticStringStaple *staple in _components) {
    if ((concatString == nil) || (staple.type != activeStapleType)) {
        if (concatString != nil) {
            block([concatString copy], activeStapleType);
        }
        concatString = [NSMutableString stringWithString:staple.string];
        activeStapleType = staple.type;
    } else {
        [concatString appendString:staple.string];
    }
}
if (concatString != nil) {
    block([concatString copy], activeStapleType);
}
}

- (NSString *)string {
NSMutableString *build = [NSMutableString string];
for (GTSemanticStringStaple *staple in _components) {
    [build appendString:staple.string];
}
return [build copy];
}

@end
