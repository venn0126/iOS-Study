//
//  GuanEncryptionManger.m
//  TestHookEncryption
//
//  Created by Augus on 2023/7/14.
//

#import "GuanEncryptionManger.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonKeyDerivation.h>



@implementation GuanEncryptionManger


+ (NSString *)md5FromData:(NSData *)data {
    
//    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(self)];
    //1: 创建一个MD5对象
    CC_MD5_CTX md5;
    //2: 初始化MD5
    CC_MD5_Init(&md5);
    //3: 准备MD5加密
    CC_MD5_Update(&md5, data.bytes, (CC_LONG)data.length);
    //4: 准备一个字符串数组, 存储MD5加密之后的数据
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //5: 结束MD5加密
    CC_MD5_Final(result, &md5);
    NSMutableString *resultString = [NSMutableString string];
    //6:从result数组中获取最终结果
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString appendFormat:@"%02X", result[i]];
    }
    return resultString;
    
}


+ (NSString *)md5FromString:(NSString *)string {
    if(string == nil || [string length] == 0)
        return nil;
    
    const char *value = [string UTF8String];
    unsigned int strlength = (int)strlen(value);
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlength, outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}


+ (NSString *)sha512FromString:(NSString *)string {
    
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString  stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
    
}


+ (NSData *)sha:(NSData *)input type:(NSString *)type {
    NSDictionary *algMap = @{
        @"SHA-1" : [NSNumber numberWithInt:CC_SHA1_DIGEST_LENGTH],
        @"SHA-256" : [NSNumber numberWithInt:CC_SHA256_DIGEST_LENGTH],
        @"SHA-512" : [NSNumber numberWithInt:CC_SHA512_DIGEST_LENGTH],
    };

    int digestLength = [[algMap valueForKey:type] intValue];
    if (digestLength == 0) {
        [NSException raise:@"Invalid hash algorithm" format:@"%@ is not a valid hash algorithm", type];
    }

    if (digestLength == CC_SHA1_DIGEST_LENGTH) {
        NSMutableData *result = [[NSMutableData alloc] initWithLength:CC_SHA1_DIGEST_LENGTH];
        CC_SHA1([input bytes], (CC_LONG)[input length], result.mutableBytes);
        return result;
    } else {
        unsigned char* buffer = malloc(digestLength);
        if (digestLength == CC_SHA256_DIGEST_LENGTH) {
            CC_SHA256([input bytes], (CC_LONG)[input length], buffer);
        } else {
            CC_SHA512([input bytes], (CC_LONG)[input length], buffer);
        }
        return [NSData dataWithBytesNoCopy:buffer length:digestLength freeWhenDone:YES];
    }
}

+ (NSString *)shaUtf8:(NSString *)input type:(NSString *)type {
    NSData* inputData = [input dataUsingEncoding:NSUTF8StringEncoding];
    NSData* result = [self sha:inputData type:type];
    return [GuanEncryptionManger toHex:result];
}

+ (NSString *)shaBase64:(NSString *)input type:(NSString *)type {
    NSData* inputData = [[NSData alloc] initWithBase64EncodedString:input options:0];
    NSData* result = [self sha:inputData type:type];
    return [result base64EncodedStringWithOptions:0];
}


+ (NSString *)hmacFromData:(NSData *)data key:(NSData *)key {
    if(!data || data.length == 0) return nil;
    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, key.bytes, key.length, data.bytes, data.length, macOut.mutableBytes);
    return macOut;
}

+ (NSString *)hmacFromString:(NSString *)string keyString:(NSString *)keyString {
    
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *stringData = [NSData dataWithBytes:cstr length:string.length];
    
    const char *keyStr = [keyString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *KeyData = [NSData dataWithBytes:keyStr length:keyString.length];
    
    return [self hmacFromData:stringData key:KeyData];
}


//AES加密
+ (NSString *)aesEncryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData *)iv {
   // 设置秘钥
   NSData *keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
   uint8_t cKey[kCCKeySizeAES128];
   bzero(cKey, sizeof(cKey));
   [keyData getBytes:cKey length:kCCKeySizeAES128];
   
   // 设置iv
   uint8_t cIv[kCCBlockSizeAES128];
   bzero(cIv, kCCBlockSizeAES128);
   int option = 0;
   if (iv) {
       [iv getBytes:cIv length:kCCBlockSizeAES128];
       option = kCCOptionPKCS7Padding;
   } else {
       option = kCCOptionPKCS7Padding | kCCOptionECBMode;
   }
   
   // 设置输出缓冲区
   NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
   size_t bufferSize = [data length] + kCCBlockSizeAES128;
   void *buffer = malloc(bufferSize);
   
   // 开始加密
   size_t encryptedSize = 0;
   
   /**
    @constant   kCCAlgorithmAES     高级加密标准，128位(默认)
    @constant   kCCAlgorithmDES     数据加密标准
    */
   CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                         kCCAlgorithmAES,
                                         option,
                                         cKey,
                                         kCCKeySizeAES128,
                                         cIv,
                                         [data bytes],
                                         [data length],
                                         buffer,
                                         bufferSize,
                                         &encryptedSize);
   
   NSData *result = nil;
   if (cryptStatus == kCCSuccess) {
       result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
   } else {
       free(buffer);
       NSLog(@"[错误] 加密失败|状态编码: %d", cryptStatus);
   }
   
   return [result base64EncodedStringWithOptions:0];
}

//AES解密
+ (NSString *)aesDecryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData *)iv {
   // 设置秘钥
   NSData *keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
   uint8_t cKey[kCCKeySizeAES128];
   bzero(cKey, sizeof(cKey));
   [keyData getBytes:cKey length:kCCKeySizeAES128];
   
   // 设置iv
   uint8_t cIv[kCCBlockSizeAES128];
   bzero(cIv, kCCBlockSizeAES128);
   int option = 0;
   if (iv) {
       [iv getBytes:cIv length:kCCBlockSizeAES128];
       option = kCCOptionPKCS7Padding;
   } else {
       option = kCCOptionPKCS7Padding | kCCOptionECBMode;
   }
   
   // 设置输出缓冲区，options参数很多地方是直接写0，但是在实际过程中可能出现回车的字符串导致解不出来
   NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
   
   size_t bufferSize = [data length] + kCCBlockSizeAES128;
   void *buffer = malloc(bufferSize);
   
   // 开始解密
   size_t decryptedSize = 0;
   CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                         kCCAlgorithmAES128,
                                         option,
                                         cKey,
                                         kCCKeySizeAES128,
                                         cIv,
                                         [data bytes],
                                         [data length],
                                         buffer,
                                         bufferSize,
                                         &decryptedSize);
   
   NSData *result = nil;
   if (cryptStatus == kCCSuccess) {
       result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
   } else {
       free(buffer);
       NSLog(@"[错误] 解密失败|状态编码: %d", cryptStatus);
   }
   
   return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

//DES加密
+ (NSString *)desEncryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData *)iv {
   // 设置秘钥
   NSData *keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
   uint8_t cKey[kCCKeySizeDES];
   bzero(cKey, sizeof(cKey));
   [keyData getBytes:cKey length:kCCKeySizeDES];
   
   // 设置iv
   uint8_t cIv[kCCBlockSizeDES];
   bzero(cIv, kCCBlockSizeDES);
   int option = 0;
   if (iv) {
       [iv getBytes:cIv length:kCCBlockSizeDES];
       option = kCCOptionPKCS7Padding;
   } else {
       option = kCCOptionPKCS7Padding | kCCOptionECBMode;
   }
   
   // 设置输出缓冲区
   NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
   size_t bufferSize = [data length] + kCCBlockSizeDES;
   void *buffer = malloc(bufferSize);
   
   // 开始加密
   size_t encryptedSize = 0;
   
   CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                         kCCAlgorithmDES,
                                         option,
                                         cKey,
                                         kCCKeySizeDES,
                                         cIv,
                                         [data bytes],
                                         [data length],
                                         buffer,
                                         bufferSize,
                                         &encryptedSize);
   
   NSData *result = nil;
   if (cryptStatus == kCCSuccess) {
       result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
   } else {
       free(buffer);
       NSLog(@"[错误] 加密失败|状态编码: %d", cryptStatus);
   }
   
   return [result base64EncodedStringWithOptions:0];
}

//DES解密
+ (NSString *)desDecryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData *)iv {
   // 设置秘钥
   NSData *keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
   uint8_t cKey[kCCKeySizeDES];
   bzero(cKey, sizeof(cKey));
   [keyData getBytes:cKey length:kCCKeySizeDES];
   
   // 设置iv
   uint8_t cIv[kCCBlockSizeDES];
   bzero(cIv, kCCBlockSizeDES);
   int option = 0;
   if (iv) {
       [iv getBytes:cIv length:kCCBlockSizeDES];
       option = kCCOptionPKCS7Padding;
   } else {
       option = kCCOptionPKCS7Padding | kCCOptionECBMode;
   }
   
   // 设置输出缓冲区，options参数很多地方是直接写0，但是在实际过程中可能出现回车的字符串导致解不出来
   NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];

   size_t bufferSize = [data length] + kCCBlockSizeDES;
   void *buffer = malloc(bufferSize);
   
   // 开始解密
   size_t decryptedSize = 0;
   CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                         kCCAlgorithmDES,
                                         option,
                                         cKey,
                                         kCCKeySizeDES,
                                         cIv,
                                         [data bytes],
                                         [data length],
                                         buffer,
                                         bufferSize,
                                         &decryptedSize);
   
   NSData *result = nil;
   if (cryptStatus == kCCSuccess) {
       result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
   } else {
       free(buffer);
       NSLog(@"[错误] 解密失败|状态编码: %d", cryptStatus);
   }
   
   return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}


NSString *base64_encode_data(NSData *data) {
    data = [data base64EncodedDataWithOptions:0];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

NSData *base64_decode(NSString *str) {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

+ (NSData *)stripPublicKeyHeader:(NSData *)d_key{
    // Skip ASN.1 public key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx     = 0;
    
    if (c_key[idx++] != 0x30) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    // PKCS #1 rsaEncryption szOID_RSA_RSA
    static unsigned char seqiod[] =
    { 0x30,   0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x01, 0x05, 0x00 };
    if (memcmp(&c_key[idx], seqiod, 15)) return(nil);
    
    idx += 15;
    
    if (c_key[idx++] != 0x03) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    if (c_key[idx++] != '\0') return(nil);
    
    // Now make a new NSData from this buffer
    return([NSData dataWithBytes:&c_key[idx] length:len - idx]);
}

//credit: http://hg.mozilla.org/services/fx-home/file/tip/Sources/NetworkAndStorage/CryptoUtils.m#l1036
+ (NSData *)stripPrivateKeyHeader:(NSData *)d_key{
    // Skip ASN.1 private key header
    if (d_key == nil) return(nil);

    unsigned long len = [d_key length];
    if (!len) return(nil);

    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx     = 22; //magic byte at offset 22

    if (0x04 != c_key[idx++]) return nil;

    //calculate length of the key
    unsigned int c_len = c_key[idx++];
    int det = c_len & 0x80;
    if (!det) {
        c_len = c_len & 0x7f;
    } else {
        int byteCount = c_len & 0x7f;
        if (byteCount + idx > len) {
            //rsa length field longer than buffer
            return nil;
        }
        unsigned int accum = 0;
        unsigned char *ptr = &c_key[idx];
        idx += byteCount;
        while (byteCount) {
            accum = (accum << 8) + *ptr;
            ptr++;
            byteCount--;
        }
        c_len = accum;
    }

    // Now make a new NSData from this buffer
    return [d_key subdataWithRange:NSMakeRange(idx, c_len)];
}

+ (SecKeyRef)addPublicKey:(NSString *)key{
    NSRange spos = [key rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END PUBLIC KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = base64_decode(key);
    data = [GuanEncryptionManger stripPublicKeyHeader:data];
    if(!data){
        return nil;
    }

    //a tag to read/write keychain storage
    NSString *tag = @"RSAUtil_PubKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *publicKey = [[NSMutableDictionary alloc] init];
    [publicKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [publicKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)publicKey);
    
    // Add persistent version of the key to system keychain
    [publicKey setObject:data forKey:(__bridge id)kSecValueData];
    [publicKey setObject:(__bridge id) kSecAttrKeyClassPublic forKey:(__bridge id)
     kSecAttrKeyClass];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }

    [publicKey removeObjectForKey:(__bridge id)kSecValueData];
    [publicKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

+ (SecKeyRef)addPrivateKey:(NSString *)key{
    NSRange spos;
    NSRange epos;
    spos = [key rangeOfString:@"-----BEGIN RSA PRIVATE KEY-----"];
    if(spos.length > 0){
        epos = [key rangeOfString:@"-----END RSA PRIVATE KEY-----"];
    }else{
        spos = [key rangeOfString:@"-----BEGIN PRIVATE KEY-----"];
        epos = [key rangeOfString:@"-----END PRIVATE KEY-----"];
    }
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];

    // This will be base64 encoded, decode it.
    NSData *data = base64_decode(key);
    data = [GuanEncryptionManger stripPrivateKeyHeader:data];
    if(!data){
        return nil;
    }

    //a tag to read/write keychain storage
    NSString *tag = @"RSAUtil_PrivKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];

    // Delete any old lingering key with the same tag
    NSMutableDictionary *privateKey = [[NSMutableDictionary alloc] init];
    [privateKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [privateKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)privateKey);

    // Add persistent version of the key to system keychain
    [privateKey setObject:data forKey:(__bridge id)kSecValueData];
    [privateKey setObject:(__bridge id) kSecAttrKeyClassPrivate forKey:(__bridge id)
     kSecAttrKeyClass];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];

    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)privateKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }

    [privateKey removeObjectForKey:(__bridge id)kSecValueData];
    [privateKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];

    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

/* START: Encryption & Decryption with RSA private key */

+ (NSData *)encryptData:(NSData *)data withKeyRef:(SecKeyRef) keyRef isSign:(BOOL)isSign {
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    void *outbuf = malloc(block_size);
    size_t src_block_size = block_size - 11;
    
    NSMutableData *ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        
        size_t outlen = block_size;
        OSStatus status = noErr;
        
        if (isSign) {
            status = SecKeyRawSign(keyRef,
                                   kSecPaddingPKCS1,
                                   srcbuf + idx,
                                   data_len,
                                   outbuf,
                                   &outlen
                                   );

        } else {
            status = SecKeyEncrypt(keyRef,
                                   kSecPaddingPKCS1,
                                   srcbuf + idx,
                                   data_len,
                                   outbuf,
                                   &outlen
                                   );
        }
        if (status != 0) {
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            ret = nil;
            break;
        }else{
            [ret appendBytes:outbuf length:outlen];
        }
    }
    
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}

+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey{
    NSData *data = [GuanEncryptionManger encryptData:[str dataUsingEncoding:NSUTF8StringEncoding] privateKey:privKey];
    NSString *ret = base64_encode_data(data);
    return ret;
}

+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey{
    if(!data || !privKey){
        return nil;
    }
    SecKeyRef keyRef = [GuanEncryptionManger addPrivateKey:privKey];
    if(!keyRef){
        return nil;
    }
    return [GuanEncryptionManger encryptData:data withKeyRef:keyRef isSign:YES];
}

+ (NSData *)decryptData:(NSData *)data withKeyRef:(SecKeyRef) keyRef{
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    UInt8 *outbuf = malloc(block_size);
    size_t src_block_size = block_size;
    
    NSMutableData *ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        
        size_t outlen = block_size;
        OSStatus status = noErr;
        // SecKeyCreateDecryptedData
        status = SecKeyDecrypt(keyRef,
                               kSecPaddingNone,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0) {
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            ret = nil;
            break;
        }else{
            //the actual decrypted data is in the middle, locate it!
            int idxFirstZero = -1;
            int idxNextZero = (int)outlen;
            for ( int i = 0; i < outlen; i++ ) {
                if ( outbuf[i] == 0 ) {
                    if ( idxFirstZero < 0 ) {
                        idxFirstZero = i;
                        break;
                    } else {
//                         idxNextZero = i;
//                         break;
                    }
                }
            }
            
            [ret appendBytes:&outbuf[idxFirstZero+1] length:idxNextZero-idxFirstZero-1];
        }
    }
    
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}


+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [GuanEncryptionManger decryptData:data privateKey:privKey];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey{
    if(!data || !privKey){
        return nil;
    }
    SecKeyRef keyRef = [GuanEncryptionManger addPrivateKey:privKey];
    if(!keyRef){
        return nil;
    }
    return [GuanEncryptionManger decryptData:data withKeyRef:keyRef];
}

/* END: Encryption & Decryption with RSA private key */

/* START: Encryption & Decryption with RSA public key */

+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey{
    NSData *data = [GuanEncryptionManger encryptData:[str dataUsingEncoding:NSUTF8StringEncoding] publicKey:pubKey];
    NSString *ret = base64_encode_data(data);
    return ret;
}

+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey{
    if(!data || !pubKey){
        return nil;
    }
    SecKeyRef keyRef = [GuanEncryptionManger addPublicKey:pubKey];
    if(!keyRef){
        return nil;
    }
    return [GuanEncryptionManger encryptData:data withKeyRef:keyRef isSign:NO];
}

+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [GuanEncryptionManger decryptData:data publicKey:pubKey];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey{
    if(!data || !pubKey){
        return nil;
    }
    SecKeyRef keyRef = [GuanEncryptionManger addPublicKey:pubKey];
    if(!keyRef){
        return nil;
    }
    return [GuanEncryptionManger decryptData:data withKeyRef:keyRef];
}


+ (NSString *)pbkdf2Hash:(NSString *)password salt:(NSString *)salt iterations:(int)iterations keyLen:(int)keyLen algorithm:(NSString *)algorithm {
    // Data of String to generate Hash key(hexa decimal string).
       NSData *passwordData = [[NSData alloc]initWithBase64EncodedString:password options:0];
       NSData *saltData = [[NSData alloc]initWithBase64EncodedString:salt options:0];

       // Hash key (hexa decimal) string data length.
       NSMutableData *hashKeyData = [NSMutableData dataWithLength:keyLen];
       
       NSDictionary *algMap = @{
        @"SHA1" : [NSNumber numberWithInt:kCCPRFHmacAlgSHA1],
        @"SHA224" : [NSNumber numberWithInt:kCCPRFHmacAlgSHA224],
        @"SHA256" : [NSNumber numberWithInt:kCCPRFHmacAlgSHA256],
        @"SHA384" : [NSNumber numberWithInt:kCCPRFHmacAlgSHA384],
        @"SHA512" : [NSNumber numberWithInt:kCCPRFHmacAlgSHA512],
       };
       
       int alg = [[algMap valueForKey:algorithm] intValue];

       // Key Derivation using PBKDF2 algorithm.
       int status = CCKeyDerivationPBKDF(
                       kCCPBKDF2,
                       passwordData.bytes,
                       passwordData.length,
                       saltData.bytes,
                       saltData.length,
                       alg,
                       iterations,
                       hashKeyData.mutableBytes,
                       hashKeyData.length);

       if (status == kCCParamError) {
           NSLog(@"Key derivation error");
           return @"";
       }

       return [hashKeyData base64EncodedStringWithOptions:0];
}

+ (NSString *)toHex:(NSData *)nsdata {
    const unsigned char *bytes = (const unsigned char *)nsdata.bytes;
    NSMutableString *hex = [NSMutableString new];
    for (NSInteger i = 0; i < nsdata.length; i++) {
        [hex appendFormat:@"%02x", bytes[i]];
    }
    return [hex copy];
}

+ (NSData *)fromHex: (NSString *)string {
    NSMutableData *data = [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    for (int i = 0; i < ([string length] / 2); i++) {
        byte_chars[0] = [string characterAtIndex:i*2];
        byte_chars[1] = [string characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return data;
}
@end
