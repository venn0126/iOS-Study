//
//  GTPointerType.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTParseType.h"

NS_ASSUME_NONNULL_BEGIN

/// Type representing a pointer
@interface GTPointerType : GTParseType

/// The type that this pointer points to
@property (nullable, strong, nonatomic) GTParseType *pointee;

+ (nonnull instancetype)pointerToPointee:(nonnull GTParseType *)pointee;

@end

NS_ASSUME_NONNULL_END
