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


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = UIColor.redColor;
    CGFloat x = (self.view.bounds.size.width - 100) * 0.5;
    redView.frame = CGRectMake(x, 100, 100, 50);
    [self.view addSubview:redView];
    
//    self.view.backgroundColor = UIColor.lightGrayColor;
    
    // Test popView for top
    [self showPopTop];
    // Test popView for bottom
    [self showPopBottom];
    
    [self showPopRight];
    
    [self showPopLeft];
}


- (void)showPopLeft {
    
    self.leftPopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(230, 100+25, 0, 0) text:@"请阅读并勾选以下协议Left" direction:SNAugusPopViewDirectionLeft];
    self.leftPopView.delegate = self;
    [self.view addSubview:self.leftPopView];
    
    self.leftPopView.textFont = [UIFont systemFontOfSize:10];
//    self.topPopView.verticalLabelPadding = 10;
    
    
    UIButton *showPopViewButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 400, 100, 50)];
    [showPopViewButton setTitle:@"showLeft" forState:UIControlStateNormal];
    [showPopViewButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    showPopViewButton.backgroundColor = UIColor.greenColor;
    [showPopViewButton addTarget:self action:@selector(showLeftPopViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPopViewButton];
}

- (void)showPopRight {
    
    self.rightPopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(160, 100+25, 0, 0) text:@"请阅读并勾选以下协议Right" direction:SNAugusPopViewDirectionRight];
    self.rightPopView.delegate = self;
    [self.view addSubview:self.rightPopView];
    
    self.rightPopView.textFont = [UIFont systemFontOfSize:10];
//    self.topPopView.verticalLabelPadding = 10;
    
    
    UIButton *showPopViewButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 400, 100, 50)];
    [showPopViewButton setTitle:@"showRight" forState:UIControlStateNormal];
    [showPopViewButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    showPopViewButton.backgroundColor = UIColor.greenColor;
    [showPopViewButton addTarget:self action:@selector(showRightPopViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPopViewButton];
}


- (void)showPopTop {
    
    self.topPopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(100+60, 100+70, 0, 0) text:@"请阅读并勾选以下协议Top" direction:SNAugusPopViewDirectionTop];
    self.topPopView.delegate = self;
    [self.view addSubview:self.topPopView];
    
//    self.topPopView.textFont = [UIFont systemFontOfSize:13];
//    self.topPopView.verticalLabelPadding = 10;
    
    
    UIButton *showPopViewButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 300, 100, 50)];
    [showPopViewButton setTitle:@"showTop" forState:UIControlStateNormal];
    [showPopViewButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    showPopViewButton.backgroundColor = UIColor.greenColor;
    [showPopViewButton addTarget:self action:@selector(showPopViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPopViewButton];
}


- (void)showPopBottom {
    
    
    self.bottomPopView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(100+60, 100-20, 0, 0) text:@"请阅读并勾选以下协议Bottom" direction:SNAugusPopViewDirectionBottom];
    self.bottomPopView.delegate = self;
    [self.view addSubview:self.bottomPopView];
    
//    self.bottomPopView.verticalLabelPadding = 10;
//    self.bottomPopView.textFont = [UIFont systemFontOfSize:13];

    
    UIButton *showPopViewButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 300, 120, 50)];
    [showPopViewButton setTitle:@"showBottom" forState:UIControlStateNormal];
    [showPopViewButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    showPopViewButton.backgroundColor = UIColor.linkColor;
    [showPopViewButton addTarget:self action:@selector(showPopViewBottomnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPopViewButton];
    
}


#pragma mark - Button Action


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

- (void)tapGesturePopView {
    
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
