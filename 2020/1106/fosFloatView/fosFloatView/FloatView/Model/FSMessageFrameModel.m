//
//  FSMessageFrameModel.m
//  fosFloatView
//
//  Created by Augus on 2020/11/11.
//

#import "FSMessageFrameModel.h"
#import "NSString+Extension.h"

@implementation FSMessageFrameModel

- (void)setMessage:(FSMessageModel *)message {
    
    
    _message = message;
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat padding = 10;
    //1.时间
    if (!_message.hiddenTime) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeH = 30;
        CGFloat tiemW = screenWidth;
        _timeF = CGRectMake(timeX, timeY, tiemW, timeH);
    }
    
    //2.头像
    CGFloat iconH = 30;
    CGFloat iconW = 30;
    CGFloat iconY = CGRectGetMaxY(_timeF) + padding;
    CGFloat iconX = 0;
    if (FSMessageModelTypeMe == _message.type) {
        iconX = screenWidth - padding - iconW;
    }
    else
    {
        iconX = padding;
    }
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    //3.正文
    
    CGSize maxSize = CGSizeMake(200, MAXFLOAT);
    CGSize textSize = [_message.text sizeWithFont:FSTextFont maxSize:maxSize];
    CGFloat textW = textSize.width + FSEdgeInsets * 2;
    CGFloat textH = textSize.height + FSEdgeInsets * 2;
    CGFloat textY = iconY;
    CGFloat textX = 0;
    if (FSMessageModelTypeMe == _message.type) {
        // 自己发的
        // x = 头像x - 间隙 - 文本的宽度
        textX = iconX - padding - textW;
    }
    else
    {
        //别人发的
        textX = CGRectGetMaxX(_iconF) + padding;
    }
    
    self.textF = CGRectMake(textX, textY, textW, textH);
    
    CGFloat maxIconY = CGRectGetMaxY(_iconF);
    CGFloat maxTextY = CGRectGetMaxY(_textF);
    
    self.cellHeight = MAX(maxIconY, maxTextY) + padding;
    
}

@end
