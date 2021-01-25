//
//  FSEasing.h
//  iDraw
//
//  Created by 翁志方 on 2016/12/20.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import <Foundation/Foundation.h>


// t = currentTime
// b = beginning
// c = change
// d = duration

// 时间函数计算

// 淡出
float easeOutQuit(float t, float b, float c, float d);

// 淡入
float easeInQuit(float t, float b, float c, float d);

//
float easeOutBack(float t, float b, float c, float d);

// 弹跳效果
float easeOutBounce(float t, float b, float c, float d);


float clip(float st, float ed, float val);
