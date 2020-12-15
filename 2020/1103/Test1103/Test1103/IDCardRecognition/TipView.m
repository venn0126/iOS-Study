//
//  TipView.m
//  CC_Smart_Eye
//
//  Created by mac on 13-3-7.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "TipView.h"
//#import <QuartzCore/QuartzCore.h>

@implementation TipView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        //[self.layer setCornerRadius:4];
        //[self.layer setBorderWidth:2];
        //[self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self setBackgroundColor:[UIColor clearColor]];
        tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [tipLabel setTextAlignment:NSTextAlignmentCenter];
        [tipLabel setTextColor:[UIColor redColor]];
        [tipLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:tipLabel];
    }
    return self;
}

-(void)showWithText:(NSString*)text inView:(UIView*)view
{
    [view addSubview:self];
    [tipLabel setText:text];
    [self setHidden:NO];
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.3f animations:^(void)
     {
         self.alpha = 1.0f;
     } completion:^(BOOL finish)
     {
         [UIView animateWithDuration:1.0f animations:^(void)
          {
              
          } completion:^(BOOL finish)
          {
              [UIView animateWithDuration:1.0f animations:^(void)
              {
                  self.alpha = 0.0f;
              } completion:^(BOOL complete)
               {
                   [self setHidden:YES];
                   if (view) {
                       [self removeFromSuperview];
                   }
               }];
          }];
     }];
}

+(void)showWithText:(NSString*)text inView:(UIView*)view atPoint:(CGPoint)point
{
    CGSize size = [text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17]];
    CGRect frame = CGRectMake(0, 0, size.width+20, 38);
    TipView *tp = [[TipView alloc] initWithFrame:frame];
    tp.center = point;
    [tp showWithText:text inView:view];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
