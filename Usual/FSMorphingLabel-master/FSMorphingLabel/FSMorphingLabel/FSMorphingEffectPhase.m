//
//  FSMorphingEffectPhase.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/29.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSMorphingEffectPhase.h"

// 7个效果的字符串key数组
NSArray *allKeysForEffect()
{
    NSMutableArray *res = [NSMutableArray array];
    
    [res addObject:keyForEffect(kMorphingEffectScale)];
    [res addObject:keyForEffect(kMorphingEffectEvaporate)];
    [res addObject:keyForEffect(kMorphingEffectFall)];
    [res addObject:keyForEffect(kMorphingEffectPixelate)];
    [res addObject:keyForEffect(kMorphingEffectSparkle)];
    [res addObject:keyForEffect(kMorphingEffectBurn)];
    [res addObject:keyForEffect(kMorphingEffectAnvil)];
    
    return res;
}

// 7个效果的字符串key
NSString *keyForEffect(FSMorphingEffect effect)
{
    NSString *resStr;
    switch (effect) {
        case kMorphingEffectScale:
            resStr = @"scale";
            break;
        case kMorphingEffectEvaporate:
            resStr = @"evaporate";
            break;
        case kMorphingEffectFall:
            resStr = @"fall";
            break;
        case kMorphingEffectPixelate:
            resStr = @"pixelate";
            break;
        case kMorphingEffectSparkle:
            resStr = @"sparkle";
            break;
        case kMorphingEffectBurn:
            resStr = @"burn";
            break;
        case kMorphingEffectAnvil:
            resStr = @"anvil";
            break;
            
        default:
            break;
    }
    return resStr;
}

// 动画6个阶段的字符串key
NSString *keyForPhase(FSMorphingPhases phase)
{
    NSString *resStr;
    switch (phase) {
        case kMorphingPhasesStart:
            resStr = @"Start";
            break;
        case kMorphingPhasesAppear:
            resStr = @"Appear";
            break;
        case kMorphingPhasesDisappear:
            resStr = @"Disappear";
            break;
        case kMorphingPhasesDraw:
            resStr = @"Draw";
            break;
        case kMorphingPhasesProgress:
            resStr = @"Progress";
            break;
        case kMorphingPhasesSkipFrames:
            resStr = @"SkipFrames";
            break;
            
        default:
            break;
    }
    return resStr;
}

// 不同效果不同阶段的字符串key拼接
NSString *keyForEffectPhase(FSMorphingEffect effect, FSMorphingPhases phase)
{
    NSString *effectStr = keyForEffect(effect);
    NSString *phaseStr = keyForPhase(phase);
    return [effectStr stringByAppendingString:phaseStr];
}



