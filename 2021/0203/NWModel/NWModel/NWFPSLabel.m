//
//  NWFPSLabel.m
//  NWModel
//
//  Created by Augus on 2021/2/26.
//

#import "NWFPSLabel.h"
#import "NWProxy.h"

#define nDefaultSize CGSizeMake(50, 20)

@implementation NWFPSLabel{
    
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    UIFont *_font;
    UIFont *_subFont;
}

- (instancetype)initWithFrame:(CGRect)frame {
    // 判断非法
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size = nDefaultSize;
    }
    self = [super initWithFrame:frame];
    self.layer.cornerRadius = 5.0;
    self.clipsToBounds = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.7000];
    
    _font = [UIFont fontWithName:@"Menlo" size:14];
    if (_font) {
        _subFont = [UIFont fontWithName:@"Menlo" size:4];
    } else {
        _font = [UIFont fontWithName:@"Courier" size:14];
        _subFont = [UIFont fontWithName:@"Courier" size:4];
    }
    
    _link = [CADisplayLink displayLinkWithTarget:[NWProxy proxyWithTarget:self] selector:@selector(nwTick:)];
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return nDefaultSize;
}

- (void)nwTick:(CADisplayLink *)link {
    
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    NSString *text1 = [NSString stringWithFormat:@"%dFPS",(int)round(fps)];
    NSLog(@"text1---%@",text1);
    
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%dFPS",(int)round(fps)]];
    [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length - 3)];
    [text addAttribute:NSForegroundColorAttributeName value:UIColor.whiteColor range:NSMakeRange(text.length - 3, 3)];
    [text addAttribute:NSFontAttributeName value:_font range:NSMakeRange(0, text.length)];
    [text addAttribute:NSFontAttributeName value:_subFont range:NSMakeRange(text.length - 4, 1)];
    self.attributedText = text;
    
}

- (void)dealloc {
    
    [_link invalidate];
    _link = nil;
    NSLog(@"link release");
}

- (CGSize)intrinsicContentSize {
    NSLog(@"nwfpslabel---%@",NSStringFromSelector(_cmd));
    //
//    self.text
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:self.text];
//    attStr boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> context:<#(nullable NSStringDrawingContext *)#>
//    attStr drawWithRect:<#(CGRect)#> options:<#(NSStringDrawingOptions)#> context:<#(nullable NSStringDrawingContext *)#>
    
    //此处你可以返回一个自己设定的size值，当然也可以返回contentSize


    return CGSizeMake(10, 20);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
