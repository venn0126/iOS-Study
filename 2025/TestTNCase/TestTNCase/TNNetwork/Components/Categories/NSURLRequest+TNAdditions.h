//
//  NSURLRequest+TNAdditions.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import <Foundation/Foundation.h>
#import "TNServiceProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface NSURLRequest (TNAdditions)

@property (nonatomic, strong, nullable) id<TNServiceProtocol> service;


@end

NS_ASSUME_NONNULL_END
