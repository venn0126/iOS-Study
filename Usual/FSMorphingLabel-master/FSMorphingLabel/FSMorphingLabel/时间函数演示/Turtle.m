//
//  Turtle.m
//  LOGO
//
//  Created by 翁志方 on 15/3/8.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "Turtle.h"

@implementation Turtle

@synthesize shapePath;

+ (Turtle *)shareInstance
{
    static Turtle *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[Turtle alloc] init];
    });
    return obj;
}

- (instancetype)init
{
    self = [super init];
    
    [self reset];
    
    return self;
}

- (void)reset
{
    // 海龟角度
    _curAngle = 90;
    
    // 方向向量初始化
    angleVec.x = 0;
    angleVec.y = 1;
    
    // 抬笔设置
    flagPenDown = YES;
    
    // 路径初始化
    if (shapePath) {
        CGPathRelease(shapePath);
    }
    shapePath = CGPathCreateMutable();
    CGPathMoveToPoint(shapePath, NULL, self.curPos.x, self.curPos.y);
    
}

// 通过视图来初始化， curpos
- (void)initWithView:(UIView *) view{
    
    // 初始化海龟位置
    width = view.bounds.size.width/2;
    height = view.bounds.size.height/2;
    self.curPos = CGPointMake(view.bounds.size.width/2 , view.bounds.size.height/2);
    
    [self reset];
}
- (void)penup     // 抬笔
{
    flagPenDown = NO;
}
- (void)pendown
{
    flagPenDown = YES;
}

- (void)moveToPoint:(CGPoint) pos
{
    self.curPos = pos;
    CGPathMoveToPoint(shapePath, NULL, pos.x, pos.y);
}

- (void)lineToPoint:(CGPoint) pos
{
    if (flagPenDown) {
        CGPathAddLineToPoint(shapePath, NULL, pos.x, pos.y);
    }else{
        CGPathMoveToPoint(shapePath, NULL, pos.x, pos.y);
    }
    self.curPos = pos;
}

- (void)fd:(CGFloat) len
{
    // 根据当前位置和角度，计算出终点，然后画线
    double x;
    double y;
    
    x = self.curPos.x + len*angleVec.x;
    y = self.curPos.y - len*angleVec.y;
    
    // 画线
    if (flagPenDown) {
        CGPathAddLineToPoint(shapePath, NULL, x, y);
    }else{
        CGPathMoveToPoint(shapePath, NULL, x, y);
    }
    
    self.curPos = CGPointMake(x, y);
}

- (void)bk:(CGFloat) len
{
    // 根据当前位置和角度，计算出终点，然后画线
    double x;
    double y;
    
    x = self.curPos.x - len*angleVec.x;
    y = self.curPos.y + len*angleVec.y;     // 坐标系变换 所以用加号
    
    // 画线
    if (flagPenDown) {
        CGPathMoveToPoint(shapePath, NULL, self.curPos.x, self.curPos.y);
        CGPathAddLineToPoint(shapePath, NULL, x, y);
    }else{
        CGPathMoveToPoint(shapePath, NULL, x, y);
    }
    
    self.curPos = CGPointMake(x, y);
}
- (void)ufd:(CGFloat) len
{
    [self penup];
    [self fd:len];
    [self pendown];
}
- (void)ubk:(CGFloat) len
{
    [self penup];
    [self bk:len];
    [self pendown];
}

- (void)rt:(CGFloat) angle
{
    // 重新计算方向向量
    _curAngle -= angle;
    
    if (_curAngle < 0) {
        _curAngle += 360;
    }
    
    double angRadix = _curAngle* M_PI/180.0;
    angleVec.x = cos(angRadix);
    angleVec.y = sin(angRadix);
 
}
- (void)lt:(CGFloat) angle;
{
    _curAngle += angle;
    
    if (_curAngle >= 360) {
        _curAngle -= 360;
    }
    
    double angRadix = _curAngle * M_PI/180.0;
    angleVec.x = cos(angRadix);
    angleVec.y = sin(angRadix);
}

- (void)savePosState      // 保存当前位置信息，（包括海龟角度）
{
    backUpPos = _curPos;
    backUpAngle = _curAngle;
}
- (void)restorePosState   // 恢复到最近的一次位置保存信息
{
    [self moveToPoint:backUpPos];
    self.curAngle = backUpAngle;
}


- (void)beginPath
{
    posStack[top++] = self.curPos;
}
- (void)endPath
{
    [self lineToPoint:posStack[--top]];
}

- (void)solidPolygon:(CGFloat) len edgeNum:(int) num angle:(CGFloat) angle
{
    if (shapePath) {
        CGPathRelease(shapePath);
    }
    shapePath = CGPathCreateMutable();
    CGPathMoveToPoint(shapePath, NULL, self.curPos.x, self.curPos.y);
    
    [self polygon:len edgeNum:num angle:angle];
    [self endPath];
}
- (void)polygon:(CGFloat) len edgeNum:(int) num angle:(CGFloat) angle
{
    for (int i=0; i<num; ++i)
    {
        [self fd:len];
        [self rt:angle];
    }
}
- (void)regularPolygon:(CGFloat) len edgeNum:(int) num
{
    CGFloat angle = 360.0 / num;
    for (int i=0; i<num; ++i)
    {
        [self fd:len];
        [self rt:angle];
    }
}

- (void)circleRadius:(CGFloat) radius
{
    // 通过每次旋转1°
    CGFloat len = radius * M_PI / 180.0;
    for (int i=0; i<360; ++i)
    {
        [self fd:len];
        [self rt:1];
    }
}

- (void)circleArcWithRadius:(CGFloat)radius angle:(CGFloat) angle
{
    // 根据角度的精度进行优化
    // 确定精度
    const double epi = 0.0000001;
    
    CGFloat tmp = angle;
    CGFloat accuracy = 1;
    while (epi < fabs(tmp - floor(tmp))  ) {
        accuracy /= 10.0;
        tmp *= 10;
    }
    
    CGFloat len = radius*M_PI/180.0*accuracy;
    for (int i=0; i< angle/accuracy; ++i) {
        [self fd:len];
        [self rt:accuracy];
    }
}
- (void)leftCircleArcWithRadius:(CGFloat)radius angle:(CGFloat) angle // 向左画弧
{
    // 根据角度的精度进行优化
    // 确定精度
    const double epi = 0.0000001;
    
    CGFloat tmp = angle;
    CGFloat accuracy = 1;
    while (epi < fabs(tmp - floor(tmp))  ) {
        accuracy /= 10.0;
        tmp *= 10;
    }
    
    CGFloat len = radius*M_PI/180.0*accuracy;
    for (int i=0; i< angle/accuracy; ++i) {
        [self fd:len];
        [self lt:accuracy];
    }
}

// 单个控制点的二次贝塞尔曲线
- (void)addQuadCurveTo:(CGPoint) endPoint controlPoint:(CGPoint) controlPoint
{
    // 划分出100条线段来绘制bezier曲线
    double curX = self.curPos.x;
    double curY = self.curPos.y;
    
    double controlX = controlPoint.x;
    double controlY = controlPoint.y;
    
    double endX = endPoint.x;
    double endY = endPoint.y;
    
    double a = 0;
    double b = 0;
    
    for (int i=0; i<100; ++i) {
        a = i / 100.0;
        b = 1 - a;
        CGPoint pos;
        pos.x = curX*b*b + 2*controlX*a*b + endX*a*a;
        pos.y = curY*b*b + 2*controlY*a*b + endY*a*a;
        
        [self lineToPoint:pos];
    }
}
// 两个个控制点的三次贝塞尔曲线
- (void) addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2
{
    // 划分出100条线段来绘制bezier曲线
    double curX = self.curPos.x;
    double curY = self.curPos.y;
    
    double controlX1 = controlPoint1.x;
    double controlY1 = controlPoint1.y;
    
    double controlX2 = controlPoint2.x;
    double controlY2 = controlPoint2.y;
    
    double endX = endPoint.x;
    double endY = endPoint.y;
    
    double a = 0;
    double b = 0;
    
    for (int i=0; i<100; ++i) {
        a = i / 100.0;
        b = 1 - a;
        CGPoint pos;
        pos.x = curX*b*b*b + 3*controlX1*a*b*b + 3*controlX2*a*a*b + endX*a*a*a;
        pos.y = curY*b*b*b + 3*controlY1*a*b*b + 3*controlY2*a*a*b + endY*a*a*a;
        
        [self lineToPoint:pos];
    }
}


#pragma mark - getter and setter
- (void)setCurAngle:(CGFloat)curAngle
{
    while (curAngle<0) {
        curAngle += 360;
    }
    while (curAngle>360) {
        curAngle -= 360;
    }
    _curAngle = curAngle;
    
    double angRadix = curAngle * M_PI/180.0;
    angleVec.x = cos(angRadix);
    angleVec.y = sin(angRadix);
}




@end
