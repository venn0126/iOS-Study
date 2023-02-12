//
//  GTCache.h
//  TestObjcSome
//
//  Created by Augus on 2023/2/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTCache : NSObject


+ (instancetype)shareInstance;

- (void)gt_setObject:(id)obj forKey:(id)key;

- (id)gt_objectForKey:(id)key;



@end

NS_ASSUME_NONNULL_END
