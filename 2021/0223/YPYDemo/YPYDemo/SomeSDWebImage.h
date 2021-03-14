//
//  SomeSDWebImage.h
//  YPYDemo
//
//  Created by Augus on 2021/3/6.
//

#import <Foundation/Foundation.h>

// NS_ASSUME_NONNULL_BEGIN is point some that must be nonnull
// else you will point the nullable
// for example
NS_ASSUME_NONNULL_BEGIN

@interface SomeSDWebImage : NSObject

//- (instancetype)init __attribute__((unavailable("Disable . Use -initWithName")));

- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy) NSString *firstName;

// name is nonnull
- (instancetype)initWithName:(NSString *)name;

// someage is null able
@property (nonatomic, copy, nullable) NSString *someAge;


@end

NS_ASSUME_NONNULL_END
