//
//  TNLogger.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TNLogger : NSObject

+ (NSString *)logDebugInfoWithRequest:(NSURLRequest *)request
                              apiName:(NSString *)apiName
                              service:(id)service;

+ (NSString *)logDebugInfoWithResponse:(NSHTTPURLResponse *)response
                        responseObject:(nullable id)responseObject
                        responseString:(nullable NSString *)responseString
                               request:(NSURLRequest *)request
                                 error:(nullable NSError *)error;

+ (void)logInfo:(NSString *)format, ...;
+ (void)logWarning:(NSString *)format, ...;
+ (void)logError:(NSString *)format, ...;


@end

NS_ASSUME_NONNULL_END
