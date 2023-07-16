//
//  GTBitFieldType.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTParseType.h"

NS_ASSUME_NONNULL_BEGIN

/// Type representing a bit-field in a record
@interface GTBitFieldType : GTParseType

/// Width of the bit-fields (in bits)
@property (nonatomic) NSUInteger width;

@end

NS_ASSUME_NONNULL_END
