//
//  ViewController.m
//  CADisplayLinkTest
//
//  Created by Augus on 2022/3/26.
//

#import "ViewController.h"


static CGFloat const kImageViewWidth = 100.0f;

@interface ViewController ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat dynamicImageViewY;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.lightGrayColor;
    _dynamicImageViewY = 0;
    [self createImageView];
    [self createAnimationButton];
    [self createDisplayLink];
    
//    [self createNSTimerOfRunLoop];
    
//    NSTimer *timer = [NSTimer timerWithTimeInterval:<#(NSTimeInterval)#> repeats:<#(BOOL)#> block:<#^(NSTimer * _Nonnull timer)block#>]
    
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
@end
