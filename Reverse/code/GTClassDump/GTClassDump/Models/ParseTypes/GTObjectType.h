//
//  GTObjectType.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTParseType.h"

NS_ASSUME_NONNULL_BEGIN

/// Type representing an Objective-C object
@interface GTObjectType : GTParseType

/// The name of the class of the object
///
/// If this value is @c nil the type is @c id
@property (nullable, strong, nonatomic) NSString *className;
/// The names of the protocols the object conforms to
@property (nullable, strong, nonatomic) NSArray<NSString *> *protocolNames;

@end

NS_ASSUME_NONNULL_END
