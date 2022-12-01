//
//  NSFileHandle+Extension.m
//  GTiTools
//
//  Created by Augus on 2022/12/1.
//

#import "NSFileHandle+Extension.h"

@implementation NSFileHandle (Extension)

- (uint32_t)gt_readUint32
{
    size_t length = sizeof(uint32_t);
    uint32_t value;
    [[self readDataOfLength:length] getBytes:&value length:length];
    return value;
}

- (uint32_t)gt_staticReadUint32
{
    unsigned long long offset = self.offsetInFile;
    uint32_t value = [self gt_readUint32];
    [self seekToFileOffset:offset];
    return value;
}

- (void)gt_readData:(void *)data length:(NSUInteger)length
{
    [[self readDataOfLength:length] getBytes:data length:length];
}

- (void)gt_staticReadData:(void *)data length:(NSUInteger)length
{
    unsigned long long offset = self.offsetInFile;
    [self gt_readData:data length:length];
    [self seekToFileOffset:offset];
}

- (void)gt_appendOffset:(unsigned long long)offset
{
    [self seekToFileOffset:self.offsetInFile + offset];
}

@end
