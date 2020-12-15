//
//  FOSScanView.m
//  BioSaferID
//
//  Created by Wei Niu on 2018/8/29.
//  Copyright © 2018年 Fosafer. All rights reserved.
//

#import "FOSScanView.h"
#import "NSTimer+Extension.h"
#import "UIView+Extension.h"

@interface FOSScanView ()

@property (nonatomic, weak) NSTimer *scanTimer;

@end

@implementation FOSScanView{
    
    UIImageView *_scanLine;
    BOOL _isUp;
    CGFloat _padding;
}

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        _isUp = NO;
        _padding = 160;
        self.fosAnmating = NO;
    
        [self setupScanLine];
        [self addTimer];
        
    }
    return self;
}

#pragma mark - set up ui


- (void)setupScanLine {
    
    if (!_scanLine) {
        
        CGFloat lineWidth = 280.f;
        CGFloat lineHeight = (lineWidth * 14) / 448;
        CGFloat lineX = (self.width - lineWidth) * 0.5;
        _scanLine = [[UIImageView alloc] initWithFrame:CGRectMake(lineX, _padding, lineWidth, lineHeight)];
        _scanLine.image = [UIImage imageNamed:@"scanLineWhite"];
        [self addSubview:_scanLine];
    }

}

-(void)repeatTime {
    CGRect rect = _scanLine.frame;
    if (_isUp == NO) {// 下降
        rect.origin.y += 1;
        if (rect.origin.y >= self.height - _padding) {
            _isUp = YES;
        }
    } else {// 上升
        rect.origin.y -= 1;
        if (rect.origin.y <= _padding) {
            _isUp = NO;
        }
    }
    _scanLine.frame = rect;
}

#pragma mark - timer

- (void)addTimer {
    __weak typeof (self)weakSelf = self;
    
    _scanTimer = [NSTimer fos_scheduledTimerWithTimeInterval:0.01 repeats:YES block:^(NSTimer *timer) {

        [weakSelf timerFire];
    }];
    
}

- (void)timerFire {
    _fosAnmating = YES;
    [self repeatTime];
}

- (void)pauseAnimation {
    _fosAnmating = NO;
    [_scanTimer setFireDate:[NSDate distantFuture]];
}

- (void)continueAnimation {
    _fosAnmating = YES;
    [_scanTimer setFireDate:[NSDate date]];
}


- (void)setFosAnmating:(BOOL)fosAnmating {
    _fosAnmating = fosAnmating;
}

- (void)stopAnimation {
    _fosAnmating = NO;
    if ([_scanTimer isValid]) {
        [_scanTimer invalidate];
        _scanTimer = nil;
    }
}


@end
