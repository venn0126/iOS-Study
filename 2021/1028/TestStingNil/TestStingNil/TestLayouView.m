//
//  TestLayouView.m
//  TestStingNil
//
//  Created by Augus on 2022/3/9.
//

#import "TestLayouView.h"
#import "TestButton.h"
#import "TestSubview.h"


@interface TestLayouView ()

@property (nonatomic, strong) TestButton *testButton;
@property (nonatomic, strong) TestSubview *testSubview;

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
    
//    _testButton = [[TestButton alloc] init];
//    _testButton.backgroundColor = UIColor.greenColor;
//    _testButton.frame = CGRectMake(25, 25, 50, 50);
//    [_testButton addTarget:self action:@selector(testButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_testButton];
    
    
    _testSubview = [[TestSubview alloc] init];
    _testSubview.backgroundColor = UIColor.greenColor;
    _testSubview.frame = CGRectMake(25, 25, 50, 50);
    [self addSubview:_testSubview];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{


        // self= 0 100 100 100
        // subview = 25 25 50 50
        
        // update target origin,origin.y -> no call
//        self.frame = CGRectMake(0, 150, 100, 100);
        
        // update target origin.x -> no call
//        self.frame = CGRectMake(50, 100, 100, 100);
                
        // update target size,size.width,size.height, call target layoutsubviews
        self.frame = CGRectMake(0, 100, 10, 10);
        
        // update target frame and same frame no call
//        self.frame = CGRectMake(0, 100, 100, 100);

        // update subview origin,origin.x,origin.y no call
//        self->_testSubview.frame = CGRectMake(25, 15, 50, 50);
                
        // update subview size, call target layoutsubviews -> subview layoutsubviews
//        self->_testSubview.frame = CGRectMake(25, 25, 50, 5);
        
        // update subview frame and same frame no call
//        self->_testSubview.frame = CGRectMake(25, 25, 50, 50);


        // target addSubview:subview call target layoutsubviews -> subview layoutsubviews
//        [self addSubview:self->_testSubview];

    });
    
    
    
}

- (void)testButtonAction:(UIButton *)sender {
    
    // update target origin,origin.y -> call target layoutsubviews -> subview layoutsubviews
//        self.frame = CGRectMake(50, 50, 100, 100);
    
    // update target origin.x -> call target layoutsubviews
//        self.frame = CGRectMake(50, 0, 100, 100);
            
    // update target size,size.width,size.height, call target layoutsubviews
//        self.frame = CGRectMake(0, 0, 10, 100);
    
    // update target frame and same frame call target layoutsubviews
//        self.frame = CGRectMake(0, 0, 100, 100);

    // update subview origin,origin.x,origin.y call subview layoutsubviews
//        self->_testButton.frame = CGRectMake(10, 20, 50, 50);
            
    // update subview size, call target layoutsubviews -> subview layoutsubviews
//        self->_testButton.frame = CGRectMake(25, 25, 20, 50);
    
    // update subview frame and same frame call subview layoutsubviews
//        self->_testButton.frame = CGRectMake(25, 25, 50, 50);


    // target addSubview:subview call target layoutsubviews -> subview layoutsubviews
//        [self addSubview:self->_testButton];

}

- (void)layoutSubviews {
    
    NSLog(@"%s---%d",__func__,__LINE__);
    
//    for (int i = 0; i < 1000 ; i++) {
//        _testButton.frame = CGRectMake(25, 25, 80, 80);
//    }
}

//- (void)setBounds:(CGRect)bounds {
// 
////    NSLog(@"%s---%d",__func__,__LINE__);
//    [super setBounds:bounds];
//    [self setNeedsLayout];
//
//
//}
//
//
//- (void)setFrame:(CGRect)frame {
////    NSLog(@"%s---%d",__func__,__LINE__);
//    [super setFrame:frame];
//    [self setNeedsLayout];
//}
@end
