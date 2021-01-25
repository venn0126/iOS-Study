//
//  FSCharacterDiffResult.h
//  iDraw
//
//  Created by 翁志方 on 2016/12/20.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import <Foundation/Foundation.h>


// 动效
// 总共3个动效   1.旧字符消失  2.新字符出现  3. 旧字符移动到新字符位置

// 计算两个字符串之间区别
typedef NS_ENUM(NSInteger, FSCharacterDiffType){
    kCharacterDiffTypeSame,         // 相同位置有相同字符
    kCharacterDiffTypeAdd,          // 插入新字符
    kCharacterDiffTypeDelete,       // 删除字符
    kCharacterDiffTypeMove,         // 移动字符
    kCharacterDiffTypeMoveAndAdd,   // 添加移动
    kCharacterDiffTypeReplace       // 替换字符
};

@interface FSCharacterDiffResult : NSObject

@property (nonatomic, assign) FSCharacterDiffType diffType;

@property (nonatomic, assign) int moveOffset;

@property (nonatomic, assign) BOOL skip;


// 计算旧字符串与新字符串之间的区别
+ (NSArray *)compareString:(NSString *)lstr withRightString:(NSString *) rstr;


@end
