//
//  GTBlockLogResult.h
//  TestObjcSome
//
//  Created by Augus on 2023/3/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTBlockLogResult : NSObject

- (instancetype)initWithMethodSignature:(NSMethodSignature *)methodSignature;
@property (copy, readonly, nonatomic) NSString *returnDecription;
@property (strong, readonly, nonatomic) NSMutableArray *argDecriptions;

@end

NS_ASSUME_NONNULL_END
