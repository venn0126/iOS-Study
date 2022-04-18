//
//  ViewController.m
//  CADisplayLinkTest
//
//  Created by Augus on 2022/3/26.
//

#import "ViewController.h"
#import "UIColor+CustomColor.h"
#import "GTViewModel.h"
#import "GTModel.h"

static CGFloat const kImageViewWidth = 100.0f;

@interface ViewController ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat dynamicImageViewY;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) NSTimer *timer;


@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UIButton *updateData;
@property (nonatomic, strong) GTViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = UIColor.whiteColor;
    self.view.backgroundColor = UIColor.BG1;
    _dynamicImageViewY = 0;
//    [self createImageView];
//    [self createAnimationButton];
//    [self createDisplayLink];
    
    
    
//    [self createNSTimerOfRunLoop];
    
//    [self testAssetsResources];
    
    
//    [self testViewModelBase];
    
    [self testDateFormat];
    
}


- (void)testDateFormat {
        
    NSDateFormatter *formatter = [NSDateFormatter new];
    // 是否需要指定区域，否则默认是en_US
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    [formatter setLocalizedDateFormatFromTemplate:@"jj:mm:ss"];
    NSLog(@"%@: 'jj:mm' => '%@' ('%@')", formatter.locale.localeIdentifier, formatter.dateFormat, [formatter stringFromDate:[NSDate date]]);
    formatter.dateFormat = [NSString stringWithFormat:@"yyyy-MM-dd %@",formatter.dateFormat];
    NSLog(@"last result %@",[formatter stringFromDate:[NSDate date]]);

}


- (void)testViewModelBase {
    
    [self.view addSubview:self.label1];
    self.label1.frame = CGRectMake(100, 100, 100, 50);
    
    [self.view addSubview:self.label2];
    self.label2.frame = CGRectMake(100, 150, 100, 50);
    
    [self.view addSubview:self.updateData];
    self.updateData.frame = CGRectMake(100, 200, 100, 50);
    
    if (!_viewModel) {
        
        _viewModel = [[GTViewModel alloc] initWithObserverName:@"GTViewModel"];
        [_viewModel loadData];
        [_viewModel bindDataWithBlock:^(id  _Nullable result, NSError * _Nullable error) {
            
            if ([result isKindOfClass:[GTModel class]]) {
                GTModel *model = (GTModel *)result;
                self->_label1.text = model.newsTitle;
            }
        }];
    }
    
    
}

- (void)updateDataAction:(UIButton *)sender {
    
    if (_viewModel) {
        [_viewModel loadData];
    }
    
}


- (void)testNilAndKind {
    
    NSString *testNil = nil;
    NSString *testNull = @"";
    NSDictionary *dict = [[NSDictionary alloc] init];
    [self reportEgifPostReport:dict];
    
}


- (void)reportEgifPostReport:(NSString *)report {
    
//    if (![report isKindOfClass:[NSString class]] || report.length == 0) {
    if (report.length == 0 || ![report isKindOfClass:[NSString class]] ) {

        NSLog(@"it is bad");
        return;
    }
    
    NSLog(@"it is ok");
}


- (void)testAssetsResources {
    
    
    [self.view addSubview:self.imageView];
    self.imageView.frame = CGRectMake(100, 100, 200, 200);
    CFTimeInterval startTime = CACurrentMediaTime();
//    for (int i = 0; i < 10000; i++) {
        self.imageView.image = [UIImage imageNamed:@"ico_kongbaifx_v5"];
//    }
    
    NSLog(@"finish time is %.2f",CACurrentMediaTime() - startTime);
    
    /**
     
     typedef NS_ENUM(NSInteger, UIUserInterfaceStyle) {
         UIUserInterfaceStyleUnspecified,
         UIUserInterfaceStyleLight,
         UIUserInterfaceStyleDark,
     } API_AVAILABLE(tvos(10.0)) API_AVAILABLE(ios(12.0)) API_UNAVAILABLE(watchos);
     */
    
    // get current  user interfacestyle
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            
            // the style is dark
            NSLog(@"UIUserInterfaceStyleDark");
            
        } else if(self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight){
            // the style is light
            NSLog(@"UIUserInterfaceStyleLight");

        } else {
            // the style is unspecified
            NSLog(@"UIUserInterfaceStyleUnspecified");

        }
    } else {
        // Fallback on earlier versions
        NSLog(@"UIUserInterfaceStyleUnspecified<12");

    }
    
        
    // 在单个页面禁用深色模式
//    if (@available(iOS 13.0, *)) {
//        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//    } else {
//        // Fallback on earlier versions
//    }
//    
//    // 在单个页面禁用浅色模式
//    if (@available(iOS 13.0, *)) {
//        self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
//    } else {
//        // Fallback on earlier versions
//    }
}


- (void)createAnimationButton {
    
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _startButton.frame = CGRectMake(200, 200, 100, 100);
    [_startButton setTitle:@"start" forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(pauseAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startButton];

}

- (void)createImageView {
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kImageViewWidth, kImageViewWidth)];
    _imageView.image = [UIImage imageNamed:@"kobe0"];
    [self.view addSubview:_imageView];
}


#pragma mark - CADisplayLink

/// 创建定时器实例
- (void)createDisplayLink {
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(startAnimation:)];
//    _displayLink.paused = YES;
    _displayLink.frameInterval = 2;
    NSLog(@"0--targetTimestamp:%f,timestamp:%f", _displayLink.targetTimestamp,_displayLink.timestamp);

    [_displayLink  addToRunLoop:[NSRunLoop currentRunLoop]
                      forMode:NSRunLoopCommonModes];
    NSLog(@"1--targetTimestamp:%f,timestamp:%f", _displayLink.targetTimestamp,_displayLink.timestamp);

    
    
    NSInteger currentFPS = (NSInteger)ceil(1.0 / _displayLink.duration);
    if (@available(iOS 15.0, *)) {
        _displayLink.preferredFrameRateRange = CAFrameRateRangeMake(10.0, currentFPS, 0.0);
    } else {
        // Fallback on earlier versions
    }
    
}


/// 定时器的回调方法
/// @param sender 定时器的实例对象
- (void)startAnimation:(CADisplayLink *)sender {
    
    NSLog(@"2--targetTimestamp:%f,timestamp:%f", sender.targetTimestamp,sender.timestamp);
    _dynamicImageViewY++;
    if (_dynamicImageViewY == self.view.frame.size.height - kImageViewWidth) {
        _dynamicImageViewY = 0;
    }
    
    self.imageView.frame = CGRectMake(0, _dynamicImageViewY, kImageViewWidth, kImageViewWidth);
    
}


/// 暂停动画
- (void)pauseAnimation{
    
    _displayLink.paused = !self.displayLink.paused;
    if (_displayLink.paused) {
        [_startButton setTitle:@"start" forState:UIControlStateNormal];
    } else {
        [_startButton setTitle:@"pause" forState:UIControlStateNormal];
    }
}


/// 销毁计数器
- (void)stopDisplayLink {
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
}

/*

#pragma mark - NSTimer

- (void)createNSTimerOfRunLoop {
    
    _timer = [NSTimer timerWithTimeInterval:2 repeats:NO block:^(NSTimer * _Nonnull timer) {
       
        NSLog(@"timer run");
    }];
    
    // 关于runLoop
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:self->_timer forMode:NSRunLoopCommonModes];
        [runLoop run];
    });
}


- (void)createNSTimerOfRunLoopMode {
    
    
    _timer = [NSTimer timerWithTimeInterval:2 repeats:NO block:^(NSTimer * _Nonnull timer) {
       
        NSLog(@"timer run");
    }];
    
    // 关于runLoop mode
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:self->_timer forMode:UITrackingRunLoopMode];
        [runLoop run];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"_timer is %@",@([_timer isValid]));
}
 */


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)label1 {
    
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.textColor = UIColor.blueColor;
        _label1.backgroundColor = UIColor.greenColor;
        [_label1 sizeToFit];
    }
    return _label1;
}

- (UILabel *)label2 {
    
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.textColor = UIColor.redColor;
        _label2.backgroundColor = UIColor.whiteColor;
        [_label2 sizeToFit];
    }
    return _label2;
}

- (UIButton *)updateData {
    if (!_updateData) {
        _updateData = [UIButton buttonWithType:UIButtonTypeCustom];
        [_updateData setTitle:@"UpdateData" forState:UIControlStateNormal];
        [_updateData setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_updateData addTarget:self action:@selector(updateDataAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _updateData;
}
@end
