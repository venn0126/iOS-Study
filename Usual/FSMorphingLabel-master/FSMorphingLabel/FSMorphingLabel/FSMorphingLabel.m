//
//  FSMorphingLabel.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/20.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSMorphingLabel.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>

#import "FSMorphingLabel+Fall.h"
#import "FSMorphingLabel+Burn.h"
#import "FSMorphingLabel+Anvil.h"
#import "FSMorphingLabel+Sparkle.h"
#import "FSMorphingLabel+Pixelate.h"
#import "FSMorphingLabel+Evaporate.h"


//@interface FSMorphingLabel()
//{
//}
//
//@end

@implementation FSMorphingLabel


- (void)didMoveToSuperview
{
    // 从分类中加载效果字典
    self.effectDictionary = [NSMutableDictionary dictionary];
    for (NSString *str in allKeysForEffect() ) {
        NSString *selStr = [str stringByAppendingString:@"Load"];
        SEL sel = NSSelectorFromString(selStr);
        if ([self respondsToSelector:sel]) {
            [self performSelector:sel withObject:nil afterDelay:0];
        }
    }
}

- (FSEmitterView *)emitterView
{
    if (_emitterView == nil) {
        _emitterView = [[FSEmitterView alloc] initWithFrame:self.bounds];
        [self addSubview:_emitterView];
    }
    return _emitterView;
}

- (void)setText:(NSString *)text
{
    previousText = self.text?:@"";
    super.text = text?:@"";
    
    // 计算新旧字符串区别
    diffResults = [FSCharacterDiffResult compareString:previousText withRightString:text];
    
    // 动画参数初始化
    morphingDuration = 0.6;
    morphingCharacterDelay = 0.026;
    
    morphingProgress = 0;
    currentFrame = 0;
    totalFrame = 0;
    
    // 计算新旧字符串的所在位置
    [self setNeedsLayout];
    
    // 开启动画定时器
    if (![previousText isEqualToString:text]){
        if (displayLink){
            displayLink.paused = false;
        }else{
            displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayFrameTick)];
            [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        }
        
        // startClosure
        NSString *key = keyForEffectPhase(self.morphingEffect, kMorphingPhasesStart);
        FSMorphingStartClosure closure = self.effectDictionary[key];
        if (closure){
            closure();
        }
    }
}

- (void)setNeedsLayout
{
    // 计算新旧字符串每个字符的frame数组
    if (previousRects) free(previousRects);
    previousRects = [self rectsOfEachCharacter:previousText withFont:self.font];
    
    if (newRects) free(newRects);
    newRects = [self rectsOfEachCharacter:self.text withFont:self.font];
}

- (void)displayFrameTick
{
    if (displayLink.duration>0 && totalFrame==0) {
        // 动画刚开始 计算总的帧数 和 由于顺序显示的时延导致的帧数
        float frameRate = displayLink.duration / displayLink.frameInterval; // 一帧耗费时间
        totalFrame = ceil(morphingDuration / frameRate);
        float totalDelay = self.text.length * morphingCharacterDelay;
        totalDelayFrame = ceil(totalDelay / frameRate);
    }
    
    currentFrame += 1;
    if (![previousText isEqualToString:self.text] && currentFrame<totalFrame+totalDelayFrame+5) {
        morphingProgress += 1.0 / totalFrame;
        
        // 是否跳帧绘制(粒子动画的计算量较大，需要考虑跳帧显示)
        NSString *key = keyForEffectPhase(self.morphingEffect, kMorphingPhasesSkipFrames);
        FSMorphingSkipFramesClosure closure = self.effectDictionary[key];
        ++skipFramesCount;
        if (closure){
            if (skipFramesCount > closure()){
                skipFramesCount = 0;
                [self setNeedsDisplay];
            }
        }else{
            [self setNeedsDisplay];
        }
    }else{
        // 结束
        displayLink.paused = YES;
    }
}
- (CGRect *)rectsOfEachCharacter:(NSString *)string withFont:(UIFont *)font
{
    float leftOffset = 0;
    
    charHeight = [@"Leg" sizeWithAttributes:@{NSFontAttributeName:font}].height;
    
    float topOffset = (self.bounds.size.height - charHeight)/2.0;
    
    NSRange range;
    range.length = 1;
    CGRect *charRects = malloc(sizeof(CGRect)*string.length);
    for (int i=0; i<string.length; ++i) {
        range.location = i;
        NSString *str = [string substringWithRange:range];
        CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:font}];
        charRects[i] = CGRectMake(leftOffset, topOffset, size.width, size.height);
        
        leftOffset += size.width;
    }
    
    totalWidth = leftOffset;
    
    float stringLeftOffset = 0;
    if (self.textAlignment == NSTextAlignmentCenter) {
        stringLeftOffset = (self.bounds.size.width - totalWidth)/2.0;
    }else if (self.textAlignment == NSTextAlignmentRight) {
        stringLeftOffset = (self.bounds.size.width - totalWidth);
    }
    
    CGRect *offsetedCharRects = malloc(sizeof(CGRect)*string.length);
    for (int i=0; i<string.length; ++i) {
        
        CGRect *p = offsetedCharRects+i;
        *p = charRects[i];
        p->origin.x += stringLeftOffset;
    }
    
    free(charRects);
    
    return offsetedCharRects;
}
- (FSCharacterLimbo *)limboOfOriginalCharacter:(unichar) ch
                                         index:(NSInteger) index
                                       process:(float) progress
{
    CGRect currentRect = previousRects[index];
    float oriX = currentRect.origin.x;
    float newX;
    
    FSCharacterDiffResult *diffResult = diffResults[index];
    float currentFontSize = self.font.pointSize;
    float currentAlpha = 1.0;
    
    switch (diffResult.diffType) {
        case kCharacterDiffTypeSame:
        case kCharacterDiffTypeMove:
        case kCharacterDiffTypeMoveAndAdd:{
            // 移动当前文字
            newX = newRects[index+diffResult.moveOffset].origin.x;
            currentRect.origin.x = easeOutQuit(progress, oriX, newX - oriX, 1);
            break;
        }
            
        default:{
            // 移除当前文字
            NSString *key = keyForEffectPhase(self.morphingEffect, kMorphingPhasesDisappear);
            FSMorphingEffectClosure closure = self.effectDictionary[key];
            
            if (closure){
                return closure(ch, index, progress);
            }else{
                // 默认以字体缩小并变透明的方式消失
                float fontEase = easeOutQuit(progress, 0, self.font.pointSize, 1);
                currentFontSize = MAX(0.0001, self.font.pointSize-fontEase);
                
                currentAlpha = 1.0-progress;
                CGRect rect = previousRects[index];
                rect.origin.y += self.font.pointSize - currentFontSize;
                currentRect = rect;
            }
        }
            break;
    }
    
    FSCharacterLimbo *limbo = [FSCharacterLimbo new];
    limbo.ch = ch;
    limbo.rect = currentRect;
    limbo.alpha = currentAlpha;
    limbo.size = currentFontSize;
    limbo.drawingProgress = 0;
    
    return limbo;
}
- (FSCharacterLimbo *)limboOfNewCharacter:(unichar) ch
                                    index:(NSInteger) index
                                  process:(float) progress
{
    CGRect currentRect = newRects[index];
    
    float currentFontSize;
    float currentAlpha = 1.0;
    
    NSString *key = keyForEffectPhase(self.morphingEffect, kMorphingPhasesAppear);
    FSMorphingEffectClosure closure = self.effectDictionary[key];
    
    if (closure){
        return closure(ch, index, progress);
    }else{
        currentFontSize = MAX(0.0001, easeOutQuit(progress, 0, self.font.pointSize, 1));
        currentAlpha = 1.0-progress;
        currentRect.origin.y += self.font.pointSize - currentFontSize;
        
        FSCharacterLimbo *limbo = [FSCharacterLimbo new];
        limbo.ch = ch;
        limbo.rect = currentRect;
        limbo.alpha = morphingProgress;
        limbo.size = currentFontSize;
        limbo.drawingProgress = 0;
        
        return limbo;
    }
}
- (NSArray<FSCharacterLimbo *> *)limboOfCharacter
{
    // original characters
    NSMutableArray *limboArr = [NSMutableArray array];
    for (int i=0; i<previousText.length; ++i) {
        unichar ch = [previousText characterAtIndex:i];
        
        float progress = 0;
        
        // progressClosures
        NSString *key = keyForEffectPhase(self.morphingEffect, kMorphingPhasesProgress);
        FSMorphingManipulateProgressClosure closure = self.effectDictionary[key];
        
        if (closure){
            progress = closure(i, morphingProgress, false);
        }else{
            // morphingCharacterDelay时间单位是秒  字符延迟时间 / 总时间 这边的延迟相当于总时间的40分之一左右
            progress = MIN(1.0, MAX(0, morphingProgress+morphingCharacterDelay*i));
        }
        FSCharacterLimbo *limbo = [self limboOfOriginalCharacter:ch index:i process:progress];
        [limboArr addObject:limbo];
    }
    
    // new characters
    for (int i=0; i<self.text.length; ++i) {
        unichar ch = [self.text characterAtIndex:i];
        float progress = 0;
        
        // progressClosures
        NSString *key = keyForEffectPhase(self.morphingEffect, kMorphingPhasesProgress);
        FSMorphingManipulateProgressClosure closure = self.effectDictionary[key];
        
        if (closure){
            progress = closure(i, morphingProgress, true);
        }else{
            progress = MIN(1.0, MAX(0, morphingProgress - morphingCharacterDelay*i));
        }
        
        FSCharacterDiffResult *diffResult = diffResults[i];
        
        if (diffResult.skip){
            // 不绘制老字符移动到现在位置的字符
            continue;
        }
        switch (diffResult.diffType) {
            case kCharacterDiffTypeMoveAndAdd:
            case kCharacterDiffTypeReplace:
            case kCharacterDiffTypeAdd:
            case kCharacterDiffTypeDelete:
            {
                FSCharacterLimbo *limbo = [self limboOfNewCharacter:ch index:i process:progress];
                [limboArr addObject:limbo];
            }
            default:
                break;
        }
    }
    return limboArr;
}

- (void)drawTextInRect:(CGRect)rect
{
    NSArray *limbos = [self limboOfCharacter];
    if (self.morphingDisable || limbos.count == 0) {
        [super drawTextInRect:rect];
        return;
    }
    for (FSCharacterLimbo *limbo in limbos) {
        
        // drawClosure
        NSString *key = keyForEffectPhase(self.morphingEffect, kMorphingPhasesDraw);
        FSMorphingDrawingClosure closure = self.effectDictionary[key];
        
        BOOL willAvoidDefaultDrawing = NO;
        if (closure){
            willAvoidDefaultDrawing = closure(limbo);
        }
        if (willAvoidDefaultDrawing) {
            continue;
        }
        
        CGRect rect = limbo.rect;
        
        // 默认绘制
        const unichar ch = limbo.ch;
        NSString *str = [NSString stringWithCharacters:&ch length:1];
        
        [str drawInRect:rect
         withAttributes:@{NSFontAttributeName:
                              [UIFont fontWithName:self.font.fontName size:limbo.size],
                          NSForegroundColorAttributeName:
                              [self.textColor colorWithAlphaComponent:limbo.alpha]}];
    }
    
}

@end

