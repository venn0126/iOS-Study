//
//  GTProxy.h
//  TestObjcSome
//
//  Created by Augus on 2023/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTProxy : NSObject

+ (instancetype)proxyWithTarget:(id)target;
@property (nonatomic, weak) id target;

@end

NS_ASSUME_NONNULL_END
