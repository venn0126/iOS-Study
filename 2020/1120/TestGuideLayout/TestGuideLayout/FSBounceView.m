//
//  FSBounceView.m
//  TestGuideLayout
//
//  Created by Augus on 2020/12/15.
//

#import "FSBounceView.h"

@interface FSBounceView ()

//@property (nonatomic, strong) UIView *contentView;


@end

@implementation FSBounceView{
    
    UIView *_contentView;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


- (void)setupContent {
    self.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
     
    //alpha 0.0  白色   alpha 1 ：黑色   alpha 0～1 ：遮罩颜色，逐渐
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
     
    if (_contentView == nil) {

        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 100, self.bounds.size.width, self.bounds.size.height)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        // 右上角关闭按钮
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(_contentView.bounds.size.width - 20 - 15, 15, 20, 20);
        [closeBtn setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:closeBtn];
    }
}


- (void)disMissView {
     
    [_contentView setFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
    
    [UIView animateWithDuration:0.3f
                     animations:^{
        
        self.alpha = 0.0;
        [_contentView setFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
    }completion:^(BOOL finished){
        
        [self removeFromSuperview];
        [_contentView removeFromSuperview];
        
    }];
     
}

//- (void)showInView:(UIView *)view {
//    if (!view) {
//        return;
//    }
//     
//    [view addSubview:self];
//    [view addSubview:_contentView];
//     
//    [_contentView setFrame:CGRectMake(0, UI_View_Height, UI_View_Width, ZLBounceViewHight)];
//     
//    [UIView animateWithDuration:0.3 animations:^{
//         
//        self.alpha = 1.0;
//         
//        [_contentView setFrame:CGRectMake(0, UI_View_Height - ZLBounceViewHight, UI_View_Width, ZLBounceViewHight)];
//         
//    } completion:nil];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
