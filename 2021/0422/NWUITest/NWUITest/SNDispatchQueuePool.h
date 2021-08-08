//
//  SNDispatchQueuePool.h
//  NWUITest
//
//  Created by Augus on 2021/7/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNDispatchQueuePool : NSObject


/// Pool's name.
@property (nullable, nonatomic, readonly) NSString *name;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;


/// Creates and returns a dispatch queue pool.
/// @param name The name of the pool.
/// @param queueCount Maxmiun queue count, should in range (1,32)
/// @param qos Queue quality of service(qos).
/// @return A new pool,or nil if an error occurs.
- (instancetype)initWithName:(nullable NSString *)name queueCount:(NSUInteger)queueCount qos:(NSQualityOfService)qos;


/// Pool's name.
- (dispatch_queue_t)queue;


/// Returns a dispatch queue pool for specify qos.
/// @param qos The queue quality of service.
+ (instancetype)defaultPoolForQos:(NSQualityOfService)qos;

@end

NS_ASSUME_NONNULL_END
