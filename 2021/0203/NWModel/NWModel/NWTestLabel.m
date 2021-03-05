//
//  NWTestLabel.m
//  NWModel
//
//  Created by Augus on 2021/3/4.
//

#import "NWTestLabel.h"

@implementation NWTestLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGSize)intrinsicContentSize {
    NSLog(@"nw test label - %@",NSStringFromSelector(_cmd));
    CGSize tmpSize =  [super intrinsicContentSize];
//    tmpSize.width += 50;
//    tmpSize.height += 50;
    
    NSLog(@"intrinsicContentSize--%@",NSStringFromCGSize(tmpSize));
    return tmpSize;
}

- (CGFloat)preferredMaxLayoutWidth {
    NSLog(@"nw lable - %@",NSStringFromSelector(_cmd));
    return [super preferredMaxLayoutWidth];
}

@end
