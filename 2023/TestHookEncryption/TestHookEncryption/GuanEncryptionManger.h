//
//  GuanEncryptionManger.h
//  TestHookEncryption
//
//  Created by Augus on 2023/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


FOUNDATION_EXTERN NSString *base64_encode_data(NSData *data);
FOUNDATION_EXTERN NSData *base64_decode(NSString *str);

@interface GuanEncryptionManger : NSObject

+ (NSString *)md5FromData:(NSData *)data;

+ (NSString *)md5FromString:(NSString *)string;

+ (NSString *)sha512FromString:(NSString *)string;

+ (NSData *)sha:(NSData *)input type:(NSString *)type;
+ (NSString *)shaUtf8:(NSString *)input type:(NSString *)type;;
+ (NSString *)shaBase64:(NSString *)input type:(NSString *)type;;


+ (NSString *)hmacFromData:(NSData *)data key:(NSData *)key;

+ (NSString *)hmacFromString:(NSString *)string keyString:(NSString *)keyString;

/**
 *  AES加密
 *
 *  @param string    要加密的字符串
 *  @param keyString 加密密钥
 *  @param iv        初始化向量(8个字节)
 *
 *  @return 返回加密后的base64编码字符串
 */
+ (NSString *)aesEncryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData *)iv;

/**
 *  AES解密
 *
 *  @param string    加密并base64编码后的字符串
 *  @param keyString 解密密钥
 *  @param iv        初始化向量(8个字节)
 *
 *  @return 返回解密后的字符串
 */
+ (NSString *)aesDecryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData *)iv;

/**
 *  DES加密
 *
 *  @param string    要加密的字符串
 *  @param keyString 加密密钥
 *  @param iv        初始化向量(8个字节)
 *
 *  @return 返回加密后的base64编码字符串
 */
+ (NSString *)desEncryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData *)iv;

/**
 *  DES解密
 *
 *  @param string    加密并base64编码后的字符串
 *  @param keyString 解密密钥
 *  @param iv        初始化向量(8个字节)
 *
 *  @return 返回解密后的字符串
 */
+ (NSString *)desDecryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData *)iv;


// return base64 encoded string
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
// return raw data
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
// return base64 encoded string
+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;
// return raw data
+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;

// decrypt base64 encoded string, convert result to string(not base64 encoded)
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;

/// PBKDF2
+ (NSString *)pbkdf2Hash:(NSString *)password salt:(NSString *)salt iterations:(int)iterations keyLen:(int)keyLen algorithm:(NSString *)algorithm;


/// HEX
+ (NSString *)toHex:(NSData *)nsdata;
+ (NSData *)fromHex:(NSString *)string;


/// Base64 encode and decode NSString to NSString



@end

NS_ASSUME_NONNULL_END
