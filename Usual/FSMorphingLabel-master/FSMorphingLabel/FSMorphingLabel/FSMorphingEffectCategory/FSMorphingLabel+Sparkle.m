//
//  FSMorphingLabel+Sparkle.m
//  iDraw
//
//  Created by 翁志方 on 2017/1/6.
//  Copyright © 2017年 翁志方. All rights reserved.
//

#import "FSMorphingLabel+Sparkle.h"

@implementation FSMorphingLabel (Sparkle)

- (void)sparkleLoad
{
    // start
    {
        FSMorphingStartClosure closure = ^{
            [self.emitterView removeAllEmitters];
        };
        
        NSString *key = keyForEffectPhase(kMorphingEffectSparkle, kMorphingPhasesStart);
        [self.effectDictionary setObject:closure forKey:key];
    }
    
    // progress
    {
        FSMorphingManipulateProgressClosure closure = ^(NSInteger index,float progress, BOOL isNewChar){
            
            float res;
            
            if (isNewChar) {
                CGFloat j = sin(index)*1.5;
                res = clip(0, 1, progress+morphingCharacterDelay*j);
            }else{
                res = clip(0, 1, progress);
            }
            
            return res;
        };
        
        NSString *key = keyForEffectPhase(kMorphingEffectSparkle, kMorphingPhasesProgress);
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
            return limbo;
        };
        
        NSString *key = keyForEffectPhase(kMorphingEffectSparkle, kMorphingPhasesDisappear);
        [self.effectDictionary setObject:closure forKey:key];
    }
    
    // appear
    {
        FSMorphingEffectClosure closure = ^(unichar ch, NSInteger index, float progress){
            if (ch != ' ') {
                CGRect rect = newRects[index];
                CGPoint emitterPosition;
                emitterPosition.x = rect.origin.x + rect.size.width/2;
                emitterPosition.y = rect.origin.y + rect.size.height*0.9*progress;
                
                
                [[[self.emitterView createEmitter:[NSString stringWithFormat:@"c%ld",(long)index]
                                     particleName:@"Sparkle"
                                         duration:morphingDuration
                                 configureClosure:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                                     
                                     layer.emitterSize = CGSizeMake(rect.size.width, 1);
                                     layer.renderMode = kCAEmitterLayerAdditive;
                                     layer.emitterMode = kCAEmitterLayerOutline;
                                     
                                     cell.emissionLongitude =  -M_PI_2;
                                     cell.emissionRange = M_PI;
                                     cell.scale = self.font.pointSize / 300;
                                     cell.scaleSpeed = self.font.pointSize / 300;
                                     cell.birthRate = self.font.pointSize*arc4random_uniform(7)+3;
                                     
                                     cell.yAcceleration = 100;
                                     cell.velocity = 50;
                                     cell.velocityRange = 80;
                                     cell.lifetime = 0.16;
                                     cell.lifetimeRange = 0.1;
                                 }] update:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                                     layer.emitterPosition = emitterPosition;
                                 }] play];
            }
            
            FSCharacterLimbo *limbo = [FSCharacterLimbo new];
            limbo.ch = ch;
            limbo.rect = newRects[index];
            limbo.alpha = morphingDuration;
            limbo.size = self.font.pointSize;
            limbo.drawingProgress = progress;
            return limbo;
        };
        
        NSString *key = keyForEffectPhase(kMorphingEffectSparkle, kMorphingPhasesAppear);
        [self.effectDictionary setObject:closure forKey:key];
    }
    
    // draw
    {
        FSMorphingDrawingClosure closure = ^(FSCharacterLimbo *limbo){
            
            float progress = limbo.drawingProgress;
            if (progress > 0) {
                float maskedHeight = limbo.rect.size.height * MAX(0.001, progress);
                CGSize maskedSize = CGSizeMake(limbo.rect.size.width, maskedHeight);

                UIGraphicsBeginImageContextWithOptions(maskedSize, NO, [UIScreen mainScreen].scale);
                
                CGRect rect = CGRectMake(0, 0, limbo.rect.size.width, maskedHeight);
                
                unichar ch = limbo.ch;
                NSString *str = [NSString stringWithCharacters:&ch length:1];
                [str drawInRect:rect withAttributes:@{NSFontAttributeName: self.font,
                                                      NSForegroundColorAttributeName: self.textColor
                                                      }];
                UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
           
                CGRect dRect = limbo.rect;
                dRect.size.height = maskedHeight;
                [newImage drawInRect:dRect];
                
                return YES;
            }
            return NO;
        };
        
        NSString *key = keyForEffectPhase(kMorphingEffectSparkle, kMorphingPhasesDraw);
        [self.effectDictionary setObject:closure forKey:key];
    }
    
    // skipFrames
    {
        FSMorphingSkipFramesClosure closure = ^(){
            return 1;
        };
        NSString *key = keyForEffectPhase(kMorphingEffectSparkle, kMorphingPhasesSkipFrames);
        [self.effectDictionary setObject:closure forKey:key];
    }
    
}

@end
