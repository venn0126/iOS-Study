//
//  GTBlockLog.h
//  TestObjcSome
//
//  Created by Augus on 2023/3/12.
//

#import <Foundation/Foundation.h>
#import "GTBlockLogResult.h"


 #define GTBlockLog(block) [GTBlockLog logWithBlock:block].description


NS_ASSUME_NONNULL_BEGIN

@interface GTBlockLog : NSObject

+ (GTBlockLogResult *)logWithBlock:(id)block;

@end

NS_ASSUME_NONNULL_END
