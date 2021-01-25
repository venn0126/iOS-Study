//
//  FSEasing.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/20.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSEasing.h"

// t = currentTime  当前时长   t的范围=[0,d]
// b = beginning
// c = change
// d = duration  总时长

//y = f(x)    x=t/d  y=[b,b+c]

float easeOutQuit(float t, float b, float c, float d)
{
    float x = (t/d - 1.0);
    return c * (x * x * x * x * x + 1.0) + b;
}

float easeInQuit(float t, float b, float c, float d)
{
    float x = t/d;
    return c * (x * x * x * x * x) + b;
}

float easeOutBack(float t, float b, float c, float d)
{
    float s = 2.70158;
    float t2 = t/d - 1.0;
    return (c * (t2*t2*((s+1.0)*t2+s) + 1.0)) + b;
}

float easeOutBounce(float t, float b, float c, float d)
{
    float x = t/d;
    if (x < 1 / 2.75) {
        return c * 7.5625 * x * x + b;
        
    }else if (x < 2 / 2.75) {
        float t = x - 1.5/2.75;
        return c * (7.5625 * t * t + 0.75) + b;
        
    }else if (x < 2.5 / 2.75) {
        float t = x - 2.25/2.75;
        return c * (7.5625 * t * t + 0.9375) + b;
        
    }else{
        float t = x - 2.625/2.75;
        return c * (7.5625 * t * t + 0.984375) + b;
    }
}

float clip(float st, float ed, float val)
{
    if (val<st) {
        return st;
    }
    if (val>ed) {
        return ed;
    }
    return val;
}

