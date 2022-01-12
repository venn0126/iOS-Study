//
//  NSDictionary+Extend.h
//  TestStingNil
//
//  Created by Augus on 2022/1/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Extend)

- (NSString *)toUrlString;
- (NSMutableString *)mutableUrlString;

@end

NS_ASSUME_NONNULL_END
