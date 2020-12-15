//
//  NSString+HQExtension.m
//  QQPage
//
//  Created by 李海群 on 2017/7/18.
//  Copyright © 2017年 李海群. All rights reserved.
//

#import "NSString+HQExtension.h"

@implementation NSString (HQExtension)
-(CGSize) sizeWithFont:(UIFont *) font maxSize:(CGSize) maxSize
{
    NSDictionary *dict  = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return  textSize;
}
@end
