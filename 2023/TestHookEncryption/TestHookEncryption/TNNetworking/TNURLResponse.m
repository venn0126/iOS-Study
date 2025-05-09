//
//  TNURLResponse.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import "TNURLResponse.h"

@interface TNURLResponse ()

@property (nonatomic, readwrite) TNURLResponseStatus status;
@property (nonatomic, strong, readwrite, nullable) NSURLRequest *request;
@property (nonatomic, strong, readwrite, nullable) NSNumber *requestId;
@property (nonatomic, strong, readwrite, nullable) id responseObject;
@property (nonatomic, copy, readwrite, nullable) NSString *responseString;
@property (nonatomic, strong, readwrite, nullable) NSError *error;

@end

@implementation TNURLResponse

- (instancetype)initWithResponseString:(nullable NSString *)responseString
                             requestId:(nullable NSNumber *)requestId
                               request:(nullable NSURLRequest *)request
                        responseObject:(nullable id)responseObject
                                 error:(nullable NSError *)error {
    self = [super init];
    if (self) {
        _responseString = [responseString copy];
        _requestId = requestId;
        _request = request;
        _responseObject = responseObject;
        _error = error;
        
        if (error) {
            if ([error.domain isEqualToString:NSURLErrorDomain]) {
                if (error.code == NSURLErrorTimedOut) {
                    _status = TNURLResponseStatusErrorTimeout;
                } else if (error.code == NSURLErrorNotConnectedToInternet ||
                           error.code == NSURLErrorNetworkConnectionLost) {
                    _status = TNURLResponseStatusErrorNoNetwork;
                } else if (error.code == NSURLErrorCancelled) {
                    _status = TNURLResponseStatusErrorCancel;
                } else {
                    _status = TNURLResponseStatusErrorResponse;
                }
            } else {
                _status = TNURLResponseStatusErrorResponse;
            }
        } else {
            _status = TNURLResponseStatusSuccess;
        }
    }
    return self;
}

@end
