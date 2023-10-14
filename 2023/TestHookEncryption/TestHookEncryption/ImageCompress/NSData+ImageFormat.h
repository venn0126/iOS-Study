//
//  NSData+ImageFormat.h
//  LBMScanQR
//
//  Created by Augus on 2023/9/23.
//

#import <Foundation/Foundation.h>

/**
 图片类型
 */
typedef NS_ENUM(NSUInteger, LBMImageFormat) {
    LBMImageFormatUndefined = -1,
    LBMImageFormatJPEG = 0,
    LBMImageFormatPNG,
    LBMImageFormatGIF,
    LBMImageFormatTIFF,
    LBMImageFormatWebp,
};


NS_ASSUME_NONNULL_BEGIN

@interface NSData (ImageFormat)

/**
 根据图片的data数据,获取图片类型
 
 @param data 图片的data数据
 @return 图片类型
 */
+ (LBMImageFormat)jl_imageFormatWithImageData:(nullable NSData *)data;

@end

NS_ASSUME_NONNULL_END
