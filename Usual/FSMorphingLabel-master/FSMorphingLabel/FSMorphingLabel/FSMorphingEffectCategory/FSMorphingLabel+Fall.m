//
//  FSMorphingLabel+Fall.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/30.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSMorphingLabel+Fall.h"

@implementation FSMorphingLabel (Fall)


- (void)fallLoad
{
    // progress
    {
        FSMorphingManipulateProgressClosure closure = ^(NSInteger index,float progress, BOOL isNewChar){
         
            float res;
            
            if (isNewChar) {
                res = MIN(1.0, MAX(0.0001, progress - morphingCharacterDelay*index/1.7));
            }else{
                int j = round(cos(index)*1.7);
                
                res = MIN(1.0, MAX(0.0001, progress + morphingCharacterDelay*j));
            }
            
            return res;
        };
        NSString *key = keyForEffectPhase(kMorphingEffectFall, kMorphingPhasesProgress);
        [self.effectDictionary setObject:closure forKey:key];
    }
    
    // disappear
    {
        FSMorphingEffectClosure closure = ^(unichar ch, NSInteger index, float progress){
            
            FSCharacterLimbo *limbo = [FSCharacterLimbo new];
            limbo.ch = ch;
            limbo.rect = previousRects[index];
            limbo.alpha = 1.0-progress;
            limbo.size = self.font.pointSize;
            limbo.drawingProgress = progress;
            
            return limbo;
        };
        
        NSString *key = keyForEffectPhase(kMorphingEffectFall, kMorphingPhasesDisappear);
        [self.effectDictionary setObject:closure forKey:key];
    }
    
    // appear
    {
        FSMorphingEffectClosure closure = ^(unichar ch, NSInteger index, float progress){
            // 从左下角淡入放大
            float currentFontSize = easeOutQuit(progress, 0, self.font.pointSize, 1);
            float yOffset = self.font.pointSize - currentFontSize;
            
            FSCharacterLimbo *limbo = [FSCharacterLimbo new];
            limbo.ch = ch;
            limbo.rect = CGRectOffset(newRects[index], 0, yOffset);;
            limbo.alpha = progress;
            limbo.size = currentFontSize;
            limbo.drawingProgress = 0;
            
            return limbo;
        };
        
        NSString *key = keyForEffectPhase(kMorphingEffectFall, kMorphingPhasesAppear);
        [self.effectDictionary setObject:closure forKey:key];
    }
    
    // draw
    {
        FSMorphingDrawingClosure closure = ^(FSCharacterLimbo *limbo){
            
            float progress = limbo.drawingProgress;
            if (progress > 0.0) {
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGRect charRect = limbo.rect;
                CGContextSaveGState(context);
                
                float charCenterX = charRect.origin.x + charRect.size.width/2;
                float charBottomY = charRect.origin.y + charRect.size.height - self.font.pointSize / 6;
                
   
                UIColor *charColor = self.textColor;
                
                if (progress > 0.5){
                    float ease = easeInQuit(progress-0.4, 0, 1.0, 0.5);
                    charBottomY += ease*10.0;
                    
                    float fadeOutAlpha = MIN(1.0, MAX(0, progress*-2 + 2.0));
                    charColor = [charColor colorWithAlphaComponent:fadeOutAlpha];
                }
                
                CGContextTranslateCTM(context, charCenterX, charBottomY);
                
                charRect.origin.x = charRect.size.width/ -2;
                charRect.origin.y = charRect.size.height * -1.0 + self.font.pointSize / 6;
      
                float angle = sin(limbo.rect.origin.x)>0.5 ? 168 : -168;
                float rotation = easeOutBack(MIN(1.0, progress), 0, 1, 1) * angle;
                
                CGContextRotateCTM(context, rotation*M_PI/180);
                
                unichar ch = limbo.ch;
                NSString *str = [NSString stringWithCharacters:&ch length:1];
                
                [str drawInRect:charRect withAttributes:@{NSFontAttributeName: [self.font fontWithSize:limbo.size],
                                                          NSForegroundColorAttributeName: charColor}];
                
                CGContextRestoreGState(context);
            
                return YES;
            }
            
            return NO;
        };
        
        NSString *key = keyForEffectPhase(kMorphingEffectFall, kMorphingPhasesDraw);
        [self.effectDictionary setObject:closure forKey:key];
    }
}


@end
