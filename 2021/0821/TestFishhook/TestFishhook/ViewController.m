//
//  ViewController.m
//  TestFishhook
//
//  Created by Augus on 2021/8/21.
//

#import "ViewController.h"
#import "fishhook.h"

#import <dlfcn.h>
#import <mach-o/loader.h>

#import "UIView+ShakeAnimation.h"
#import "SNAugusPopView.h"

@interface ViewController ()<SNAugusPopViewDelagate>

@property (nonatomic, strong) UIView *testView;
@property (nonatomic, strong) UILabel *testLabel;
@property (nonatomic, strong) SNAugusPopView *topPopView;
@property (nonatomic, strong) SNAugusPopView *bottomPopView;

@property (nonatomic, strong) SNAugusPopView *rightPopView;
@property (nonatomic, strong) SNAugusPopView *leftPopView;

@property (nonatomic, strong) SNAugusPopView *mulLinesPopView;
@property (nonatomic, strong) SNAugusPopView *closePopView;

@property (nonatomic, strong) SNAugusPopView *leftImagePopView;
@property (nonatomic, strong) SNAugusPopView *allPopView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    self.view.backgroundColor = UIColor.linkColor;
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = UIColor.redColor;
    CGFloat x = (self.view.bounds.size.width - 100) * 0.5;
    redView.frame = CGRectMake(x, 100, 100, 50);
    
    self.testView = redView;
    [self.view addSubview:redView];
    
    
//    [self testAlphaAndBackgroundColor];
    
    [self testAugusPopView];
    
//    [self testGradientLayer];
    

}


- (void)testGradientLayer {
    
    UIView *colorView = [[UIView alloc] init];
    colorView.frame = CGRectMake(0, 0, 200, 200);
    colorView.center = CGPointMake(375/2.0, 400);
    [self.view addSubview:colorView];
        
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = colorView.bounds;
    
    gradient.colors = @[(id)[UIColor orangeColor].CGColor,(id)[UIColor redColor].CGColor];
    // gradient line from start to end
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    // gradient location area,default 0-1
    
    gradient.locations = @[@(0.0f), @(1.0f)];
//    gradient.locations = @[@(0.5f), @(1.0f)];
    [colorView.layer addSublayer:gradient];
        
}

- (void)testAugusPopView {
    
    // Test popView for top
    [self showPopTop];
    // Test popView for bottom
    [self showPopBottom];
    
    [self showPopRight];
    
    [self showPopLeft];
    
    // mul lines
    [self showPopViewMulLines];
    // close button 500
    [self showPopViewCloseButton];
    
    [self showPopViewLeftImage];
    
    [self showPopViewAll];
}

- (void)testAlphaAndBackgroundColor {
    
    UIView *view = [[UIView alloc] init];
    //red, green, blue 的值 随意填， 关键的是 alpha 要为 0
    view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
    view.frame = CGRectMake(30, 100, 200, 200);
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 10, 200, 50);
    label.text = @"White 1";
    label.textColor = UIColor.whiteColor;
//    label.backgroundColor = [UIColor blueColor];
    [view addSubview:label];
}


- (void)showPopViewAll {
    
    self.allPopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(50, 700, 0, 0) text:@"请阅读并勾选以下协议勾选以下协议All" direction:SNAugusPopViewDirectionBottom singleLine:YES closeButtonName:@"close" leftImageName:@"left" gradient:YES];
    
//    self.allPopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(50, 750, 0, 0) text:@"请阅读并勾选以下协议勾选以下协议发发现新的炼金珠女呗冲啊擦法All" direction:SNAugusPopViewDirectionBottom singleLine:NO closeButtonName:@"close" leftImageName:@"left" gradient:YES];
    
    [self.view addSubview:self.allPopView];
    
    self.allPopView.textFont = [UIFont systemFontOfSize:16];
    self.allPopView.gradientColors = @[(id)(UIColor.orangeColor.CGColor),(id)UIColor.redColor.CGColor];
    self.allPopView.gradientStartPoint = CGPointMake(1.0, 0.5);
    self.allPopView.gradientEndPoint = CGPointMake(0.0, 0.5);
    self.allPopView.gradientLocations = @[@0.5,@1.0];
    
    self.leftImagePopView.leftImageWidth = 30;
    self.leftImagePopView.leftImageHeight = 15;
    self.leftImagePopView.leftImageLabelPadding = 20;
    [self.allPopView show];
    
//    self.allPopView.textColor = UIColor.blackColor;

    
    
    UIButton *showPopViewButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 600, 130, 50)];
    [showPopViewButton setTitle:@"showAll" forState:UIControlStateNormal];
    [showPopViewButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//    showPopViewButton
    showPopViewButton.backgroundColor = UIColor.greenColor;
    [showPopViewButton addTarget:self action:@selector(showAllPopViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPopViewButton];
}

- (void)showPopViewLeftImage {
    
//    self.closePopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(50, 500, 0, 0) text:@"请阅读并勾选以下协议MulLines发现新的炼金珠女呗冲啊擦法close" direction:SNAugusPopViewDirectionBottom singleLine:NO closeButtonName:@"Close"];
    
    self.leftImagePopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(50, 580, 0, 0) text:@"请阅读并勾选以下协议LeftImage" direction:SNAugusPopViewDirectionBottom singleLine:YES leftImageName:@"left" gradient:NO];
    [self.view addSubview:self.leftImagePopView];
    [self.leftImagePopView show];
    
    self.leftImagePopView.leftImageWidth = 30;
    self.leftImagePopView.leftImageHeight = 15;
//    self.leftImagePopView.leftImageLabelPadding = 20;

    
    
    UIButton *showPopViewButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 600, 130, 50)];
    [showPopViewButton setTitle:@"showLeftImage" forState:UIControlStateNormal];
    [showPopViewButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//    showPopViewButton
    showPopViewButton.backgroundColor = UIColor.greenColor;
    [showPopViewButton addTarget:self action:@selector(showLeftImagePopViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPopViewButton];
}


- (void)showPopViewCloseButton {
    
//    self.closePopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(50, 500, 0, 0) text:@"请阅读并勾选以下协议MulLines发现新的炼金珠女呗冲啊擦法close" direction:SNAugusPopViewDirectionBottom singleLine:NO closeButtonName:@"Close"];
    
    self.closePopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(50, 480, 0, 0) text:@"请阅读并勾选以下协议SingleClose" direction:SNAugusPopViewDirectionBottom singleLine:YES closeButtonName:@"Close" gradient:NO];
    [self.view addSubview:self.closePopView];
    [self.closePopView show];
    
    
    UIButton *showPopViewButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 500, 100, 50)];
    [showPopViewButton setTitle:@"showClose" forState:UIControlStateNormal];
    [showPopViewButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    showPopViewButton.backgroundColor = UIColor.greenColor;
    [showPopViewButton addTarget:self action:@selector(showClosePopViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPopViewButton];
    
}

- (void)showPopViewMulLines {
    
    self.mulLinesPopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(30, 250, 0, 0) text:@"这就是爱你的哥呀请阅读并勾选以下协议MulLines发现新的炼金珠女呗冲啊擦法" direction:SNAugusPopViewDirectionBottom singleLine:NO gradient:NO];
    self.mulLinesPopView.mulLineWidth = 100.0;
//    self.mulLinesPopView.arrowVerticalPadding = 30.0;
    self.mulLinesPopView.textAlignment = NSTextAlignmentLeft;

    [self.view addSubview:self.mulLinesPopView];
//    self.mulLinesPopView.backgroundColor = UIColor.yellowColor;
    
    self.mulLinesPopView.borderWidth = 5.0;
    self.mulLinesPopView.borderColor = UIColor.greenColor;
    
    
    [self.mulLinesPopView show];
    
    
    UIButton *showPopViewButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 500, 100, 50)];
    [showPopViewButton setTitle:@"showMul" forState:UIControlStateNormal];
    [showPopViewButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    showPopViewButton.backgroundColor = UIColor.greenColor;
    [showPopViewButton addTarget:self action:@selector(showMulLinesPopViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPopViewButton];
    
}

- (void)showPopLeft {
    
    self.leftPopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(230, 100+25, 0, 0) text:@"请阅读并勾选以下协议Left" direction:SNAugusPopViewDirectionLeft gradient:NO];
    self.leftPopView.delegate = self;
    [self.view addSubview:self.leftPopView];
    
    self.leftPopView.textFont = [UIFont systemFontOfSize:10];
    self.leftPopView.arrowVerticalPadding = 10;
    // 255 52 179
    self.leftPopView.aBackgroundRed = 0/255.0;
    self.leftPopView.aBackgroundGreen = 191/255.0;
    self.leftPopView.aBackgroundBlue = 255/255.0;
    
//    self.leftPopView.aBackgroundShowAlpha = 0.01;
    
    
    
    UIButton *showPopViewButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 400, 100, 50)];
    [showPopViewButton setTitle:@"showLeft" forState:UIControlStateNormal];
    [showPopViewButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    showPopViewButton.backgroundColor = UIColor.greenColor;
    [showPopViewButton addTarget:self action:@selector(showLeftPopViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPopViewButton];
}

- (void)showPopRight {
    
    self.rightPopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(160, 100+25, 0, 0) text:@"请阅读并勾选以下协议Right" direction:SNAugusPopViewDirectionRight gradient:NO];
    self.rightPopView.delegate = self;
    [self.view addSubview:self.rightPopView];
    
    self.rightPopView.textFont = [UIFont systemFontOfSize:10];
    self.rightPopView.arrowVerticalPadding = 5;
    self.rightPopView.textColor = UIColor.redColor;
    
    
    UIButton *showPopViewButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 400, 100, 50)];
    [showPopViewButton setTitle:@"showRight" forState:UIControlStateNormal];
    [showPopViewButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    showPopViewButton.backgroundColor = UIColor.greenColor;
    [showPopViewButton addTarget:self action:@selector(showRightPopViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPopViewButton];
}


- (void)showPopTop {
    
    self.topPopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(160, self.testView.frame.origin.y + 60, 0, 0) text:@"请阅读并勾选以下协议Top" direction:SNAugusPopViewDirectionTop gradient:NO];
    self.topPopView.delegate = self;
    self.topPopView.textFont = [UIFont systemFontOfSize:13];
    self.topPopView.arrowHorizontalPadding = 50;
//    self.topPopView.textColor = UIColor.blueColor;
//    self.topPopView.textAlignment
    [self.view addSubview:self.topPopView];
    
//    [self.topPopView showToView:self.testView];
    
    
    
    UIButton *showPopViewButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 300, 100, 50)];
    [showPopViewButton setTitle:@"showTop" forState:UIControlStateNormal];
    [showPopViewButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    showPopViewButton.backgroundColor = UIColor.linkColor;
    [showPopViewButton addTarget:self action:@selector(showPopViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPopViewButton];
}


- (void)showPopBottom {
    
    
    self.bottomPopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(100+60, 100-20, 0, 0) text:@"请阅读并勾选以下协议Bottom" direction:SNAugusPopViewDirectionBottom gradient:YES];
    self.bottomPopView.delegate = self;
    [self.view addSubview:self.bottomPopView];
    
//    self.bottomPopView.verticalLabelPadding = 10;
    self.bottomPopView.textFont = [UIFont systemFontOfSize:16];
    
    self.bottomPopView.gradientColors = @[(id)(UIColor.orangeColor.CGColor),(id)UIColor.redColor.CGColor];
    self.bottomPopView.gradientStartPoint = CGPointMake(1.0, 0.5);
    self.bottomPopView.gradientEndPoint = CGPointMake(0.0, 0.5);
    self.bottomPopView.gradientLocations = @[@0.5,@1.0];

    
    UIButton *showPopViewButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 300, 120, 50)];
    [showPopViewButton setTitle:@"showBottom" forState:UIControlStateNormal];
    [showPopViewButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    showPopViewButton.backgroundColor = UIColor.linkColor;
    [showPopViewButton addTarget:self action:@selector(showPopViewBottomnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPopViewButton];
    
}


#pragma mark - Button Action


- (void)showAllPopViewAction {
    
    [self.allPopView show];
}

- (void)showLeftImagePopViewAction {
    
    [self.leftImagePopView show];
}

- (void)showClosePopViewAction {
    
    [self.closePopView show];
}

- (void)showMulLinesPopViewAction {
    
    [self.mulLinesPopView show];
}


- (void)showLeftPopViewAction {
    
    [self.leftPopView show];
}

- (void)showRightPopViewAction {
    
    [self.rightPopView show];
    
}

- (void)showPopViewBottomnAction:(UIButton *)sender {
    [self.bottomPopView show];
    
}


- (void)showPopViewButtonAction:(UIButton *)sender {
    
    [self.topPopView show];
}

- (void)augusPopViewClick:(SNAugusPopView *)popView {
    
    NSLog(@"vc tap respond");
    
}


- (void)testBundleOfTwoAndThree {
    
    
    UIImage *image = [UIImage imageNamed:@"icoland_sina_v51.png"];
    NSLog(@"2 Image is %@ and scale is %.2f",NSStringFromCGSize(image.size),[UIScreen mainScreen].scale);

    UIImage *testImage = [UIImage imageNamed:@"icoland_sina_v5.png"];
    NSLog(@"3 Image is %@ and scale is %.2f",NSStringFromCGSize(testImage.size),[UIScreen mainScreen].scale);

}

- (void)threeTwoSize {
    
    
    UIImage *testImage = [UIImage imageNamed:@"icoland_apple_v5"];
    
    
    UIImageView *testImageView  = [[UIImageView alloc] initWithImage:testImage];
    testImageView.frame = CGRectMake(100, 100, 34, 34);
    [testImageView sizeToFit];
    [self.view addSubview:testImageView];
    
    NSLog(@"testImage is %@ and scale is %.2f",NSStringFromCGSize(testImageView.frame.size),[UIScreen mainScreen].scale);
    
    
}


- (void)testFishHook {
    
    
    NSLog(@"hhhh");

    
    // rebinding struct
    struct rebinding nslog;
    
    // Need rebinding string of C
    nslog.name = "NSLog";
    
    // Make system function for point to symbol,rebinding custom function in runtime
    nslog.replacement = nwLog;
    
    // Make system function real memory address assgin custom's function pointer
    nslog.replaced = (void*)&sys_nslog;
    
    //
    struct rebinding rebs[1] = {nslog};
    
    // args1 rebindings[] : storage struct of rebinding array
    // args2 rebindings_nel : arrat length
    // int rebind_symbols(struct rebinding rebindings[], size_t rebindings_nel)
    //
    rebind_symbols(rebs, 1);
    
    
    
    self.view.backgroundColor = UIColor.linkColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    NSLog(@"touch begin screen");
//    [self.testLabel shakeTimes:4 speed:0.05 range:2 shakeDirection:SNAugusDirectionHorizontal];
    
    
    
//    [self.popView show];
}


// Custom function pointer
void(*sys_nslog)(NSString *format,...);
// Custom function of C
void nwLog(NSString *format,...) {
    
    format = [format stringByAppendingString:@" [rebinding log...]"];
    // Call system function
    sys_nslog(format);
}


- (UIView *)testView {
    if(!_testView) {
        _testView = [[UIView alloc] init];
        _testView.frame = CGRectMake(100, 100, 100, 50);
        _testView.backgroundColor = UIColor.blueColor;
    }
    return _testView;
}


- (UILabel *)testLabel {
    if (!_testLabel) {
        _testLabel = [[UILabel alloc] init];
        _testLabel.frame = CGRectMake(100, 100, 100, 50);
        _testLabel.text = @"请阅读并勾选下方协议";
        _testLabel.backgroundColor = UIColor.greenColor;
        [_testLabel sizeToFit];
    }
    return _testLabel;
}


@end
