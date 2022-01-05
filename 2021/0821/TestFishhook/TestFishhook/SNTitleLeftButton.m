//
//  SNTitleLeftButton.m
//  TestFishhook
//
//  Created by Augus on 2022/1/5.
//

#import "SNTitleLeftButton.h"

@implementation SNTitleLeftButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat interval = CGRectGetHeight(contentRect) * 0.125;
    // set image height equal button height's 3/4
    CGFloat imageHeight = CGRectGetHeight(contentRect) - 2 * interval;
    CGRect rect = CGRectMake(CGRectGetWidth(contentRect) - imageHeight - interval, interval, imageHeight, imageHeight);
    
    return rect;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat interval = CGRectGetHeight(contentRect) * 0.125;
    CGFloat imageHeight = CGRectGetHeight(contentRect) - 2 * interval;
    CGRect rect = CGRectMake(interval, interval, CGRectGetWidth(contentRect) - imageHeight - 2 * interval, CGRectGetHeight(contentRect) - 2 * interval);
    
    return rect;
}




@end
