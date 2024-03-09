//
//  UIImage+Extension.h
//  TestHookEncryption
//
//  Created by Augus on 2024/3/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CompletedBlock)(UIImage *newImage);


@interface UIImage (Extension)

#pragma mark -- 类方法
/// 生成指定颜色的一个`点`的图像
///
/// @param color 颜色
///
/// @return 1 * 1 图像
+(UIImage *)gt_singleDotImageWithColor:(UIColor *)color;


/// 生成指定颜色和尺寸的的图像
/// @param color 颜色
/// @param size 指定尺寸
/// @param isRound 是否切圆
+ (UIImage *)gt_imageWithColor:(UIColor *)color size:(CGSize)size isRound:(BOOL)isRound;

///裁剪圆形图片的工具方法
+(UIImage *)gt_imageClipWithImageName:(NSString *)imageName andBoardMargin:(CGFloat)BoardMargin andBackgroundColor:(UIColor *)color;

///截全屏
+(UIImage *)gt_imageClipScreenWithView:(UIView *)clipView;

/**
 *  返回一张添加水印的图片并保存到document中
 */
+(instancetype)gt_waterImageWithBackground:(NSString *)bg logo:(NSString *)logo pathComponent:(NSString *)pathComponent;

///拉伸图片
+(UIImage *)gt_imageStrentchWithImageName:(NSString *)imageName;

#pragma mark -- 对象方法
///图片异步切圆
-(void)gt_clipRoundImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completedBlock:(CompletedBlock)completedBlock;


///从一个大的图片中 区域截取图片的方法
-(UIImage *)gt_clipImageWithBigImage:(UIImage *)bigImage andIndex:(NSInteger)index andSmallImageCount:(NSInteger)count;

///截取部分图像
-(UIImage *)gt_getSubImage:(CGRect)rect;


#pragma mark -- 方向校正方法
///修正方向(人脸识别中使用)
+(UIImage*)gt_fixOrientation:(UIImage*)aImage;


#pragma mark --压缩图片尺寸和质量
/// 等比例压缩图片 同时压缩图片质量
/// @param image 原图片
/// @param width 指定图片宽度
+ (UIImage *)gt_imageWithImageSimple:(UIImage *)image scaledToWidth:(CGFloat)width;

/// 压缩图片到指定尺寸 同时压缩图片质量
/// @param image 原图片
/// @param newSize 指定尺寸
+ (UIImage*)gt_imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;


@end

NS_ASSUME_NONNULL_END
