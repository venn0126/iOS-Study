//
//  FSMorphingLabel+Pixelate.m
//  iDraw
//
//  Created by 翁志方 on 2017/1/9.
//  Copyright © 2017年 翁志方. All rights reserved.
//

#import "FSMorphingLabel+Pixelate.h"

@implementation FSMorphingLabel (Pixelate)

- (void)pixelateLoad
{
    // disappear
    {
        FSMorphingEffectClosure closure = ^(unichar ch, NSInteger index, float progress){
            
            FSCharacterLimbo *limbo = [FSCharacterLimbo new];
            limbo.ch = ch;
            limbo.rect = previousRects[index];
            limbo.alpha = 1.0-progress;
            limbo.size = self.font.pointSize;
            limbo.drawingProgress = progress;           // progress 【0，1】 清晰->模糊
            return limbo;
        };
        
        NSString *key = keyForEffectPhase(kMorphingEffectPixelate, kMorphingPhasesDisappear);
        [self.effectDictionary setObject:closure forKey:key];
    }
    
    // appear
    {
        FSMorphingEffectClosure closure = ^(unichar ch, NSInteger index, float progress){
            
            FSCharacterLimbo *limbo = [FSCharacterLimbo new];
            limbo.ch = ch;
            limbo.rect = newRects[index];
            limbo.alpha = progress;
            limbo.size = self.font.pointSize;
            limbo.drawingProgress = 1-progress;         // progress 【0，1】 模糊->清晰
            return limbo;
        };
        
        NSString *key = keyForEffectPhase(kMorphingEffectPixelate, kMorphingPhasesAppear);
        [self.effectDictionary setObject:closure forKey:key];
    }
    
    // draw
    {
        FSMorphingDrawingClosure closure = ^(FSCharacterLimbo *limbo){
            
            float progress = limbo.drawingProgress;
            if (progress > 0) {
                
                // scale 越小越模糊
                float scale = MIN([UIScreen mainScreen].scale, 1/progress/6);
  
                UIGraphicsBeginImageContextWithOptions(limbo.rect.size, NO, scale);
                
                float fadeOutAlpha = clip(0, 1, 2-progress*2);
                CGRect rect = limbo.rect;
                rect.origin = CGPointZero;
                
                unichar ch = limbo.ch;
                
                NSString *str = [NSString stringWithCharacters:&ch length:1];
                [str drawInRect:rect withAttributes:@{NSFontAttributeName: self.font,
                                                      NSForegroundColorAttributeName: [self.textColor colorWithAlphaComponent:fadeOutAlpha]
                                                      }];
                UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                [newImage drawInRect:limbo.rect];

                return YES;
            }
            return NO;
        };
        
        NSString *key = keyForEffectPhase(kMorphingEffectPixelate, kMorphingPhasesDraw);
        [self.effectDictionary setObject:closure forKey:key];
    }
}


@end
