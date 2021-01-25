//
//  DYFCryptoUtils.m
//
//  Created by dyf on 2017/10/10.
//  Copyright © 2017 dyf. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "DYFCryptoUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

// Warning: Note the following functions hooked by hackers or senior reverse engineers.
//
// DES/AES ==> CCCrypt
//   RSA   ==> SecKeyEncrypt
//   RSA   ==> SecKeyDecrypt
//   RSA   ==> SecKeyRawSign
//   RSA   ==> SecKeyRawVerify
//

@implementation DYFCryptoUtils

+ (NSString *)base64EncodedString:(NSString *)string {
    NSData *plainData = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self base64EncodedStringWithData:plainData];
}

+ (NSString *)base64EncodedStringWithData:(NSData *)data {
    return [data base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
}

+ (NSString *)base64DecodedString:(NSString *)base64String {
    return [self base64DecodedStringWithData:[base64String dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (NSString *)base64DecodedStringWithData:(NSData *)base64Data {
    NSData *plainData = [self base64DecodedData:base64Data];
    return [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
}

+ (NSData *)base64EncodedData:(NSData *)data {
    return [data base64EncodedDataWithOptions:(NSDataBase64EncodingOptions)0];
}

+ (NSData *)base64EncodedDataWithString:(NSString *)string {
    return [self base64EncodedData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (NSData *)base64DecodedData:(NSData *)base64Data {
    return [[NSData alloc] initWithBase64EncodedData:base64Data options:(NSDataBase64DecodingOptions)0];
}

+ (NSData *)base64DecodedDataWithString:(NSString *)base64String {
    return [[NSData alloc] initWithBase64EncodedString:base64String options:(NSDataBase64DecodingOptions)0];
}

+ (NSString *)MD5EncodedString:(NSString *)string {
    if (string) {
        const char *c_str = [string UTF8String];
        unsigned char digest[CC_MD5_DIGEST_LENGTH];
        CC_MD5(c_str, (CC_LONG)strlen(c_str), digest);
        
        NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
        
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
            [result appendFormat:@"%02x", digest[i]];
        }
        
        return result;
    }
    return nil;
}

+ (NSString *)bit16MD5EncodedString:(NSString *)string {
    NSString *hashValue = [self MD5EncodedString:string];
    if (hashValue && hashValue.length > 0) {
        NSUInteger fromIndex = 8;
        NSUInteger toIndex = 24;
        NSUInteger len = toIndex - fromIndex;
        return [hashValue substringWithRange:NSMakeRange(fromIndex, len)];
    }
    return nil;
}

#pragma mark - DES Private Method

+ (NSData *)dataUsingDESWithData:(NSData *)contentData key:(NSString *)key iv:(NSString *)iv operation:(CCOperation)operation {
    NSUInteger dataLength       = contentData.length;
    
    const void *keyBytes        = [key dataUsingEncoding:NSUTF8StringEncoding].bytes;
    const void *initVectorBytes = [iv dataUsingEncoding:NSUTF8StringEncoding].bytes;
    const void *contentBytes    = contentData.bytes;
    
    size_t operationSize = dataLength + kCCBlockSizeDES;
    void *operationBytes = malloc(operationSize);
    
    if (operationBytes == NULL) {
        return nil;
    }
    
    size_t actualOutSize = 0;
    
    CCCryptorStatus ccStatus = CCCrypt(operation,
                                       kCCAlgorithmDES,
                                       kCCOptionPKCS7Padding|kCCOptionECBMode,
                                       keyBytes,
                                       kCCKeySizeDES,
                                       initVectorBytes,
                                       contentBytes,
                                       dataLength,
                                       operationBytes,
                                       operationSize,
                                       &actualOutSize);
    
    NSData *outputData = nil;
    
    if (ccStatus == kCCSuccess) {
        outputData = [NSData dataWithBytes:operationBytes length:actualOutSize];
    }
    
    free(operationBytes);
    operationBytes = NULL;
    
    return outputData;
}

+ (NSString *)DESEncrypt:(NSString *)string key:(NSString *)key {
    return [self DESEncrypt:string key:key iv:nil];
}

+ (NSString *)DESEncrypt:(NSString *)string key:(NSString *)key iv:(NSString *)iv {
    NSData *data          = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [self dataUsingDESWithData:data
                                                   key:key
                                                    iv:iv
                                             operation:kCCEncrypt];
    return [self base64EncodedStringWithData:encryptedData];
}

+ (NSString *)DESDecrypt:(NSString *)string key:(NSString *)key {
    return [self DESDecrypt:string key:key iv:nil];
}

+ (NSString *)DESDecrypt:(NSString *)string key:(NSString *)key iv:(NSString *)iv {
    NSData *encryptedData = [self base64DecodedDataWithString:string];
    NSData *decryptedData = [self dataUsingDESWithData:encryptedData
                                                   key:key
                                                    iv:iv
                                             operation:kCCDecrypt];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

#pragma mark - AES Private Method

+ (NSData *)dataUsingAESWithData:(NSData *)contentData key:(NSString *)key iv:(NSString *)iv operation:(CCOperation)operation {
    NSUInteger dataLength       = contentData.length;
    
    const void *keyBytes        = [key dataUsingEncoding:NSUTF8StringEncoding].bytes;
    const void *initVectorBytes = [iv dataUsingEncoding:NSUTF8StringEncoding].bytes;
    const void *contentBytes    = contentData.bytes;
    
    size_t operationSize        = dataLength + kCCBlockSizeAES128;
    void *operationBytes        = malloc(operationSize);
    
    if (operationBytes == NULL) {
        return nil;
    }
    
    size_t actualOutSize = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyBytes,
                                          kCCKeySizeAES128,
                                          initVectorBytes,
                                          contentBytes,
                                          dataLength,
                                          operationBytes,
                                          operationSize,
                                          &actualOutSize);
    
    NSData *outputData = nil;
    
    if (cryptStatus == kCCSuccess) {
        outputData = [NSData dataWithBytes:operationBytes length:actualOutSize];
    }
    
    free(operationBytes);
    operationBytes = NULL;
    
    return outputData;
}

#pragma mark - AES Public Method

+ (NSString *)AESEncrypt:(NSString *)string key:(NSString *)key {
    return [self AESEncrypt:string key:key iv:nil];
}

+ (NSString *)AESEncrypt:(NSString *)string key:(NSString *)key iv:(NSString *)iv {
    NSData *plainData     = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [self dataUsingAESWithData:plainData
                                                   key:key
                                                    iv:iv
                                             operation:kCCEncrypt];
    return [self base64EncodedStringWithData:encryptedData];
}

+ (NSString *)AESDecrypt:(NSString *)string key:(NSString *)key {
    return [self AESDecrypt:string key:key iv:nil];
}

+ (NSString *)AESDecrypt:(NSString *)string key:(NSString *)key iv:(NSString *)iv {
    NSData *encryptedData = [self base64DecodedDataWithString:string];
    NSData *decryptedData = [self dataUsingAESWithData:encryptedData
                                                   key:key
                                                    iv:iv
                                             operation:kCCDecrypt];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

#pragma mark - RSA Private Method

- (SecKeyRef)getPublicKeyFromData:(NSData *)derData {
    SecCertificateRef myCertificate = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)derData);
    SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
    
    SecTrustRef myTrust;
    
    OSStatus status = SecTrustCreateWithCertificates(myCertificate, myPolicy, &myTrust);
    SecTrustResultType trustResult;
    if (status == noErr) {
        status = SecTrustEvaluate(myTrust, &trustResult);
    }
    
    SecKeyRef secKeyRef = SecTrustCopyPublicKey(myTrust);
    CFRelease(myCertificate);
    CFRelease(myPolicy);
    CFRelease(myTrust);
    
    return secKeyRef;
}

- (SecKeyRef)getPrivateKeyFromData:(NSData *)p12Data secImpExpPassphrase:(NSString *)passphrase {
    SecKeyRef privKeyRef = NULL;
    
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    [options setObject:passphrase forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    
    OSStatus secError = SecPKCS12Import((__bridge CFDataRef)p12Data, (__bridge CFDictionaryRef)options, &items);
    if (secError == noErr && CFArrayGetCount(items) > 0) {
        
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        
        SecIdentityRef identityRef = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
        
        secError = SecIdentityCopyPrivateKey(identityRef, &privKeyRef);
        
        if (secError != noErr) {
            privKeyRef = NULL;
        }
    }
    
    CFRelease(items);
    
    return privKeyRef;
}

+ (NSData *)stripPublicKeyHeader:(NSData *)d_key {
    // Skip ASN.1 public key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx    = 0;
    
    if (c_key[idx++] != 0x30) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    // PKCS #1 rsaEncryption szOID_RSA_RSA
    static unsigned char seqiod[] = { 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
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
+ (NSData *)stripPrivateKeyHeader:(NSData *)d_key {
    // Skip ASN.1 private key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx    = 22; //magic byte at offset 22
    
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

+ (SecKeyRef)getPublicKeyRef:(NSString *)key {
    NSRange spos = [key rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END PUBLIC KEY-----"];
    if (spos.location != NSNotFound && epos.location != NSNotFound) {
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
    NSData *data = [self base64DecodedDataWithString:key];
    data = [self stripPublicKeyHeader:data];
    if (!data) {
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"cr_rsa_pubkey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *pubKeyDict = [[NSMutableDictionary alloc] init];
    [pubKeyDict setObject:(__bridge id)kSecClassKey forKey:(__bridge id)kSecClass];
    [pubKeyDict setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [pubKeyDict setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)pubKeyDict);
    
    // Add persistent version of the key to system keychain
    [pubKeyDict setObject:data forKey:(__bridge id)kSecValueData];
    [pubKeyDict setObject:(__bridge id)kSecAttrKeyClassPublic forKey:(__bridge id)
     kSecAttrKeyClass];
    [pubKeyDict setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)pubKeyDict, &persistKey);
    if (persistKey != nil) {
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [pubKeyDict removeObjectForKey:(__bridge id)kSecValueData];
    [pubKeyDict removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [pubKeyDict setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [pubKeyDict setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)pubKeyDict, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    
    return keyRef;
}

+ (SecKeyRef)getPrivateKeyRef:(NSString *)key {
    NSRange spos = [key rangeOfString:@"-----BEGIN PRIVATE KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END PRIVATE KEY-----"];
    if (spos.location != NSNotFound && epos.location != NSNotFound) {
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
    NSData *data = [self base64DecodedDataWithString:key];
    data = [self stripPrivateKeyHeader:data];
    if (!data) {
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"cr_rsa_privkey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *privKeyDict = [[NSMutableDictionary alloc] init];
    [privKeyDict setObject:(__bridge id)kSecClassKey forKey:(__bridge id)kSecClass];
    [privKeyDict setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [privKeyDict setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)privKeyDict);
    
    // Add persistent version of the key to system keychain
    [privKeyDict setObject:data forKey:(__bridge id)kSecValueData];
    [privKeyDict setObject:(__bridge id)kSecAttrKeyClassPrivate forKey:(__bridge id)
     kSecAttrKeyClass];
    [privKeyDict setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)privKeyDict, &persistKey);
    if (persistKey != nil) {
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [privKeyDict removeObjectForKey:(__bridge id)kSecValueData];
    [privKeyDict removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [privKeyDict setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [privKeyDict setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)privKeyDict, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    
    return keyRef;
}

#pragma mark - RSA Encrypt

+ (NSString *)RSAEncrypt:(NSString *)string publicKey:(NSString *)pubKey {
    NSData *plainData     = [string dataUsingEncoding:NSUTF8StringEncoding];
    SecKeyRef pubKeyRef   = [self getPublicKeyRef:pubKey];
    NSData *encryptedData = [self RSAEncryptData:plainData publicKeyRef:pubKeyRef];
    
    CFRelease(pubKeyRef);
    
    return [self base64EncodedStringWithData:encryptedData];
}

+ (NSData *)RSAEncryptData:(NSData *)plainData publicKeyRef:(SecKeyRef)pubKeyRef {
    size_t cipherBufferSize = SecKeyGetBlockSize(pubKeyRef);
    uint8_t *cipherBuffer   = malloc(cipherBufferSize * sizeof(uint8_t));
    size_t blockSize        = cipherBufferSize - 11;
    size_t blockCount       = (size_t)ceil([plainData length] / (double)blockSize);
    
    NSMutableData *encryptedData = [NSMutableData data];
    
    for (int i = 0; i < blockCount; i++) {
        unsigned long bufferSize = MIN(blockSize, [plainData length] - i * blockSize);
        
        NSData *buffer  = [plainData subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(pubKeyRef,
                                        kSecPaddingPKCS1,
                                        (const uint8_t *)[buffer bytes],
                                        [buffer length],
                                        cipherBuffer,
                                        &cipherBufferSize);
        
        if (status != noErr) {
            return nil;
        }
        
        NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
        
        [encryptedData appendData:encryptedBytes];
    }
    
    if (cipherBuffer){
        free(cipherBuffer);
    }
    
    return encryptedData;
}

#pragma mark - RSA Decrypt

+ (NSString *)RSADecrypt:(NSString *)string privateKey:(NSString *)privKey {
    NSData *cipherData    = [self base64DecodedDataWithString:string];
    SecKeyRef privKeyRef  = [self getPrivateKeyRef:privKey];
    NSData *decryptedData = [self RSADecryptData:cipherData privateKeyRef:privKeyRef];
    
    CFRelease(privKeyRef);
    
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

+ (NSData *)RSADecryptData:(NSData *)cipherData privateKeyRef:(SecKeyRef)privKeyRef {
    size_t cipherBufferSize = SecKeyGetBlockSize(privKeyRef);
    size_t blockSize        = cipherBufferSize;
    size_t blockCount       = (size_t)ceil([cipherData length] / (double)blockSize);
    
    NSMutableData *decryptedData = [NSMutableData data];
    
    for (int i = 0; i < blockCount; i++) {
        unsigned long bufferSize = MIN(blockSize, [cipherData length] - i * blockSize);
        NSData *buffer   = [cipherData subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        
        size_t cipherLen = [buffer length];
        void *cipher     = malloc(cipherLen);
        [buffer getBytes:cipher length:cipherLen];
        size_t plainLen  = SecKeyGetBlockSize(privKeyRef);
        void *plain      = malloc(plainLen);
        
        OSStatus status = SecKeyDecrypt(privKeyRef, kSecPaddingPKCS1, cipher, cipherLen, plain, &plainLen);
        
        if (status != noErr) {
            return nil;
        }
        
        NSData *decryptedBytes = [[NSData alloc] initWithBytes:(const void *)plain length:plainLen];
        
        [decryptedData appendData:decryptedBytes];
    }
    
    return decryptedData;
}

#pragma mark - RSA Sign

+ (NSString *)RSASign:(NSString *)string privateKey:(NSString *)privKey {
    NSData *plainData    = [string dataUsingEncoding:NSUTF8StringEncoding];
    SecKeyRef privKeyRef = [self getPrivateKeyRef:privKey];
    NSData *signData     = [self RSASignData:plainData privateKeyRef:privKeyRef];
    
    CFRelease(privKeyRef);
    
    return [self base64EncodedStringWithData:signData];
}

#pragma mark - RSA Verify

+ (BOOL)RSAVerify:(NSString *)string signature:(NSString *)sign publicKey:(NSString *)pubKey {
    NSData *plainData   = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *signData    = [self base64DecodedDataWithString:sign];
    SecKeyRef pubKeyRef = [self getPublicKeyRef:pubKey];
    
    BOOL ret = [self RSAVerifyData:plainData signature:signData publicKeyRef:pubKeyRef];
    CFRelease(pubKeyRef);
    return ret;
}

+ (NSData *)RSASignData:(NSData *)plainData privateKeyRef:(SecKeyRef)privKeyRef {
    size_t signedHashBytesSize = SecKeyGetBlockSize(privKeyRef);
    uint8_t *signedHashBytes   = malloc(signedHashBytesSize);
    
    memset(signedHashBytes, 0x0, signedHashBytesSize);
    
    size_t hashBytesSize = CC_SHA256_DIGEST_LENGTH;
    uint8_t *hashBytes   = malloc(hashBytesSize);
    
    if (!CC_SHA256([plainData bytes], (CC_LONG)[plainData length], hashBytes)) {
        return nil;
    }
    
    SecKeyRawSign(privKeyRef,
                  kSecPaddingPKCS1SHA256,
                  hashBytes,
                  hashBytesSize,
                  signedHashBytes,
                  &signedHashBytesSize);
    
    NSData *signedHash = [NSData dataWithBytes:signedHashBytes length:(NSUInteger)signedHashBytesSize];
    
    if (hashBytes)
        free(hashBytes);
    if (signedHashBytes)
        free(signedHashBytes);
    
    return signedHash;
}

+ (BOOL)RSAVerifyData:(NSData *)plainData signature:(NSData *)sign publicKeyRef:(SecKeyRef)pubKeyRef {
    size_t signedHashBytesSize  = SecKeyGetBlockSize(pubKeyRef);
    const void *signedHashBytes = [sign bytes];
    
    size_t hashBytesSize = CC_SHA256_DIGEST_LENGTH;
    uint8_t *hashBytes   = malloc(hashBytesSize);
    
    if (!CC_SHA256([plainData bytes], (CC_LONG)[plainData length], hashBytes)) {
        return NO;
    }
    
    OSStatus status = SecKeyRawVerify(pubKeyRef,
                                      kSecPaddingPKCS1SHA256,
                                      hashBytes,
                                      hashBytesSize,
                                      signedHashBytes,
                                      signedHashBytesSize);
    
    return status == errSecSuccess;
}

@end
