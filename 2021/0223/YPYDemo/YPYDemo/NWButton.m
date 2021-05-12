//
//  NWButton.m
//  YPYDemo
//
//  Created by Augus on 2021/3/5.
//

#import "NWButton.h"

@interface NWButton ()

// 实时计数的返回接口
@property (nonatomic, assign)  NSInteger countNumber;
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation NWButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    _countNumber = 10;
    return self;
}

- (void)startAnimation {
    
    if (self.timer) {
        [self stopAnimation];
    }
    
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateText) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];


}

- (void)updateText {
    
    if (self.countNumber < 0) {
        self.countNumber = 10;
        [self stopAnimation];
        return;
    }
    
    
    NSLog(@"fs_updateText %@",@(self.countNumber));
    
    [self setTitle:[NSString stringWithFormat:@"%ld",self.countNumber] forState:UIControlStateNormal];
    self.countNumber--;
}

- (void)stopAnimation {
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}



@end
