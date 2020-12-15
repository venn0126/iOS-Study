//
//  CameraDrawView.m
//  IDCardDemo
//
//  Created by linmac on 16-10-15.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "CameraDrawView.h"
#import <CoreText/CoreText.h>
#import "YMIDCardEngine.h"

@implementation CameraDrawView{
    
    CGPoint ldown;
    CGPoint rdown;
    CGPoint lup;
    CGPoint rup;
    CGRect pointRect;
    CGRect textRect;
    UILabel *label;
    UIImageView   *scanLine;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
//    appDlg = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [appDlg.ymIDCardEngine setBcrResultCallbackDelegate:self];
    if (self) {
        CGRect rect_screen = [[UIScreen mainScreen]bounds];
        CGSize size_screen = rect_screen.size;
        CGFloat width = size_screen.width;
        CGFloat height = size_screen.height;
        CGRect sRect;
        if (width>height) {
            sRect = CGRectMake(100, 45, (height-2*45)*1.55, (height-2*45));
            self.engIdCardRect = CGRectMake(sRect.origin.x, sRect.origin.y, sRect.size.width, sRect.size.height);
        }
        else
        {
            sRect = CGRectMake(10, 100, width-20, (width-20)/1.55);
            if (height == 480)
            {
                sRect = CGRectMake(CGRectGetMinX(sRect), CGRectGetMinY(sRect)-44, CGRectGetWidth(sRect), CGRectGetHeight(sRect));
            }else
            {
                sRect = CGRectMake(CGRectGetMinX(sRect), CGRectGetMinY(sRect), CGRectGetWidth(sRect), CGRectGetHeight(sRect));
            }
            self.engIdCardRect = CGRectMake(sRect.origin.y, sRect.origin.x, sRect.size.height, sRect.size.width);
        }
        
//        ldown = CGPointMake(CGRectGetMinX(sRect), CGRectGetMinY(sRect));
//        lup  = CGPointMake(CGRectGetMaxX(sRect), CGRectGetMinY(sRect));
//        rdown = CGPointMake(CGRectGetMinX(sRect), CGRectGetMaxY(sRect));
//        rup = CGPointMake(CGRectGetMaxX(sRect), CGRectGetMaxY(sRect));
//        self.smallrect = sRect;
//        self.ymzSmallRect = CGRectMake(ldown.x+80, ldown.y-25, rup.x-ldown.x-160,rdown.y-ldown.y+25);
        [self addMask:sRect];
        
        //银行卡提示语
        self.LabbankDetail = [[UILabel alloc] init];
        self.LabbankDetail.text = @"请将银行卡号对准横线";
        self.LabbankDetail.textColor = [UIColor colorWithRed:0.31 green:0.68 blue:0.88 alpha:0.9];
        
        //清空背景颜色
        self.LabbankDetail.backgroundColor = [UIColor clearColor];
        //设置字体颜色为白色
        self.LabbankDetail.textAlignment = NSTextAlignmentCenter;
        //自动折行设置
        self.LabbankDetail.lineBreakMode = UILineBreakModeCharacterWrap;
        self.LabbankDetail.numberOfLines = 0;
        self.LabbankDetail.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.LabbankDetail];
//        self.LabbankDetail.frame = CGRectMake(sRect.origin.x - sRect.size.width / 2 + sRect.size.height / 3 - 15, sRect.origin.y +sRect.size.height/2  - 20, sRect.size.width, 40);
        self.LabbankDetail.frame = CGRectMake(sRect.origin.x - 5, sRect.origin.y +sRect.size.height/2  - 20, sRect.size.width, 40);

//        self.LabbankDetail.transform = CGAffineTransformMakeRotation(M_PI_2);
        
        //其他证件提示语
//        self.LabIdDetail = [[UILabel alloc] init];
//        self.LabIdDetail.text = @"请将证件正面置于此区域";
//        self.LabIdDetail.textColor = [UIColor colorWithRed:0.31 green:0.68 blue:0.88 alpha:0.9];
//        
//        //清空背景颜色
//        self.LabIdDetail.backgroundColor = [UIColor clearColor];
//        //设置字体颜色为白色
//        self.LabIdDetail.textAlignment = NSTextAlignmentCenter;
//        //自动折行设置
//        self.LabIdDetail.lineBreakMode = UILineBreakModeCharacterWrap;
//        self.LabIdDetail.numberOfLines = 0;
//        self.LabIdDetail.font = [UIFont systemFontOfSize:18];
//        [self addSubview:self.LabIdDetail];
//        self.LabIdDetail.frame = CGRectMake(sRect.origin.x - sRect.size.width / 2 + sRect.size.height / 3 - 15, sRect.origin.y +sRect.size.height/2  - 20, sRect.size.width, 40);
//        self.LabIdDetail.transform = CGAffineTransformMakeRotation(M_PI_2);
        
        //银行卡划线
        self.ImageVBankLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scanLine.jpg"]];
//        self.ImageVBankLine.frame = CGRectMake(sRect.origin.x - sRect.size.height / 14 * 5 +  sRect.size.height / 21 * 5   , sRect.origin.y+sRect.size.height/2 , sRect.size.height / 7 * 5, 2);
        self.ImageVBankLine.frame = CGRectMake(sRect.origin.x + 25, sRect.origin.y +  sRect.size.height * 3 / 5 , sRect.size.height / 4 * 5, 2);
//        self.ImageVBankLine.transform = CGAffineTransformMakeRotation(M_PI_2);
        
        [self addSubview: self.ImageVBankLine];
        
    }
    return self;
}


- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

/*
 设置四条线的显隐
 */
- (void) setTopHidden:(BOOL)topHidden
{
    if (_topHidden == topHidden) {
        return;
    }
    _topHidden = topHidden;
    [self setNeedsDisplay];
}

- (void) setLeftHidden:(BOOL)leftHidden
{
    if (_leftHidden == leftHidden) {
        return;
    }
    _leftHidden = leftHidden;
    [self setNeedsDisplay];
}

- (void) setBottomHidden:(BOOL)bottomHidden
{
    if (_bottomHidden == bottomHidden) {
        return;
    }
    _bottomHidden = bottomHidden;
    [self setNeedsDisplay];
}

- (void) setRightHidden:(BOOL)rightHidden
{
    if (_rightHidden == rightHidden) {
        return;
    }
    _rightHidden = rightHidden;
    [self setNeedsDisplay];
}

- (void)addMask:(CGRect)rangeRect{
    
    UIButton * _maskButton = [[UIButton alloc] init];
    [_maskButton setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    [_maskButton setBackgroundColor:[UIColor darkGrayColor]];
    _maskButton.alpha = 0.9;
    [self addSubview:_maskButton];
    
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
    
    // MARK: roundRectanglePath
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(rangeRect.origin.x+5,rangeRect.origin.y+5, rangeRect.size.width-10 , rangeRect.size.height-10) cornerRadius:15] bezierPathByReversingPath]];
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.path = path.CGPath;
    
    [_maskButton.layer setMask:shapeLayer];
}

@end
