//
//  responderView.m
//  TesLock
//
//  Created by Augus on 2021/1/29.
//

#import "responderView.h"


@interface responderView (){
    
    UIView *_firstView;
    UIView *_secondView;
}

@end

//UIScreen

@implementation responderView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backgroundColor = UIColor.lightGrayColor;
    
    [self setupViews];
    
    
    return self;
}

- (void)setupViews {
    
    _firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _firstView.center = self.center;
    _firstView.backgroundColor = UIColor.greenColor;
    [self addSubview:_firstView];
    
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _secondView.backgroundColor = UIColor.redColor;
    _secondView.center = self.center;
    [self addSubview:_secondView];
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *touchView = self;
    
    CGPoint p1 = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    // 自定义识别范围
    BOOL distance = [self fromTouchPoint:point toPoint:p1];
    
    if (distance && self.userInteractionEnabled && self.alpha > 0.01 && !self.hidden) {
        NSLog(@"<100");
        for (UIView *subview in self.subviews) {
            CGPoint subPoint = [subview convertPoint:point fromView:self];
            // subpoint to circle
            
            UIView *subTouchView = [subview hitTest:subPoint withEvent:event];
            if (subTouchView) {
                touchView = subTouchView;
                break;
            }
        }
    }else {
        touchView = nil;
    }
    
    return touchView;
}


- (BOOL)fromTouchPoint:(CGPoint)touchPoint toPoint:(CGPoint)toPoint {
    
    CGFloat x1 = touchPoint.x;
    CGFloat y1 = touchPoint.y;
    
    CGFloat x2 = toPoint.x;
    CGFloat y2 = toPoint.y;
    
    CGFloat distance = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
   
//    return distance <= 100 ? YES : NO;
    
    if (distance <= 100.0) {
        NSLog(@"yes distance---%.2f",distance);
        return YES;
    }else {
        NSLog(@"no distance---%.2f",distance);
        return NO;
    }
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    NSLog(@"ssss");
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
