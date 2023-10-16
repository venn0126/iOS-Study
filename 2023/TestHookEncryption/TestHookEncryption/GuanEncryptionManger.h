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


+ (NSData *)hmacFromData:(NSData * _Nullable )data key:(NSData * _Nullable)key;

+ (NSData *)hmacFromString:(NSString * _Nullable)string keyString:(NSString * _Nullable)keyString;

/**
 *  AES加密，传入iv是cbc，不传入ecb模式
 *
 *  @param string    要加密的字符串
 *  @param keyString 加密密钥
 *  @param iv        初始化向量(8个字节)
 *
 *  @return 返回加密后的base64编码字符串
 */
+ (NSString *)aesEncryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData * _Nullable)iv;

/**
 *  AES解密，传入iv是cbc，不传入ecb模式
 *
 *  @param string    加密并base64编码后的字符串
 *  @param keyString 解密密钥
 *  @param iv        初始化向量(8个字节)
 *
 *  @return 返回解密后的字符串
 */
+ (NSString *)aesDecryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData * _Nullable)iv;


/// aes加密二进制数据，传入iv是cbc，不传入ecb模式
/// @param data 要加密的二进制数据
/// @param keyString 加密密钥
/// @param iv 初始化向量

+ (NSData *)aesEncryptData:(NSData *)data keyString:(NSString *)keyString iv:(NSData * _Nullable)iv;

/// aes解密二进制数据，传入iv是cbc，不传入ecb模式
/// @param data 要解密的二进制数据
/// @param keyString 解密密钥
/// @param iv 初始化向量
+ (NSData *)aesDecryptData:(NSData *)data keyString:(NSString *)keyString iv:(NSData * _Nullable)iv;


/**
 *  DES加密
 *
 *  @param string    要加密的字符串
 *  @param keyString 加密密钥
 *  @param iv        初始化向量(8个字节)
 *
 *  @return 返回加密后的base64编码字符串
 */
+ (NSString *)desEncryptString:(NSString * _Nullable)string keyString:(NSString * _Nullable)keyString iv:(NSData * _Nullable)iv;

/**
 *  DES解密
 *
 *  @param string    加密并base64编码后的字符串
 *  @param keyString 解密密钥
 *  @param iv        初始化向量(8个字节)
 *
 *  @return 返回解密后的字符串
 */
+ (NSString *)desDecryptString:(NSString * _Nullable)string keyString:(NSString * _Nullable)keyString iv:(NSData * _Nullable)iv;


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
+ (NSData *)base64Encode:(NSString *)string;

+ (NSString *)base64Decode:(NSString *)string;


@end

NS_ASSUME_NONNULL_END
