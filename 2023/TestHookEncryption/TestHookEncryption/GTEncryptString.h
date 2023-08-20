//
//  GTEncryptString.h
//  TestHookEncryption
//
//  Created by Augus on 2023/8/20.
//

#import <Foundation/Foundation.h>

#ifndef MJEncryptString_h
#define MJEncryptString_h

typedef struct {
    char factor;
    char *value;
    int length;
    char decoded;
} GTEncryptStringData;

const char *gt_CString(const GTEncryptStringData *data);

#ifdef __OBJC__
#import <Foundation/Foundation.h>
NSString *gt_OCString(const GTEncryptStringData *data);
#endif

#endif

@interface GTEncryptString : NSObject

@end
