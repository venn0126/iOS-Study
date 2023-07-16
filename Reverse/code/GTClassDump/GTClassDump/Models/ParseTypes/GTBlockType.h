//
//  GTBlockType.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTParseType.h"

NS_ASSUME_NONNULL_BEGIN

/// Type representing a block
@interface GTBlockType : GTParseType

/// The type that this block returns
@property (nullable, strong, nonatomic) GTParseType *returnType;
/// The types of the parameters to this block
@property (nullable, strong, nonatomic) NSArray<GTParseType *> *parameterTypes;

@end

NS_ASSUME_NONNULL_END
