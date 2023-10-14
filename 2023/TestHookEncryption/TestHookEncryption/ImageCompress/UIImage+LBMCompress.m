//
//  UIImage+LBMCompress.m
//  LBMScanQR
//
//  Created by Augus on 2023/9/23.
//

#import "UIImage+LBMCompress.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (LBMCompress)

+ (UIImage *)lbm_compressWithImage:(UIImage *)image imageType:(LBMImageFormat)imageType specifySize:(CGFloat)size {
    if (size == 0) {
        return image;
    }
    
    if (imageType == LBMImageFormatPNG) {
        NSData *data = UIImagePNGRepresentation(image);
        return [self lbm_compressWithImage:data specifySize:size];
    }
    
    if (imageType == LBMImageFormatJPEG) {
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        return [self lbm_compressWithImage:data specifySize:size];
    }
    
    return image;
}

+ (UIImage *)lbm_compressWithImage:(NSData *)imageData specifySize:(CGFloat)size {
    if (!imageData || size == 0) {
        return nil;
    }
    
    CGFloat specifySize = size * 1000 * 1000;
    
    LBMImageFormat imageFormat = [NSData jl_imageFormatWithImageData:imageData];
    if (imageFormat == LBMImageFormatPNG) {
        UIImage *image = [UIImage imageWithData:imageData];
        while (imageData.length > specifySize) {
            CGFloat targetWidth = image.size.width * 0.9;
            CGFloat targetHeight = image.size.height * 0.9;
            CGRect maxRect = CGRectMake(0, 0, targetWidth, targetHeight);
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(floorf(targetWidth), floorf(targetHeight)), NO, [UIScreen mainScreen].scale);
            [image drawInRect:maxRect];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            imageData = UIImagePNGRepresentation(image);
        }
        return image;
    }
    
    if (imageFormat == LBMImageFormatJPEG) {
        UIImage *image = [UIImage imageWithData:imageData];
        while (imageData.length > specifySize) {
            imageData = UIImageJPEGRepresentation(image, 0.9);
            image = [UIImage imageWithData:imageData scale:[UIScreen mainScreen].scale];
        }
        return image;
    }
    
    if (imageFormat == LBMImageFormatGIF) {
        CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
        size_t count = CGImageSourceGetCount(source);
        NSTimeInterval duration = count * (1 / 30.0);
        NSMutableArray<UIImage *> *images = [NSMutableArray array];
        for (size_t i = 0; i < count; i++) {
            CGImageRef cgImage = CGImageSourceCreateImageAtIndex(source, i, NULL);
            UIImage *image = [UIImage imageWithCGImage:cgImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
            [images addObject:image];
            CGImageRelease(cgImage);
        }
        CFRelease(source);
        
        while (imageData.length > size) {
            for (UIImage *image in images) {
                UIImage *img = image;
                CGFloat targetWidth = img.size.width * 0.9;
                CGFloat targetHeight = img.size.height * 0.9;
                CGRect maxRect = CGRectMake(0, 0, targetWidth, targetHeight);
                UIGraphicsBeginImageContextWithOptions(CGSizeMake(floorf(targetWidth), floorf(targetHeight)), NO, [UIScreen mainScreen].scale);
                [img drawInRect:maxRect];
                img = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                imageData = UIImagePNGRepresentation(img);
            }
        }
        return [UIImage animatedImageWithImages:images duration:duration];
    }
    
    return [UIImage imageWithData:imageData];
}


@end
