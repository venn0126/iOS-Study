//
//  DYFCryptoUtils.h
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

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface DYFCryptoUtils : NSObject

// Create a Base-64 encoded NSString from the receiver's contents.
+ (NSString *)base64EncodedString:(NSString *)string;
+ (NSString *)base64EncodedStringWithData:(NSData *)data;

// Create an NSData from a Base-64 encoded NSString. By default, returns nil when the input is not recognized as valid Base-64.
+ (NSString *)base64DecodedString:(NSString *)base64String;
+ (NSString *)base64DecodedStringWithData:(NSData *)base64Data;

// Create a Base-64, UTF-8 encoded NSData from the receiver's contents.
+ (NSData *)base64EncodedData:(NSData *)data;
+ (NSData *)base64EncodedDataWithString:(NSString *)string;

// Create an NSData from a Base-64, UTF-8 encoded NSData. By default, returns nil when the input is not recognized as valid Base-64.
+ (NSData *)base64DecodedData:(NSData *)base64Data;
+ (NSData *)base64DecodedDataWithString:(NSString *)base64String;

// Create a 32 bit MD5 encoded NSString from the receiver's contents.
+ (NSString *)MD5EncodedString:(NSString *)string;
// Create a 16 bit MD5 encoded NSString from the receiver's contents.
+ (NSString *)bit16MD5EncodedString:(NSString *)string;

// Create a DES encoded NSString from the receiver's contents using the given key.
+ (NSString *)DESEncrypt:(NSString *)string key:(NSString *)key;
// Create a DES encoded NSString from the receiver's contents using the given key and iv.
+ (NSString *)DESEncrypt:(NSString *)string key:(NSString *)key iv:(NSString *)iv;

// Create a DES decoded NSString from the receiver's contents using the given key.
+ (NSString *)DESDecrypt:(NSString *)string key:(NSString *)key;
// Create a DES decoded NSString from the receiver's contents using the given key and iv.
+ (NSString *)DESDecrypt:(NSString *)string key:(NSString *)key iv:(NSString *)iv;

// Create an AES encoded NSString from the receiver's contents using the given key.
+ (NSString *)AESEncrypt:(NSString *)string key:(NSString *)key;
// Create an AES encoded NSString from the receiver's contents using the given key and iv.
+ (NSString *)AESEncrypt:(NSString *)string key:(NSString *)key iv:(NSString *)iv;

// Create an AES decoded NSString from the receiver's contents using the given key.
+ (NSString *)AESDecrypt:(NSString *)string key:(NSString *)key;
// Create an AES decoded NSString from the receiver's contents using the given key and iv.
+ (NSString *)AESDecrypt:(NSString *)string key:(NSString *)key iv:(NSString *)iv;

// Create a RSA encoded NSString from the receiver's contents using the given public key.
+ (NSString *)RSAEncrypt:(NSString *)string publicKey:(NSString *)pubKey;
// Create a RSA decoded NSString from the receiver's contents using the given private key.
+ (NSString *)RSADecrypt:(NSString *)string privateKey:(NSString *)privKey;

// Create a RSA signed NSString from the receiver's contents using the given private key.
+ (NSString *)RSASign:(NSString *)string privateKey:(NSString *)privKey;
// Verify a RSA signature from the receiver's contents using the given public key.
+ (BOOL)RSAVerify:(NSString *)string signature:(NSString *)sign publicKey:(NSString *)pubKey;



//加密
+(NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key;
//解密
+(NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key;


@end
