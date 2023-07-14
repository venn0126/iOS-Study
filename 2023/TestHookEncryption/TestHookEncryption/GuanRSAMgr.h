//
//  GuanRSAMgr.h
//  TestHookEncryption
//
//  Created by Augus on 2023/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GuanRSAMgr : NSObject

@property (nonatomic, nullable) NSString *publicKey;
@property (nonatomic, nullable) NSString *privateKey;

- (void)generate:(int)keySize;
- (void)deletePrivateKey;

- (NSString *)encodedPublicKey;
- (NSString *)encodedPrivateKey;

- (NSString *)encrypt:(NSString *)message;
- (NSString *)decrypt:(NSString *)encodedMessage;

- (NSString *)encrypt64:(NSString *)message;
- (NSString *)decrypt64:(NSString *)encodedMessage;

- (NSData *)_encrypt:(NSData *)message;
- (NSData *)_decrypt:(NSData *)encodedMessage;

- (NSString *)sign:(NSString *)message withAlgorithm:(SecKeyAlgorithm)algorithm andError:(NSError **)anError;
- (BOOL)verify:(NSString *)signature withMessage:(NSString *)message andAlgorithm:(SecKeyAlgorithm)algorithm;

- (NSString *)sign64:(NSString *)b64message withAlgorithm:(SecKeyAlgorithm)algorithm andError:(NSError **)anError;
- (BOOL)verify64:(NSString *)signature withMessage:(NSString *)b64message andAlgorithm:(SecKeyAlgorithm)algorithm;

- (NSString *)_sign:(NSData *)messageBytes withAlgorithm:(SecKeyAlgorithm)algorithm andError:(NSError**)anError;
- (BOOL)_verify:(NSData *)signatureBytes withMessage:(NSData *)messageBytes andAlgorithm:(SecKeyAlgorithm)algorithm;

- (NSUInteger)getKeyLength;

+ (NSString *)PEMFormattedPublicKey:(NSData *)publicKeyData;
+ (NSString *)PEMFormattedPrivateKey:(NSData *)privateKeyData;
+ (NSString *)stripHeaders:(NSString *)pemString;

@end

NS_ASSUME_NONNULL_END
