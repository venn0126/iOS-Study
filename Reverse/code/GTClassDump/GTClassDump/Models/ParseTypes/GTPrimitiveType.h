//
//  GTPrimitiveType.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTParseType.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GTPrimitiveRawType) {
    GTPrimitiveRawTypeVoid,
    
    GTPrimitiveRawTypeChar,
    GTPrimitiveRawTypeInt,
    GTPrimitiveRawTypeShort,
    GTPrimitiveRawTypeLong,
    GTPrimitiveRawTypeLongLong,
    GTPrimitiveRawTypeInt128,
    
    GTPrimitiveRawTypeUnsignedChar,
    GTPrimitiveRawTypeUnsignedInt,
    GTPrimitiveRawTypeUnsignedShort,
    GTPrimitiveRawTypeUnsignedLong,
    GTPrimitiveRawTypeUnsignedLongLong,
    GTPrimitiveRawTypeUnsignedInt128,
    
    GTPrimitiveRawTypeFloat,
    GTPrimitiveRawTypeDouble,
    GTPrimitiveRawTypeLongDouble,
    
    GTPrimitiveRawTypeBool,
    GTPrimitiveRawTypeClass,
    GTPrimitiveRawTypeSel,
    
    GTPrimitiveRawTypeFunction,
    
    /// @note This is not a real type.
    /// @discussion A blank type represents a type that
    /// is encoded to a space character. There are multiple
    /// types that are encoded to a space character, and it
    /// is not possible for us to discern the difference
    /// between them.
    GTPrimitiveRawTypeBlank,
    /// @note This is not a real type.
    /// @discussion An empty type represents a type that
    /// was not encoded. Usually this occurs when types
    /// that do not exist in Objective-C are bridged into
    /// Objective-C (this should only occur at runtime).
    GTPrimitiveRawTypeEmpty,
};

OBJC_EXTERN NSString *_Nullable NSStringFromGTPrimitiveRawType(GTPrimitiveRawType);


@interface GTPrimitiveType : GTParseType

@property (nonatomic) GTPrimitiveRawType rawType;

+ (nonnull instancetype)primitiveWithRawType:(GTPrimitiveRawType)rawType;

@end

NS_ASSUME_NONNULL_END
