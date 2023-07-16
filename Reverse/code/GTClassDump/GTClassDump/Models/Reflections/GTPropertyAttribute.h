//
//  GTPropertyAttribute.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTPropertyAttribute : NSObject

/// The name of a property attribute, e.g. @c strong, @c nonatomic, @c getter
@property (strong, nonatomic, readonly) NSString *name;
/// The value of a property attribute, e.g. the method name for @c getter= or @c setter=
@property (strong, nonatomic, readonly) NSString *value;

- (instancetype)initWithName:(NSString *)name value:(NSString *)value;
+ (instancetype)attributeWithName:(NSString *)name value:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
