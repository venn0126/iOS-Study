//
//  TNApiProxy.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import <Foundation/Foundation.h>
#import "TNURLResponse.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^TNCallback)(TNURLResponse *response);


@interface TNApiProxy : NSObject

+ (instancetype)sharedInstance;

// 发送请求
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request
                         success:(nullable TNCallback)success
                            fail:(nullable TNCallback)fail;

// 取消请求
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray<NSNumber *> *)requestIDList;

// 批量请求
- (NSArray<NSNumber *> *)callApiBatchWithRequests:(NSArray<NSURLRequest *> *)requests
                                          success:(nullable TNCallback)success
                                             fail:(nullable TNCallback)fail;
 

@end

NS_ASSUME_NONNULL_END
