//
//  NSData+ImageFormat.m
//  LBMScanQR
//
//  Created by Augus on 2023/9/23.
//

#import "NSData+ImageFormat.h"

@implementation NSData (ImageFormat)

+ (LBMImageFormat)jl_imageFormatWithImageData:(nullable NSData *)data {
    if (!data) {
        return LBMImageFormatUndefined;
    }
    
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return LBMImageFormatJPEG;
            
        case 0x89:
            return LBMImageFormatPNG;
            
        case 0x47:
            return LBMImageFormatGIF;
            
        case 0x40:
        case 0x4D:
            return LBMImageFormatTIFF;
            
        case 0x52:
            if (data.length < 12) {
                return LBMImageFormatUndefined;
            }
            
            NSString *str = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([str hasPrefix:@"RIFF"] && [str hasSuffix:@"WEBP"]) {
                return LBMImageFormatWebp;
            }
    }
    return LBMImageFormatUndefined;
}

@end
