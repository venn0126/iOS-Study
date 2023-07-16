//
//  GTRecordType.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTParseType.h"
#import "GTVariableModel.h"


NS_ASSUME_NONNULL_BEGIN

/// Type representing a @c struct or @c union
@interface GTRecordType : GTParseType

/// The name of the record
///
/// If the type is anonymous, this value will be @c nil
@property (nullable, strong, nonatomic) NSString *name;
/// @c YES if the receiver represents a @c union
/// otherwise the receiver represents a @c struct
@property (nonatomic) BOOL isUnion;
/// The fields of the record
///
/// A @c struct stores a value in each field.
/// A @c union stores a single value that can be accessed
/// as different types by each field.
/// @note If this value is @c nil the type is incomplete.
/// If the value is non-nil but empty (i.e. an empty array),
/// the record is defined to have no fields.
@property (nullable, strong, nonatomic) NSArray<GTVariableModel *> *fields;

@end

NS_ASSUME_NONNULL_END
