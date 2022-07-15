//
//  TestSubview.m
//  TestStingNil
//
//  Created by Augus on 2022/3/21.
//

#import "TestSubview.h"
#import "TestThreeView.h"


@interface TestSubview ()

@property (nonatomic, strong) TestThreeView *threeView;

@end

@implementation TestSubview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    [self initSubviews];
    return self;
    
}


- (void)initSubviews {
    
    self.threeView = [[TestThreeView alloc] init];
    self.threeView.frame = CGRectMake(0, 0, 10, 10);
    self.threeView.backgroundColor = UIColor.blueColor;
    [self addSubview:self.threeView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.threeView.frame = CGRectMake(5, 5, 8, 10);
//        self.frame = CGRectMake(20, 25, 60, 50);
    });
    
}

- (void)layoutSubviews {
    
    NSLog(@"%s---%d",__func__,__LINE__);
}

@end
