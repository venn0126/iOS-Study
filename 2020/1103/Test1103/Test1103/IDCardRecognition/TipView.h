//
//  TipView.h
//  CC_Smart_Eye
//
//  Created by mac on 13-3-7.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipView : UIView
{
    UILabel *tipLabel;
}

+(void)showWithText:(NSString*)text inView:(UIView*)view atPoint:(CGPoint)point;

@end
