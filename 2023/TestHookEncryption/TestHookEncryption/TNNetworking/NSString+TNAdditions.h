//
//  NSString+TNAdditions.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TNAdditions)

- (NSString *)tn_md5;
- (NSString *)tn_urlEncode;
- (NSString *)tn_urlDecode;
- (NSDictionary *)tn_dictionaryFromJsonString;
- (NSString *)tn_stringByAppendingURLParams:(NSDictionary *)params;


@end

NS_ASSUME_NONNULL_END
