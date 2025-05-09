//
//  NSString+TNAdditions.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import "NSString+TNAdditions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (TNAdditions)

- (NSString *)tn_md5 {
    // 虽然方法名称保持为 tn_md5，但实际使用 SHA256 算法以替代已弃用的 MD5
    const char *cStr = [self UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    
    return hash;
}

- (NSString *)tn_urlEncode {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)tn_urlDecode {
    return [self stringByRemovingPercentEncoding];
}

- (NSDictionary *)tn_dictionaryFromJsonString {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:0
                                                           error:&error];
    if (error) {
        return nil;
    }
    return dict;
}

- (NSString *)tn_stringByAppendingURLParams:(NSDictionary *)params {
    if (params.count == 0) {
        return self;
    }
    
    NSMutableString *result = [NSMutableString stringWithString:self];
    BOOL hasQuestionMark = [self rangeOfString:@"?"].location != NSNotFound;
    
    NSMutableArray *pairs = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *keyString = [key description];
        NSString *valueString = [obj description];
        NSString *encodedKey = [keyString tn_urlEncode];
        NSString *encodedValue = [valueString tn_urlEncode];
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", encodedKey, encodedValue]];
    }];
    
    NSString *query = [pairs componentsJoinedByString:@"&"];
    [result appendString:hasQuestionMark ? @"&" : @"?"];
    [result appendString:query];
    
    return result;
}

@end
