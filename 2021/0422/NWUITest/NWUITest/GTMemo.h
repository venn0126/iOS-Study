//
//  GTMemo.h
//  NWUITest
//
//  Created by Augus on 2021/4/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTMemo : NSObject

@property (nonatomic, strong, readonly) NSURL *url;

+ (instancetype)memoWithTitle:(NSString *)name url:(NSURL *)url;


@end

NS_ASSUME_NONNULL_END
