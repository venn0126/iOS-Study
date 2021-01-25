//
//  Turtle.h
//  LOGO
//
//  Created by 翁志方 on 15/3/8.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>


/*
 绘制logo语言中的图形
 预定义宏来实现， DRAW 来实现这个的初始化（需要获取当前view和对应的context）
 */

#define RADIAN(x) ((x)*M_PI/180.0)

#define TURTLE [Turtle shareInstance]

#define DRAW [TURTLE reset];
#define DRAWINVIEW(view) [TURTLE initWithView:view];                // 海龟在视图中间


#define MOVETO(pos) [TURTLE moveToPoint:(pos)];
#define MOVETOXY(posx,posy) [TURTLE moveToPoint:CGPointMake((posx),(posy))];
#define LINETO(pos) [TURTLE lineToPoint:(pos)];
#define LINETOXY(posx,posy) [TURTLE lineToPoint:CGPointMake((posx),(posy))];

#define FD(len) [TURTLE fd:len];
#define BK(len) [TURTLE bk:len];

#define UFD(len) [TURTLE ufd:len];
#define UBK(len) [TURTLE ubk:len];

#define RT(angle) [TURTLE rt:angle];
#define LT(angle) [TURTLE lt:angle];

#define RT90 RT(90);
#define LT90 LT(90);

#define TURNTO(angle) [TURTLE setCurAngle:angle];


#define ARC(radius,ang) [TURTLE circleArcWithRadius:radius angle:ang];
#define LARC(radius,ang) [TURTLE leftCircleArcWithRadius:radius angle:ang];

#define PU [TURTLE penup];
#define PD [TURTLE pendown];

#define SAVE [TURTLE savePosState];
#define RESTORE [TURTLE restorePosState];

#define CURRENTPOS [TURTLE curPos];

#define BEGINPATH [TURTLE beginPath];
#define ENDPATH [TURTLE endPath];

#define QUADCURVETO(endPoint,controlPoint) [TURTLE addQuadCurveTo:(endPoint) controlPoint:(controlPoint)];
#define CURVETO(endPoint,controlPoint1,controlPoint2) [TURTLE addCurveToPoint:(endPoint) controlPoint1:(controlPoint1) controlPoint2:(controlPoint2)];


@interface Turtle : NSObject
{
    // 方向向量
    CGPoint angleVec;
    
    // 对应视图的宽度和高度
    CGFloat height;
    CGFloat width;
    
    // 抬笔和落笔的状态
    BOOL flagPenDown;
    
    CGMutablePathRef shapePath;     // 需要保证区间的闭合
    
    // 用于备份的位置信息
    CGPoint backUpPos;
    CGFloat backUpAngle;
    
    CGPoint posStack[100];          // 最多存储100个保存的点
    NSInteger top;                  // 栈顶指针
}
+ (Turtle *) shareInstance;


@property (nonatomic, assign) CGMutablePathRef shapePath;       // 用于做动画

@property (nonatomic) CGContextRef curContextRef;  // 当前context       // 可以指定

@property (nonatomic) CGPoint curPos;       // 位置

@property (nonatomic) CGFloat curAngle;     // 角度，默认90°


- (void) initWithView:(UIView *) view;

- (void) reset;

- (void) penup;     // 抬笔

- (void) pendown;   // 落笔

- (void) moveToPoint:(CGPoint) pos;

- (void) lineToPoint:(CGPoint) pos;

- (void) fd:(CGFloat) len;

- (void) bk:(CGFloat) len;

- (void) ufd:(CGFloat) len;

- (void) ubk:(CGFloat) len;

- (void) rt:(CGFloat) angle;

- (void) lt:(CGFloat) angle;

- (void) savePosState;      // 保存当前位置信息，（包括海龟角度）
- (void) restorePosState;   // 恢复到最近的一次位置保存信息

- (void) beginPath;     // 开始绘制路径

- (void) endPath;       // 结束绘制路径

- (void) solidPolygon:(CGFloat) len edgeNum:(int) num angle:(CGFloat) angle; // 多角形
- (void) polygon:(CGFloat) len edgeNum:(int) num angle:(CGFloat) angle; // 多角形
- (void) regularPolygon:(CGFloat) len edgeNum:(int) num;    // 在原地画一个正多边形

- (void) circleRadius:(CGFloat) radius;

- (void) circleArcWithRadius:(CGFloat)radius angle:(CGFloat) angle; // 向右画弧
- (void) leftCircleArcWithRadius:(CGFloat)radius angle:(CGFloat) angle; // 向左画弧

- (void) addQuadCurveTo:(CGPoint) endPoint controlPoint:(CGPoint) controlPoint;

- (void) addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2;

@end
