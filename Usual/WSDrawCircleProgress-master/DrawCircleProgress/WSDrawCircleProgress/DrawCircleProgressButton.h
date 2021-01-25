//
//  DrawCircleProgressButton.h
//  DrawCircleProgress
//
//  Created by shlity on 16/7/13.
//  Copyright © 2016年 Moresing Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FSDetectState){
    
    FSDetectStateProcess = 0, // 正常检测中
    FSDetectStateProcessSuccess, // 单个动作成功
    FSDetectStateSuccess, // 流程结束
    
};


typedef void(^DrawCircleProgressBlock)(void);

@interface DrawCircleProgressButton : UIButton

//set track color
@property (nonatomic,strong)UIColor    *trackColor;

//set progress color
@property (nonatomic,strong)UIColor    *progressColor;

//set track background color
@property (nonatomic,strong)UIColor    *fillColor;

//set progress line width
@property (nonatomic,assign)CGFloat    lineWidth;

//set progress duration
@property (nonatomic,assign)CGFloat    animationDuration;


// 动作检测状态
@property (nonatomic, assign)  FSDetectState  detectState;

// 实时计数的返回接口
@property (nonatomic, assign)  NSInteger countNumber;


/**
 *  set complete callback
 *
 *  @param block     block
 *  @param duration  time
 */
- (void)startAnimationDuration:(CGFloat)duration withBlock:(DrawCircleProgressBlock )block;

- (void)fos_beginAnimation;

- (void)fos_stopAnimation;

@end
