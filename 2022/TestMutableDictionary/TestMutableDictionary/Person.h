//
//  Person.h
//  TestMutableDictionary
//
//  Created by Augus on 2022/7/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

/// Persone's name
@property (nonatomic, copy) NSString *name;

/// Person's age
@property (nonatomic, assign) NSInteger age;

/// Person's factory initilzation method
+ (instancetype)augusPerson;

+ (void)say:(NSString*)text callback:(void(^)(NSString *text,int x, NSString *y, double z, BOOL m))callback;

@end

NS_ASSUME_NONNULL_END
