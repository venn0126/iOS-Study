//
//  GTSemanticString.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// The semantic types that a string may represent in an Objective-C header file
typedef NS_ENUM(NSUInteger, GTSemanticType) {
    // whitespace, colons (':'), semicolons (';'), pointers ('*'),
    // braces ('(', ')'), brackets ('{','}', '[', ']', '<', '>')
    GTSemanticTypeStandard,
    // characters used to start and end a comment, and the contents of the comment
    GTSemanticTypeComment,
    // struct, union, type modifiers, language provided primitive types
    GTSemanticTypeKeyword,
    // the name of a variable- this includes both declaration and usage sites
    GTSemanticTypeVariable,
    // the name portion of a struct or union definition
    GTSemanticTypeRecordName,
    // an Obj-C class (e.g. NSString)
    GTSemanticTypeClass,
    // an Obj-C protocol (e.g. NSFastEnumeration)
    GTSemanticTypeProtocol,
    // a number literal (e.g. 2, 18, 1e5, 7.1)
    GTSemanticTypeNumeric,
    
    /// The number of valid cases there are in @c CDSemanticType
    GTSemanticTypeCount
};


@interface GTSemanticString : NSObject

/// The length of the string
@property (readonly) NSUInteger length;
/// Append another semantic string to the end of this string,
/// keeping all of the semantics of both the parameter and receiver
- (void)appendSemanticString:(GTSemanticString *)semanticString;
/// Append a string with a semantic type to the end of this string
- (void)appendString:(NSString *)string semanticType:(GTSemanticType)type;
/// Whether the first character in this string is equal to @c character
- (BOOL)startsWithChar:(char)character;
/// Whether the last character in this string is equal to @c character
- (BOOL)endWithChar:(char)character;
/// Enumerate the substrings and the associated semantic type that compose this string
- (void)enumerateTypesUsingBlock:(void (NS_NOESCAPE ^)(NSString *string, GTSemanticType type))block;
/// Enumerate the longest effective substrings and the associated semantic type that compose this string
///
/// Each invocation of @c block will have the longest substring of @c type such that the next
/// invocation will have a different @c type
- (void)enumerateLongestEffectiveRangesUsingBlock:(void (NS_NOESCAPE ^)(NSString *string, GTSemanticType type))block;

/// The string representation without semantics
- (NSString *)string;

@end

NS_ASSUME_NONNULL_END
