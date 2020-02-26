//
//  FOSCircleView.m
//  CircleAnimation
//
//  Created by Augus on 2019/11/14.
//  Copyright © 2019 fosafer. All rights reserved.
//

#import "FOSCircleView.h"


//static const CGFloat kButtonRadis = 30;
//static const CGFloat kCircleViewRadius = 65;

@interface FOSCircleView()

@property (nonatomic, strong) NSMutableArray *viewArray;

@property (nonatomic) CGFloat viewRadis;
@property (nonatomic) CGFloat subViewW;
@property (nonatomic) CGFloat subViewH;
@property (nonatomic) CGFloat viewH;
@property (nonatomic) CGFloat viewW;

@property (nonatomic) CGFloat subRadius;



@end


@implementation FOSCircleView


- (NSMutableArray *)viewArray {
    if (!_viewArray) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)init {
    return [super init];
}

/*
 
 1.n条线平分圆,n>=2
 2.线的size任意
 3.线的动画画隐藏
 4.整体frame任意
 
 
 */

- (instancetype)initWithFrame:(CGRect)frame views:(NSArray *)views {
    if (self = [super initWithFrame:frame]) {
        
        // 初始化变量
        self.viewH = self.frame.size.height;
        self.viewW = self.frame.size.width;
        self.viewRadis = self.frame.size.width * 0.5;
        self.subViewH = 100;
        self.subViewW = 5;
        self.subRadius = (self.viewW - 2 * self.subViewH) * 0.5;
        
        
        // 初始化并添加到视图
        self.viewArray  = [NSMutableArray arrayWithArray:views];
        for (int i = 0; i < views.count; i++) {
            [self createView:views[i] andTag:i isHidden:YES];
        }
        
        // 布局
        [self setupSubviews];
        
        
  
    }
    return self;
}



- (void)setupSubviews {
    
    CGFloat degress = 360 / self.viewArray.count * (180 / M_PI);
    for (UIView *aView in self.subviews) {
        if (aView.tag == 0) {// 1
            aView.frame = CGRectMake(self.viewRadis, 0, self.subViewW, self.subViewH);
        }
        if (aView.tag == 1) {// 2
            
            aView.frame = CGRectMake(self.viewRadis + self.subRadius + 10, self.subRadius * 0.5, self.subViewW, self.subViewH);
            aView.transform = CGAffineTransformRotate(aView.transform, -degress);
        }
        
        if (aView.tag == 2) {
            
            aView.frame = CGRectMake(self.viewRadis + self.subRadius + self.subViewH * 0.5 - 5, self.viewRadis - self.subViewH * 0.5,self.subViewW, self.subViewH);
            aView.transform = CGAffineTransformMakeRotation(M_PI_2);

        }
        
        if (aView.tag == 3) {
            
            aView.frame = CGRectMake(self.viewRadis + self.subRadius + 10, self.viewRadis + self.subRadius * 0.5,self.subViewW, self.subViewH);
            aView.transform = CGAffineTransformMakeRotation(degress);

        }
        
        if (aView.tag == 4) {
            aView.frame = CGRectMake(self.viewRadis, self.viewH - self.subViewH,self.subViewW, self.subViewH);

        }
        
        if (aView.tag == 5) {
                aView.frame = CGRectMake(self.viewRadis - self.subRadius - 15, self.viewRadis + self.subRadius * 0.5,self.subViewW, self.subViewH);
                aView.transform = CGAffineTransformMakeRotation(-degress);

            }
        
        if (aView.tag == 6) {
            aView.frame = CGRectMake(self.subRadius * 0.5 + 5, self.viewRadis - self.subViewH * 0.5,self.subViewW, self.subViewH);
            aView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        
        if (aView.tag == 7) {
                aView.frame = CGRectMake(self.viewRadis - self.subRadius - 15,self.subRadius * 0.5,self.subViewW, self.subViewH);
                aView.transform = CGAffineTransformMakeRotation(degress);
        }
    }
}

- (void)createView:(UIView *)aView andTag:(int)aTag isHidden:(BOOL)isHidden {
    
    aView.backgroundColor = [UIColor redColor];
    aView.tag = aTag;
    aView.hidden = isHidden;
    aView.layer.cornerRadius = 5.0;
    aView.center = self.center;
    aView.backgroundColor = [UIColor greenColor];
    [self addSubview:aView];
}



- (void)drawRect:(CGRect)rect {

//    UIBezierPath *cyclePath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
//    cyclePath.lineWidth = 1.0;
//    cyclePath.lineCapStyle = kCGLineCapRound;
//    cyclePath.lineJoinStyle = kCGLineCapRound;
//    [cyclePath stroke];
//
//
//    UIBezierPath *cyclePath1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.subViewH, self.subViewH, self.viewW - 2 * self.subViewH, self.viewW - 2 * self.subViewH)];
//
////    UIBezierPath
//      cyclePath1.lineWidth = 1.0;
//      cyclePath1.lineCapStyle = kCGLineCapRound;
//      cyclePath1.lineJoinStyle = kCGLineCapRound;
//      [cyclePath1 stroke];

}



- (void)setViewHighlightedIndex:(NSInteger)aTag {
    
    /*
     1 2 3 4 5 6 7 8    9
     */

    if (aTag == 9) {
        return;
    }
    for (UIView *aView in self.subviews) {
        if (aView.tag == (aTag - 1) && aView.hidden) {
            aView.hidden = NO;
        }
    }
}


- (void)resetViewState {
    for (UIView *aView in self.subviews) {
        aView.hidden = YES;
     }
}


- (BOOL)viewStateForIndex:(NSInteger)index {
    if (index == 9) {
        return YES;
    }
    UIView *aView = self.viewArray[index-1];
    return aView.hidden;
}

@end
