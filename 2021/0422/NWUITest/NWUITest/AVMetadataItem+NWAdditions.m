//
//  AVMetadataItem+NWAdditions.m
//  NWUITest
//
//  Created by Augus on 2021/5/7.
//

#import "AVMetadataItem+NWAdditions.h"

@implementation AVMetadataItem (NWAdditions)

- (NSString *)keyString {
    
    if ([self.key isKindOfClass:[NSString class]]) {
        return (NSString *)self.key;
    } else if([self.key isKindOfClass:[NSNumber class]]){
        UInt32 keyValue = [(NSNumber *)self.key unsignedIntValue];
        size_t length = sizeof(UInt32);
        if ((keyValue >> 24) == 0) --length;
        if ((keyValue >> 16) == 0) --length;
        if ((keyValue >> 8) == 0) --length;
        if ((keyValue >> 0) == 0) --length;
        
        long address = (unsigned long)&keyValue;
        address += (sizeof(UInt32) - length);
        
        keyValue = CFSwapInt32BigToHost(keyValue);
        
        char csstring [length];
        strncpy(csstring, (char *)address, length);
        csstring[length] = '\0';
        
        if (csstring[0] == '\xA9') {
            csstring[0] = '@';
        }
        
        return [NSString stringWithCString:(char *)csstring encoding:NSUTF8StringEncoding];

        
    } else {
        return @"<<unknow>>";
    }
    
    
    
    return nil;
}

@end
