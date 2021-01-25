//
//  FSMorphingEffectPhase.h
//  iDraw
//
//  Created by 翁志方 on 2016/12/29.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#ifndef FSMorphingEffectPhase_h
#define FSMorphingEffectPhase_h

// 动画效果
typedef NS_ENUM(NSInteger, FSMorphingEffect){
    kMorphingEffectScale = 0,               // 缩放
    kMorphingEffectEvaporate,               // 蒸发
    kMorphingEffectFall,                    // 下落
    kMorphingEffectPixelate,                // 像素化
    kMorphingEffectSparkle,                 // 闪烁
    kMorphingEffectBurn,                    // 燃烧
    kMorphingEffectAnvil                    // 震荡
};

// 动画阶段
typedef NS_ENUM(NSInteger, FSMorphingPhases){
    kMorphingPhasesStart,
    kMorphingPhasesAppear,
    kMorphingPhasesDisappear,
    kMorphingPhasesDraw,
    kMorphingPhasesProgress,
    kMorphingPhasesSkipFrames,
};


NSArray  *allKeysForEffect(void);

NSString *keyForEffect(FSMorphingEffect effect);

NSString *keyForPhase(FSMorphingPhases phase);

NSString *keyForEffectPhase(FSMorphingEffect effect, FSMorphingPhases phase);


#endif /* FSMorphingEffectPhase_h */
