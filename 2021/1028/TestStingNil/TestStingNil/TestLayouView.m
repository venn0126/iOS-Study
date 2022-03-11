//
//  TestLayouView.m
//  TestStingNil
//
//  Created by Augus on 2022/3/9.
//

#import "TestLayouView.h"


@interface TestLayouView ()

@property (nonatomic, strong) UIButton *testButton;

@end

@implementation TestLayouView

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
    
    self.backgroundColor = UIColor.redColor;
    [self initSubviews];
    
    
    return self;
}


- (void)initSubviews {
    
    _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _testButton.backgroundColor = UIColor.greenColor;
    [self addSubview:_testButton];
    
    _testButton.frame = CGRectMake(25, 25, 50, 50);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{


//        self.frame = CGRectMake(0, 0, 100, 100);
//        _testButton.frame = CGRectMake(10, 20, 50, 50);
        
        
        [self addSubview:self->_testButton];

    });
    
    
    
}

- (void)layoutSubviews {
    
//    _testButton.frame =
    NSLog(@"%s---%d",__func__,__LINE__);
    
//    for (int i = 0; i < 1000 ; i++) {
//        _testButton.frame = CGRectMake(25, 25, 80, 80);
//    }
}

@end
