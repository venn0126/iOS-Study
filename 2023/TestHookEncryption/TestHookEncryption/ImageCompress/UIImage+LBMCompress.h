//
//  UIImage+LBMCompress.h
//  LBMScanQR
//
//  Created by Augus on 2023/9/23.
//

#import <UIKit/UIKit.h>
#import "NSData+ImageFormat.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LBMCompress)


/**
 压缩图片,压缩 JPEG,PNG, 不含 GIF

 @param image 压缩前的图片
 @param imageType 指明图片类型
 @param size 期望压缩后的大小,单位:MB
 @return 压缩后的图片
 */
+ (UIImage *)lbm_compressWithImage:(UIImage *)image imageType:(LBMImageFormat)imageType specifySize:(CGFloat)size;

/**
 压缩图片,压缩 JPEG,PNG,GIF

 @param imageData 压缩前图片的data
 @param size 期望压缩后的大小,单位:MB
 @return 压缩后的图片
 */
+ (UIImage *)lbm_compressWithImage:(NSData *)imageData specifySize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
