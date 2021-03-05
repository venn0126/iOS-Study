//
//  NWProxy.h
//  NWModel
//
//  Created by Augus on 2021/2/26.
//

#import <Foundation/Foundation.h>

/**
 
 核心思想：使用中介，打破循环引用问题
 */

NS_ASSUME_NONNULL_BEGIN

@interface NWProxy : NSProxy

/**
 The proxy target.
 */
@property (nonatomic, weak, readonly) id target;

/**
 Creates a new weak proxy for target
 
 @param target Target object.
 
 @return A new proxy tartge.
 */
- (instancetype)initWithTarget:(id)target;

/**
 Creates a new weak proxy for target
 
 @param target Target object.
 
 @return A new proxy tartge.
 */
+ (instancetype)proxyWithTarget:(id)target;


@end

NS_ASSUME_NONNULL_END
