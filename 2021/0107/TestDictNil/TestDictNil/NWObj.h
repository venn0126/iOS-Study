//
//  NWObj.h
//  TestDictNil
//
//  Created by Augus on 2021/1/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NWObj : NSObject

- (instancetype)initWithRequestId:(nullable NSString *)requestId;

- (instancetype)initWithRequestId:(nullable NSString *)requestId name:(nullable NSString *)name;

@property (nonatomic, readonly, copy) NSString *requestId;


- (void)foo;

@end

NS_ASSUME_NONNULL_END
