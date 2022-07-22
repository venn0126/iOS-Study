//
//  TestTransformCG.m
//  TestMutableDictionary
//
//  Created by Augus on 2022/7/22.
//

#import "TestTransformCG.h"
#import <CoreText/CTFramesetter.h>


@implementation TestTransformCG

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // coregrphics坐标反转，ct的坐标原点是左下角，UI的坐标原点在左上角
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0.0,  self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    
    // 绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    // 绘制的内容属性字符串
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                 NSForegroundColorAttributeName: [UIColor redColor]
    };
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world" attributes:attributes];
    
    // 使用NSMutableAttributedString创建CTFrame
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrStr);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrStr.length), path, NULL);
    
    // 使用CTFrame在CGContextRef上下文上绘制
    CTFrameDraw(frame, context);
    
    UIGraphicsEndImageContext();

}

@end
