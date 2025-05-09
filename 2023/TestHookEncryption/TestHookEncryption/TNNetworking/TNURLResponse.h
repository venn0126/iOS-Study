//
//  TNURLResponse.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, TNURLResponseStatus) {
    TNURLResponseStatusSuccess,           // 成功
    TNURLResponseStatusErrorTimeout,      // 超时
    TNURLResponseStatusErrorNoNetwork,    // 无网络
    TNURLResponseStatusErrorCancel,       // 取消
    TNURLResponseStatusErrorParams,       // 参数错误
    TNURLResponseStatusErrorResponse      // 响应错误
};

NS_ASSUME_NONNULL_BEGIN

@interface TNURLResponse : NSObject

@property (nonatomic, readonly) TNURLResponseStatus status;
@property (nonatomic, strong, readonly, nullable) NSURLRequest *request;
@property (nonatomic, strong, readonly, nullable) NSNumber *requestId;
@property (nonatomic, strong, readonly, nullable) id responseObject;
@property (nonatomic, copy, readonly, nullable) NSString *responseString;
@property (nonatomic, strong, readonly, nullable) NSError *error;
@property (nonatomic, copy, nullable) NSString *logString;

- (instancetype)initWithResponseString:(nullable NSString *)responseString
                             requestId:(nullable NSNumber *)requestId
                               request:(nullable NSURLRequest *)request
                        responseObject:(nullable id)responseObject
                                 error:(nullable NSError *)error;


@end

NS_ASSUME_NONNULL_END
