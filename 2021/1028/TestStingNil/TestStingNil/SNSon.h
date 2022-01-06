//
//  SNSon.h
//  TestStingNil
//
//  Created by Augus on 2021/11/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNSon : NSObject

- (void)requestConfigAsync;

+ (NSString *)getCid;

+ (NSString *)appVersion;

+ (NSString *)deviceIDFV;

+ (NSString *)timeString;

@end

NS_ASSUME_NONNULL_END
