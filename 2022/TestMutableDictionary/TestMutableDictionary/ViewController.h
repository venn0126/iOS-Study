//
//  ViewController.h
//  TestMutableDictionary
//
//  Created by Augus on 2022/5/30.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/// 合成后的图片
/// @param mainImage 第一张图片位画布
/// @param viewFrame 第一张图片所在View的frame（获取压缩比用
/// @param imgArray 子图片数组
/// @param frameArray 子图片坐标数组
+ (UIImage *)composeImageOnMainImage:(UIImage *)mainImage
                  mainImageViewFrame:(CGRect)viewFrame
                       subImageArray:(NSArray *)imgArray
                  subImageFrameArray:(NSArray *)frameArray;


@end

