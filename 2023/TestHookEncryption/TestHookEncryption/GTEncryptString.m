//
//  GTEncryptString.m
//  TestHookEncryption
//
//  Created by Augus on 2023/8/20.
//

#import "GTEncryptString.h"

const char *gt_CString(const GTEncryptStringData *data)
{
    if (data->decoded == 1) return data->value;
    for (int i = 0; i < data->length; i++) {
        data->value[i] ^= data->factor;
    }
    ((GTEncryptStringData *)data)->decoded = 1;
    return data->value;
}

NSString *gt_OCString(const GTEncryptStringData *data)
{
    return [NSString stringWithUTF8String:gt_CString(data)];
}


@implementation GTEncryptString




@end
