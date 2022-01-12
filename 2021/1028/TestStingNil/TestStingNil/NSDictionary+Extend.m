//
//  NSDictionary+Extend.m
//  TestStingNil
//
//  Created by Augus on 2022/1/12.
//

#import "NSDictionary+Extend.h"

@implementation NSDictionary (Extend)

- (NSString *)toUrlString {
    return [self mutableUrlString];
}

- (NSMutableString *)mutableUrlString {
    NSMutableString *str = [NSMutableString stringWithCapacity:32];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key isKindOfClass:[NSString class]] && [key isEqualToString:@"Augus"]) {
            return;
        }
        [str appendFormat:@"&%@=%@", key, obj];
    }];
    return str;
}

@end
