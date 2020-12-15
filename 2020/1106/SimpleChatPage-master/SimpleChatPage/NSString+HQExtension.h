//
//  NSString+HQExtension.h
//  QQPage
//
//  Created by 李海群 on 2017/7/18.
//  Copyright © 2017年 李海群. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (HQExtension)


/**
 返回文本高度

 @param font 字体及大小
 @param maxSize 最大宽度
 @return cgsize
 */
-(CGSize) sizeWithFont:(UIFont *) font maxSize:(CGSize) maxSize;

@end
