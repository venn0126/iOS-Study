//
//  NSFileHandle+Extension.h
//  GTiTools
//
//  Created by Augus on 2022/12/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileHandle (Extension)

- (uint32_t)gt_readUint32;
- (uint32_t)gt_staticReadUint32;

- (void)gt_readData:(void *)data length:(NSUInteger)length;
- (void)gt_staticReadData:(void *)data length:(NSUInteger)length;

- (void)gt_appendOffset:(unsigned long long)offset;

@end

NS_ASSUME_NONNULL_END
