//
//  FSMorphingLabel+Evaporate.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/30.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSMorphingLabel+Evaporate.h"

@implementation FSMorphingLabel (Evaporate)


//typedef void (^FSMorphingStartClosure)(void);
//
//typedef FSCharacterLimbo * (^FSMorphingEffectClosure)(unichar ch, NSInteger index, float progress);
//
//typedef BOOL (^FSMorphingDrawingClosure)(FSCharacterLimbo *limbo);
//
//typedef float (^FSMorphingManipulateProgressClosure)(NSInteger index,float progress, BOOL isNewChar);
//
//typedef int (^FSMorphingSkipFramesClosure)(void);


- (void)evaporateLoad
{
    // progress
    {
        FSMorphingManipulateProgressClosure closure = ^(NSInteger index,float progress, BOOL isNewChar){
            
            int j = round(cos(index)*1.2);
            
            float delay = morphingCharacterDelay;
            if (isNewChar) {
                delay = -delay;
            }
            float res = MIN(1.0, MAX(0, morphingProgress + delay*j));
            return res;
        };
        NSString *key = keyForEffectPhase(kMorphingEffectEvaporate, kMorphingPhasesProgress);
        [self.effectDictionary setObject:closure forKey:key];
    }
    
    // disappear
    {
        FSMorphingEffectClosure closure = ^(unichar ch, NSInteger index, float progress){
            
            float newProgress = easeOutQuit(progress, 0, 1.0, 1.0);
            float yOffset = -0.8*self.font.pointSize*newProgress;
        
            FSCharacterLimbo *limbo = [FSCharacterLimbo new];
            limbo.ch = ch;
            limbo.rect = CGRectOffset(previousRects[index], 0, yOffset);
            limbo.alpha = 1.0-newProgress;
            limbo.size = self.font.pointSize;
            limbo.drawingProgress = 0;
            
            return limbo;
        };
        
        NSString *key = keyForEffectPhase(kMorphingEffectEvaporate, kMorphingPhasesDisappear);
        [self.effectDictionary setObject:closure forKey:key];
    }

    // appear
    {
        FSMorphingEffectClosure closure = ^(unichar ch, NSInteger index, float progress){
            
            float newProgress = 1.0 - easeOutQuit(progress, 0, 1.0, 1.0);
            float yOffset = 1.2*self.font.pointSize*newProgress;
            
            FSCharacterLimbo *limbo = [FSCharacterLimbo new];
            limbo.ch = ch;
            limbo.rect = CGRectOffset(newRects[index], 0, yOffset);;
            limbo.alpha = progress;
            limbo.size = self.font.pointSize;
            limbo.drawingProgress = 0;
            
            return limbo;
        };
        
        NSString *key = keyForEffectPhase(kMorphingEffectEvaporate, kMorphingPhasesAppear);
        [self.effectDictionary setObject:closure forKey:key];
    }
    
}



@end
