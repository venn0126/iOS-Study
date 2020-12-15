//
//  FSVoiceButton.m
//  fosFloatView
//
//  Created by Augus on 2020/11/10.
//

#import "FSVoiceButton.h"

@implementation FSVoiceButton

+ (instancetype)buttonWithBackImageNor:(NSString *)backImageNor backImageSelected:(NSString *)backImageSelected imageNor:(NSString *)imageNor imageSelected:(NSString *)imageSelected frame:(CGRect)frame isMicPhone:(BOOL)isMicPhone{
    
    UIImage *normalImage = [UIImage imageNamed:backImageNor]; //aio_voice_button_press
    UIImage *selectedImage = [UIImage imageNamed:backImageSelected];
    FSVoiceButton *btn = [FSVoiceButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.fos_size = normalImage.size;
    if (isMicPhone) {
        [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
        [btn setBackgroundImage:selectedImage forState:UIControlStateSelected];
    }
    btn.norImage = normalImage;
    btn.selectedImage = selectedImage;
    [btn setImage:[UIImage imageNamed:imageNor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageSelected] forState:UIControlStateSelected];
    btn.imageView.backgroundColor = [UIColor clearColor];
    if (!isMicPhone) {
        btn.backgroudLayer.contents = (__bridge id _Nullable)(normalImage.CGImage);
    }
    
    return btn;
}


- (CALayer *)backgroudLayer {
    if (_backgroudLayer == nil) {
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = self.bounds;
        [self.layer insertSublayer:layer atIndex:0];
        _backgroudLayer = layer;
    }
    return _backgroudLayer;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    // 取消CALayer的隐式动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    UIImage *image = selected ? self.selectedImage : self.norImage;
    self.backgroudLayer.contents = (__bridge id _Nullable)(image.CGImage);
    [CATransaction commit];
    
}




- (BOOL)isHighlighted {
    return NO;
}

@end
