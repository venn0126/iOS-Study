//
//  FSCharacterLimbo.h
//  iDraw
//
//  Created by 翁志方 on 2016/12/20.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSCharacterLimbo : NSObject

@property (nonatomic, assign) unichar ch;               // 字符

@property (nonatomic, assign) CGRect rect;              // 字符的frame

@property (nonatomic, assign) float alpha;              // 透明度

@property (nonatomic, assign) float size;               // 字符的font大小

@property (nonatomic, assign) float drawingProgress;    // 绘制的进度


@end
