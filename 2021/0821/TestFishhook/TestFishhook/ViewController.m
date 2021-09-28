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

@interface ViewController ()

@property (nonatomic, strong) UIView *testView;
@property (nonatomic, strong) UILabel *testLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    
//    [self.view addSubview:self.testView];
//    [self.view addSubview:self.testLabel];
    
    
//    SNAugusPopView *popView = [[SNAugusPopView alloc] initWithFrame:CGRectMake(100, 100, 200, 50) text:@"请阅读并勾选以下协议"];
//    [self.view addSubview:popView];
    
//    [self threeTwoSize];
    [self testBundleOfTwoAndThree];
    

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
    
    NSLog(@"touch begin screen");
    
        
    [self.testLabel shakeTimes:4 speed:0.05 range:2 shakeDirection:SNAugusDirectionHorizontal];
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
