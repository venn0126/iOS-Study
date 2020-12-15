//
//  UIImage+HQExtension.h
//  QQPage
//
//  Created by 李海群 on 2017/7/18.
//  Copyright © 2017年 李海群. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HQExtension)


/**
 传入图片返回可拉伸图片
 */
+ (UIImage *) resizableImageWith:(NSString *) img;

@end
