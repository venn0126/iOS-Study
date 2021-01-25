//
//  FSCharacterDiffResult.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/20.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSCharacterDiffResult.h"



// ABC
// BAAA
//
// moveAndAdd   skip
// moveAndAdd   skip
// replace
// add
//
//
//
// hollow
// logo
//
// replace      skip
// same
// moveAndAdd
// replace
// move
// delete


@implementation FSCharacterDiffResult

+ (NSArray *)compareString:(NSString *)lstr withRightString:(NSString *) rstr
{
    NSInteger llen = lstr.length;
    NSInteger rlen = rstr.length;
    
    NSInteger maxlen = MAX(llen, rlen);
    NSMutableArray *resArr = [NSMutableArray arrayWithCapacity:maxlen];
    
    // 在同lstr匹配过程中，标记rstr的某个字符是否被选择
    BOOL *chooseFlagArr = malloc(sizeof(BOOL)*rlen);
    memset(chooseFlagArr, 0, sizeof(BOOL)*rlen);
    
    // 计算 diffObj
    for (int i=0; i<maxlen; ++i) {
        FSCharacterDiffResult *diffObj = [FSCharacterDiffResult new];
        [resArr addObject:diffObj];
        
        if (i>=llen) {
            // 比旧字符串长的新字符串字符
            diffObj.diffType = kCharacterDiffTypeAdd;           // 该位置无旧字符，插入新字符
            continue;
        }
        
        unichar lch = [lstr characterAtIndex:i];
        BOOL findCharacter = NO;
        for (int j=0; j<rlen; ++j) {
            if (chooseFlagArr[j]) {
                // 新字符串中该位置的字符已经被前面的匹配过了
                continue;
            }
            
            unichar rch = [rstr characterAtIndex:j];
            if (lch == rch) {
                findCharacter = YES;
                chooseFlagArr[j] = YES;
                
                if (i==j) {
                    diffObj.diffType = kCharacterDiffTypeSame;              // 该位置有相同字符，不动
                }else{
                    if (i<rlen) {
                        // 旧字符位置在新字符串长度以内，移动后本位置需要插入新字符
                        diffObj.diffType = kCharacterDiffTypeMoveAndAdd;    // 该位置旧字符移动到新字符位置，需插入新字符
                    }else{
                        diffObj.diffType = kCharacterDiffTypeMove;          // 该位置旧字符移动到新字符位置，无新字符
                    }
                    diffObj.moveOffset = j - i;         // 旧字符移动到新的位置的偏移量
                }
                break;
            }
        }// for(j)
        
        // 字符不在新字符串
        if (!findCharacter) {
            if (i<rlen) {
                diffObj.diffType = kCharacterDiffTypeReplace;   // 该字符位置有新字符，旧字符消失，新字符插入
            }else{
                diffObj.diffType = kCharacterDiffTypeDelete;    // 比新字符串长的字符，直接删除
            }
        }
    }// for(i)
    
    // 有被移动到的位置skip设置为真
    for (int i=0; i<maxlen; ++i) {
        FSCharacterDiffResult *diffObj = resArr[i];
        if (diffObj.diffType == kCharacterDiffTypeMoveAndAdd ||
            diffObj.diffType == kCharacterDiffTypeMove) {
            
            NSInteger index = i + diffObj.moveOffset;
            if (index < maxlen) {
                FSCharacterDiffResult *obj = resArr[index];
                obj.skip = YES;
            }
            
        }
    }
    
    free(chooseFlagArr);
    
    return resArr;
}


@end
