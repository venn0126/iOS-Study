//
//  GTTypeParser.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import <Foundation/Foundation.h>
#import "GTParseType.h"



NS_ASSUME_NONNULL_BEGIN

@interface GTTypeParser : NSObject

/// Find the end of an Objective-C type encoding
/// @param encoding An Objective-C type encoding
/// @returns A pointer to the first character that is not part of the type encoding.
/// If @c encoding is not a type encoding, @c encoding will be returned.
+ (const char *)endOfTypeEncoding:(const char *)encoding;
/// Get an object representing the type encoded in @c encoding
/// @param encoding A null-terminated C-string as returned by @c \@encode
+ (GTParseType *)typeForEncoding:(const char *)encoding;
/// Get an object representing the type encoded
/// @param start A pointer to the start of an encoded value as returned by @c \@encode
/// @param end A pointer to the first byte out-of-bounds from @c start
/// @param error Set to @c YES if an error occurs during proccessing
+ (GTParseType *)typeForEncodingStart:(const char *const)start end:(const char *const)end error:(inout BOOL *)error;

@end

NS_ASSUME_NONNULL_END
