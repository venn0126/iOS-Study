//
//  FSMorphingLabel+Anvil.m
//  iDraw
//
//  Created by 翁志方 on 2017/1/3.
//  Copyright © 2017年 翁志方. All rights reserved.
//

#import "FSMorphingLabel+Anvil.h"

@implementation FSMorphingLabel (Anvil)

- (void)anvilLoad
{
    // start
    {
        FSMorphingStartClosure closure = ^(){
            [self.emitterView removeAllEmitters];
            
            if (self.text.length == 0) {
                return;
            }
            NSInteger centerIndex = self.text.length/2;
            CGRect centerRect = newRects[centerIndex];
            
            [self.emitterView createEmitter:@"leftSmoke"
                               particleName:@"Smoke"
                                   duration:0.6
                           configureClosure:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                               layer.emitterSize = CGSizeMake(1, 1);
                               layer.emitterPosition = CGPointMake(centerRect.origin.x, centerRect.origin.y + centerRect.size.height / 1.3);
                               
                               cell.emissionLongitude = M_PI;
                               cell.emissionRange = M_PI_4 / 5.0;
                               cell.scale = self.font.pointSize/90.0;
                               cell.scaleSpeed = self.font.pointSize/130;
                               cell.birthRate = 60;
                               cell.velocity = 80 + arc4random_uniform(60);
                               cell.velocityRange = 100;
                               cell.yAcceleration = -40;
                               cell.xAcceleration = 70;
                               cell.lifetime = morphingDuration*2;
                               cell.spin = 10;
                               cell.alphaSpeed = - 0.5 / morphingDuration;
                           }];
            
            [self.emitterView createEmitter:@"rightSmoke"
                               particleName:@"Smoke"
                                   duration:0.6
                           configureClosure:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                               layer.emitterSize = CGSizeMake(1, 1);
                               layer.emitterPosition = CGPointMake(centerRect.origin.x, centerRect.origin.y + centerRect.size.height / 1.3);
                               
                               cell.emissionLongitude = 0;
                               cell.emissionRange = M_PI_4 / 5.0;
                               cell.scale = self.font.pointSize/90.0;
                               cell.scaleSpeed = self.font.pointSize/130;
                               cell.birthRate = 60;
                               cell.velocity = 80 + arc4random_uniform(60);
                               cell.velocityRange = 100;
                               cell.yAcceleration = -40;
                               cell.xAcceleration = -70;
                               cell.lifetime = morphingDuration*2;
                               cell.spin = -10;
                               cell.alphaSpeed = - 0.5 / morphingDuration;
                           }];
            
            [self.emitterView createEmitter:@"leftFragments"
                               particleName:@"Fragment"
                                   duration:0.6
                           configureClosure:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                               layer.emitterSize = CGSizeMake(self.font.pointSize, 1);
                               layer.emitterPosition = CGPointMake(centerRect.origin.x, centerRect.origin.y + centerRect.size.height / 1.3);
                               
                               cell.scale = self.font.pointSize/90.0;
                               cell.scaleSpeed = self.font.pointSize/40;
                               cell.color = self.textColor.CGColor;
                               cell.birthRate = 60;
                               cell.velocity = 350;
                               
                               cell.yAcceleration = 0;
                               cell.xAcceleration = 10 * arc4random_uniform(10);
                               
                               cell.emissionLongitude = M_PI;
                               cell.emissionRange = M_PI_4 / 5.0;
                               cell.alphaSpeed = -2;
                               
                               cell.lifetime = morphingDuration;
                           }];
            
            [self.emitterView createEmitter:@"rightFragments"
                               particleName:@"Fragment"
                                   duration:0.6
                           configureClosure:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                               layer.emitterSize = CGSizeMake(self.font.pointSize, 1);
                               layer.emitterPosition = CGPointMake(centerRect.origin.x, centerRect.origin.y + centerRect.size.height / 1.3);
                               
                               cell.scale = self.font.pointSize/90.0;
                               cell.scaleSpeed = self.font.pointSize/40;
                               cell.color = self.textColor.CGColor;
                               cell.birthRate = 60;
                               cell.velocity = 350;
                               
                               cell.yAcceleration = 0;
                               cell.xAcceleration = -10 * arc4random_uniform(10);
                               
                               cell.emissionLongitude = 0;
                               cell.emissionRange = M_PI_4 / 5.0;
                               cell.alphaSpeed = -2;
                               
                               cell.lifetime = morphingDuration;
                           }];
            
            [self.emitterView createEmitter:@"fragments"
                               particleName:@"Fragment"
                                   duration:0.6
                           configureClosure:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                               layer.emitterSize = CGSizeMake(self.font.pointSize, 1);
                               layer.emitterPosition = CGPointMake(centerRect.origin.x, centerRect.origin.y + centerRect.size.height / 1.3);
                               
                               cell.scale = self.font.pointSize/90.0;
                               cell.scaleSpeed = self.font.pointSize/40;
                               cell.color = self.textColor.CGColor;
                               cell.birthRate = 60;
                               cell.velocity = 250;
                               cell.velocityRange = arc4random_uniform(20)+30;
                               
                               cell.yAcceleration = 500;
                               
                               cell.emissionLongitude = -M_PI_2;
                               cell.emissionRange = M_PI_2;
                               cell.alphaSpeed = -1;
                               
                               cell.lifetime = morphingDuration;
                           }];
        };
        NSString *key = keyForEffectPhase(kMorphingEffectAnvil, kMorphingPhasesStart);
        [self.effectDictionary setObject:closure forKey:key];
    }
    
    // progress
    {
        FSMorphingManipulateProgressClosure closure = ^(NSInteger index,float progress, BOOL isNewChar){
            float res;
            if (isNewChar) {
                float j = sinf(index)*1.7;
                res = MIN(1.0, MAX(0, progress + morphingCharacterDelay*j));
      
            }else{
                res = MIN(1.0, MAX(0, progress));
            }
            return res;
        };
        NSString *key = keyForEffectPhase(kMorphingEffectAnvil, kMorphingPhasesProgress);
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
            limbo.drawingProgress = 0;
            
            return limbo;
        };
        
        NSString *key = keyForEffectPhase(kMorphingEffectAnvil, kMorphingPhasesDisappear);
        [self.effectDictionary setObject:closure forKey:key];
    }
    
    // appear
    {
        FSMorphingEffectClosure closure = ^(unichar ch, NSInteger index, float progress){
            
            CGRect rect = newRects[index];
            if (progress<=1.0) {
                float ease = easeOutBounce(progress, 0, 1, 1);
                rect.origin.y = rect.origin.y * ease;
            }
            
            if (progress > morphingDuration * 0.5) {            // 直接0.5就好，progress是【0，1】按百分比的，morphingDuration是以秒为单位的
                float end = morphingDuration * 0.55;
                [[[self.emitterView createEmitter:@"fragments" particleName:@"Fragment" duration:0.6 configureClosure:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                }] update:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                    if (progress > end){
                        layer.birthRate = 0;
                    }
                }] play];
                [[[self.emitterView createEmitter:@"leftFragments" particleName:@"Fragment" duration:0.6 configureClosure:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                }] update:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                    if (progress > end){
                        layer.birthRate = 0;
                    }
                }] play];
                [[[self.emitterView createEmitter:@"rightFragments" particleName:@"Fragment" duration:0.6 configureClosure:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                }] update:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                    if (progress > end){
                        layer.birthRate = 0;
                    }
                }] play];
            }
            if (progress > morphingDuration * 0.63) {
                float end = morphingDuration * 0.7;
                
                [[[self.emitterView createEmitter:@"leftSmoke" particleName:@"Smoke" duration:0.6 configureClosure:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                }] update:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                    if (progress > end){
                        layer.birthRate = 0;
                    }
                }] play];
                [[[self.emitterView createEmitter:@"rightSmoke" particleName:@"Smoke" duration:0.6 configureClosure:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                }] update:^(CAEmitterLayer *layer, CAEmitterCell *cell) {
                    if (progress > end){
                        layer.birthRate = 0;
                    }
                }] play];
            }
            
            FSCharacterLimbo *limbo = [FSCharacterLimbo new];
            limbo.ch = ch;
            limbo.rect = rect;
            limbo.alpha = progress;
            limbo.size = self.font.pointSize;
            limbo.drawingProgress = 0;
            
            return limbo;
        };
        
        NSString *key = keyForEffectPhase(kMorphingEffectAnvil, kMorphingPhasesAppear);
        [self.effectDictionary setObject:closure forKey:key];
    }
    
}


@end
