//
//  CTID_Encrypt.h
//  CTID_Encrypt
//
//  Created by 万启鹏 on 2019/7/16.
//  Copyright © 2019 anicert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTID_Encrypt : NSObject
int getHashDataCTID_Encrypt(unsigned char* source, int sourcelen, unsigned char* hash);

int getHashCTID_Encrypt(char *alg, unsigned char *data, int dataLen, unsigned char *hash);



int VerifyCTID_Encrypt(unsigned char *cert, int certLen, unsigned char *data, int dataLen, unsigned char *sign, int signLen);



int GM_encryptEnvelopCTID_Encrypt(char *alg,
                                  unsigned char *cert, int certLen,
                                  unsigned char *data, int dataLen,
                                  unsigned char *env, int *envLen);
@end
