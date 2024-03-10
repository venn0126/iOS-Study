//
//  NSString+Extension.m
//  TestHookEncryption
//
//  Created by Augus on 2024/3/10.
//

#import "NSString+Extension.h"


@implementation NSString (Extension)

- (CGSize)gt_mulLineTextSizeForMaxWidth:(CGFloat)maxWidth font:(UIFont *)font {
    
    if (self.length == 0) {
        return CGSizeMake(0, 0);
    }

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);

    return [self boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
}

- (CGSize)gt_singleLineTextSizeForMaxWidth:(CGFloat)maxWidth font:(UIFont *)font {
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGSize textSize = [self sizeWithAttributes:attributes];
    return textSize;
}

@end
