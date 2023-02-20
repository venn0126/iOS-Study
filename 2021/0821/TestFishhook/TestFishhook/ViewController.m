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
#import "SNTitleLeftButton.h"

#import "MyPtrace.h"

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
//    UIView *redView = [[UIView alloc] init];
//    redView.backgroundColor = UIColor.redColor;
//    CGFloat x = (self.view.bounds.size.width - 100) * 0.5;
//    redView.frame = CGRectMake(x, 100, 100, 50);
//
//    self.testView = redView;
//    [self.view addSubview:redView];
    
    
//    [self testAlphaAndBackgroundColor];
    
//    [self testAugusPopView];
    
//    [self testGradientLayer];
    
    
//    [self testLeftButton];
    
//    [self testFishHook];
    
//    [self testFishHook2];
    
    [self testFishHook3];
    

}

- (void)testLeftButton {
    
    SNTitleLeftButton *button = [[SNTitleLeftButton alloc] init];
    button.backgroundColor = UIColor.redColor;
    [button setTitle:@"听新闻调研问卷" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.greenColor forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icoland_sina_v5.png"] forState:UIControlStateNormal];
    [button sizeToFit];
    button.frame = CGRectMake(100, 100, 180, 50);
    [self.view addSubview:button];
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
    
//    self.allPopView.closeButtonBackgroundColor = UIColor.blackColor;
//    self.allPopView.leftImageBackgroundColor = UIColor.yellowColor;
    
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
    
    
    /**
     
     0x0000000102a78000：image list中第一个元素，mach-o文件地址
     0x10000C10C：mach-o-view打开的TestFishhook的的可执行文件的NSLog的偏移地址（offset）
     

     (lldb) memory read 0x0000000102a78000+0x14020
     0x102a8c020: 0c 41 a8 02 01 00 00 00 1c 43 a8 02 01 00 00 00  .A.......C......
     0x102a8c030: 00 88 bc 91 01 00 00 00 a8 57 18 93 01 00 00 00  .........W......
     2022-10-25 23:20:52.943034+0800 TestFishhook[59436:4802538] hhhh
     (lldb) memory read 0x0000000102a78000+0x14020
     0x102a8c020: 80 49 bd 91 01 00 00 00 1c 43 a8 02 01 00 00 00  .I.......C......
     0x102a8c030: 00 88 bc 91 01 00 00 00 a8 57 18 93 01 00 00 00  .........W......
     (lldb) dis -s 0x0191bd4980
     Foundation`NSLog:
         0x191bd4980 <+0>:  sub    sp, sp, #0x20             ; =0x20
         0x191bd4984 <+4>:  stp    x29, x30, [sp, #0x10]
         0x191bd4988 <+8>:  add    x29, sp, #0x10            ; =0x10
         0x191bd498c <+12>: adrp   x8, 334535
         0x191bd4990 <+16>: ldr    x8, [x8, #0xd08]
         0x191bd4994 <+20>: ldr    x8, [x8]
         0x191bd4998 <+24>: str    x8, [sp, #0x8]
         0x191bd499c <+28>: add    x8, x29, #0x10            ; =0x10
     (lldb) memory read 0x0000000102a78000+0x14020
     0x102a8c020: 4c fb a7 02 01 00 00 00 1c 43 a8 02 01 00 00 00  L........C......
     0x102a8c030: 00 88 bc 91 01 00 00 00 a8 57 18 93 01 00 00 00  .........W......
     (lldb) dis -s 0x0102a7fb4c
     TestFishhook`nwLog:
         0x102a7fb4c <+0>:  stp    x20, x19, [sp, #-0x20]!
         0x102a7fb50 <+4>:  stp    x29, x30, [sp, #0x10]
         0x102a7fb54 <+8>:  add    x29, sp, #0x10            ; =0x10
         0x102a7fb58 <+12>: nop
         0x102a7fb5c <+16>: ldr    x1, #0xfaf4               ; "stringByAppendingString:"
         0x102a7fb60 <+20>: adr    x2, #0x8a28               ; @" [rebinding log...]"
         0x102a7fb64 <+24>: nop
         0x102a7fb68 <+28>: bl     0x102a84034               ; symbol stub for: objc_msgSend
     2022-10-25 23:22:00.661540+0800 TestFishhook[59436:4802538] hook finish [rebinding log...]
     */
    
    NSLog(@"hhhh");

    
    // rebinding struct
    // 定义个结构体数组，存放最终的方法
    struct rebinding nslog;
    
    // Need rebinding string of C
    // 需要替换方法名字
    nslog.name = "NSLog";
    
    // Make system function for point to symbol,rebinding custom function in runtime
    // 自定义实现的方法指针
    nslog.replacement = nwLog;
    
    // Make system function real memory address assgin custom's function pointer
    nslog.replaced = (void*)&sys_nslog;
    
    // 把需要替换的方法放入数组
    struct rebinding rebs[1] = {nslog};
    
    // args1 rebindings[] : storage struct of rebinding array
    // args2 rebindings_nel : arrat length
    // int rebind_symbols(struct rebinding rebindings[], size_t rebindings_nel)
    //
    rebind_symbols(rebs, 1);
    NSLog(@"hook finish");
    
    
    
    self.view.backgroundColor = UIColor.linkColor;
}


- (void)testFishHook2 {
    
 
    
    // 定义rebinding结构体来声明要做的事
    struct rebinding augusPtraceStruct;
    // 需要hook的方法
    augusPtraceStruct.name = "ptrace";
    // 需要保存的函数的指针名
    augusPtraceStruct.replaced = (void *)&ptrace_pointer;
    
    // 新的实现函数
    augusPtraceStruct.replacement = ptrace_augus;
    
    
    // 替换函数所需要的数组
    struct rebinding rebs[] = {augusPtraceStruct};
    
    rebind_symbols(rebs, 1);
    
    
    // 如果是调试模式则被杀掉
    // arg1: ptrace要做的事情
    // arg2: 要操作的进程id
    // arg3/arg4: 取决于第一个参数
//    ptrace(PT_DENY_ATTACH, 0, 0, 0);
    
    
    // 防止fishhook被攻击替换
    // 不生成符号表
    
    // 获取到libsystem_kernel动态库的指针
    // 先进行符号断点，找到调用的动态库libsystem_kernel.dylib
    // 再使用bt命令，找到调用堆栈
    // 然后使用image list，找到设备上动态库的位置，/usr/lib/system/libsystem_kernel.dylib
    void * kernelHandle = dlopen("/usr/lib/system/libsystem_kernel.dylib", RTLD_LAZY);
    
    
    // 定义一个指针接受查找函数的指针
    
    int (*ptrace_p1)(int _request, pid_t _pid, caddr_t _addr, int _data);

    // 根据句柄在库中查找方法ptrace
    ptrace_p1 = dlsym(kernelHandle, "ptrace");
    
    // 调用ptrace，而且不生成符号表
    ptrace_p1(PT_DENY_ATTACH, 0, 0, 0);
    
    
    
    NSLog(@"ptrace is ending");
    
    
}


/// hook ptrace函数
/// 第一个需要一个指针存放ptrace函数的地址
/// 第二个需要一个新的函数来实现自己的需求
///


// 存放ptrace函数的指针
int (*ptrace_pointer)(int _request, pid_t _pid, caddr_t _addr, int _data);

// 新的ptrace函数
int ptrace_augus(int _request, pid_t _pid, caddr_t _addr, int _data) {
    
    if(_request != PT_DENY_ATTACH) {
        return ptrace(_request, _pid, _addr, _data);
    }
    
    // 代表什么都不做
    return 0;
}




- (void)testFishHook3 {
    
    
    
    // fishhook只允许hook系统的函数，自定义函数无法hook
    
    
//    struct rebinding fqVerify;
//    fqVerify.name = "FQ_verify";
//    fqVerify.replacement = GT_verify;
//    fqVerify.replaced = (void *)&FQ_verify;
//
//    struct rebinding rebs[1] = {fqVerify};
//    rebind_symbols(rebs, 1);
    
    
//    FQ_verify(@"tian is my wife", 2);
    
    
}

//void FQ_verify(NSString *arg1, int arg2);
//void GT_verify(NSString *arg1, int arg2) {
//
//
//    NSLog(@"gao %@ - %d",arg1, arg2);
//    FQ_verify(arg1, arg2);
//}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touch begin screen");
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
