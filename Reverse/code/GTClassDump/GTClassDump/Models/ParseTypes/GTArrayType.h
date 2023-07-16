//
//  GTArrayType.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTParseType.h"

NS_ASSUME_NONNULL_BEGIN

/// Type representing a C array
@interface GTArrayType : GTParseType

/// Type of elements in the array
@property (strong, nonatomic) GTParseType *type;
/// Number of elements in the array
@property (nonatomic) NSUInteger size;

@end

NS_ASSUME_NONNULL_END
