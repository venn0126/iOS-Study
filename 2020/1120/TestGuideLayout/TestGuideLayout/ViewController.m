//
//  ViewController.m
//  TestGuideLayout
//
//  Created by Augus on 2020/11/20.
//

#import "ViewController.h"
#import <objc/runtime.h>
#include <CommonCrypto/CommonHMAC.h>
#import <CoreText/CoreText.h>
#import "GMObjC.h"
#import "DYFCryptoUtils.h"
#import "FOSBottomView.h"
#import "FOSLoadingView.h"
#import "FSCircleView.h"
#import "FSRCAnimation.h"
#import "FSRectScale.h"
#import "FSProcessView.h"
#import "FSProcessBarView.h"
#import "FSInputObject.h"

static NSString * kSM2PubKey = @"045A5683F614CC028E6E56B004229E8E399D0355D493D715797650C1BE8B5B4CFB570ED3D48044162AFF114DCA8938FF1F83C9C25CC4EC34F8874FBC6FEA57FD07";

static NSString * kSM2PriKey = @"E82C6B1BA817741A9E093CA5BA70421DC00AF43B659B4C250C0C03052B603F00";
//弧度转角度
#define Radians_To_Degrees(radians) ((radians) * (180.0 / M_PI))
//角度转弧度
#define Degrees_To_Radians(angle) ((angle) / 180.0 * M_PI)


//// 是否为横屏的宏
//#define IS_LANDSCAPE (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
//
//// 根据横屏竖屏取屏幕宽高
//#define SCREEN_WIDTH (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
//#define SCREEN_HEIGHT (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
//
//// 根据屏幕尺寸进行缩放
//static inline NSInteger UIAdapter (float x){
//    CGFloat scale = 414 / SCREEN_WIDTH; // 因为视觉稿是 iphone6P 是 414 宽度
//    return (NSInteger)x /scale;
//}
//
//static inline CGRect UIRectAdapter(x, y, width, height){
//    return CGRectMake(UIAdapter(x), UIAdapter(y), UIAdapter(width), UIAdapter(height));
//}
//
//// 暴露给外部调用
//#define UI(x) UIAdapter(x)
//#define UIRect(x,y,width,height) UIRectAdapter(x,y,width,height)


@interface ViewController ()<CAAnimationDelegate>


@property (nonatomic, copy) NSString *ydj;
@property (nonatomic, strong) UILabel *showLabel;

@property (nonatomic, strong) NSTimer *fosTimer;

@property (nonatomic, strong) CALayer *myLayer;
@property (nonatomic, strong) UIView *myView;

@property (nonatomic, copy) NSString *gPwd;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) FOSBottomView *bottom;

@property (nonatomic, strong) UIActivityIndicatorView *juhua;


@property (nonatomic, strong) FSCircleView *circleView;

@property (nonatomic, strong) FSProcessView *progress;

@property (nonatomic, strong) CADisplayLink *playLink;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, copy) NSMutableSet *dataArray;

@property (nonatomic, strong) FSProcessBarView *barView;







@end

@implementation ViewController{
    
    NSInteger _count;
    BOOL _isPresent;
    UISlider *_slider;
    NSString *_base;
    FSInputObject *_inputObj;
    UITextField *_textField;
    CAShapeLayer *_progressLayer;
    UIButton *_recordButton;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    self.progress = [[FSProcessView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
//    [self.view addSubview:self.progress];

//    [self.playLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
//    _barView = [[FSProcessBarView alloc] initWithFrame:CGRectMake(50, 150, 300, 300)];
//    [self.view addSubview:_barView];
    
    

    
    

//    self.gPwd = @"123456";
//    [self test_sm2];
//    [self testSM2];

    
    
//    self.myLayer = [CALayer layer];
//    self.myLayer.frame = CGRectMake(0, 0, 100, 100);
//    self.myLayer.position = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
//    self.myLayer.backgroundColor = UIColor.redColor.CGColor;
//    [self.view.layer addSublayer:self.myLayer];
    
//    [self myView];
    
    
//    [self initSubviews];
    
//    [self testAES];
    
//    [self testDES];
    
//    [self testAnmaiton];
    
    
//    for (int i = 0; i < 10; i++) {
//        NSLog(@"----%d",arc4random() % 2);
//    }
    
//    [self test_activityIndicatorView];
    
    
//    FOSLoadingView *load = [[FOSLoadingView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//    [self.view addSubview:load];
//
//    [load fos_startLoading];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//
//        [load fos_stopLoading];
//    });
    
//
//    self.circleView = [[FSCircleView alloc] initWithFrame:CGRectMake(50, 200, 150, 150)];
//    [self.view addSubview:self.circleView];
        
//    [circleView setProgress:1/3];
    
//    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"liveness_mask"].CGImage);
    
//    self.view.backgroundColor = UIColor.blackColor;
//
//
//    FSRectScale *scale = [[FSRectScale alloc] initWithFrame:CGRectZero];
//    [self.view addSubview:scale];
////
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [scale rs_startAnimation];
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//
//            [scale rs_stopAnimation:^(BOOL flag) {
//
//                NSLog(@"rs_stopAnimation---");
//                FSRCAnimation *rc = [[FSRCAnimation alloc] initWithFrame:self.view.bounds];
//                [self.view addSubview:rc];
//                [rc fos_startAnmaiton];
//
//            }];
//
//        });
//
//    });
    
    
//    int a = 0;
//    int b = 0;
//
//    int c = a++;
//    int d = ++b;
//
//    NSLog(@"--%d--%d---%d-%d",a,c,b,d);
    // 1-0 a c
    // 1-1 b d
 
    
//    [self drawshanRect];
    
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(50, 50, 100, 30);
//    label.text = @"12345678";
//    label.font = [UIFont systemFontOfSize:17];
//    [self.view addSubview:label];
//
//    NSLog(@"%f",label.font.pointSize);
    
    
    [self addGenesture];
    

}

- (void)addGenesture {
    
    
    // init button
    
    _recordButton = [[UIButton alloc] init];
    _recordButton.frame = CGRectMake(100, 200, 100, 100);
    [_recordButton setTitle:@"录音" forState:UIControlStateNormal];
    _recordButton.backgroundColor = UIColor.redColor;
    [self.view addSubview:_recordButton];
    
    
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.view addGestureRecognizer:press];
    
}

- (void)longPress:(UILongPressGestureRecognizer *)ges {
    
    if (ges.state == UIGestureRecognizerStateBegan) {
        NSLog(@"long begin------");
    }else if(ges.state == UIGestureRecognizerStateEnded){
        NSLog(@"long end-------");
        return;
    }
    
    CGPoint point = [ges locationInView:_recordButton];
    if (point.y >= 0) {
        NSLog(@"down down");
        //
        
    }else {
        NSLog(@"up up");
    }
}

- (void)test_ibiremeProgress {
    
    _progressLayer = [CAShapeLayer layer];
    CGFloat w = 150;
    CGFloat offset = 10;
    _progressLayer.frame = CGRectMake(100, 200, w, w);
    _progressLayer.cornerRadius = w *
    0.5;
    _progressLayer.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(_progressLayer.bounds, offset, offset) cornerRadius:(w / 2 - offset)];
    _progressLayer.path = path.CGPath;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeColor = [UIColor redColor].CGColor;
    _progressLayer.lineWidth = 15;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd = 0;
//    _progressLayer.hidden = YES;
    [self.view.layer addSublayer:_progressLayer];
}


- (void)test_overrideAccessView {
    
    //    _inputObj = [[FSInputObject alloc] initWithFrame:CGRectMake(200, 250, 100, 100)];
    //    _inputObj.backgroundColor = [UIColor redColor];
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = UIColor.greenColor;
    //    _inputObj.inputAccessoryView = _textField;
    //    [self.view addSubview:_inputObj];
        [self.view addSubview:_textField];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputObjectTextDidChange:) name:kInputObjectTextDidChangeNotification object:nil];
        
        
       // Register keyboard events
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _textField.frame = CGRectMake(0, CGRectGetMaxY(self.view.bounds), CGRectGetWidth(self.view.bounds), 50);

}

- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    UIViewAnimationCurve curve = [[userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    CGFloat duration = [[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboardFrame = [[userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrame = [self.view convertRect:keyboardFrame toView:self.view];

    [UIView animateWithDuration:duration delay:0.0f options:(UIViewAnimationOptions)curve animations:^{
        CGRect textFieldFrame = _textField.frame;
        textFieldFrame.origin.y = keyboardFrame.origin.y - CGRectGetHeight(textFieldFrame);
        _textField.frame = textFieldFrame;
    }completion:nil];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    UIViewAnimationCurve curve = [[userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    CGFloat duration = [[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration delay:0.0f options:(UIViewAnimationOptions)curve animations:^{
        _textField.frame = CGRectMake(0, CGRectGetMaxY(self.view.bounds), CGRectGetWidth(self.view.bounds), 50);
    }completion:nil];
}


- (void)inputObjectTextDidChange:(NSNotification *)notification {
    
    _textField.text = ((FSInputObject *)(notification.object)).text;
}




- (void)testSM2 {
    NSString *testStr = @"{\"sessionId\":\"1234\",\"customerNo\":\"zhaohai1234\",\"requestContent\":\"打开他行账户\",\"requestType\":\"text\"}";
        
        NSData *testData = [testStr dataUsingEncoding:NSUTF8StringEncoding];
        NSData *enc0 = [GMSm2Utils encryptData:testData publicKey:kSM2PubKey];


       // NSData *asn1dec = [GMSm2Utils asn1EncodeWithC1C3C2Data:enc0];
        NSString *base64EnciOs = [enc0 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        NSLog(@"base64EncIOS:%@", base64EnciOs);
    //    NSLog(@"enc0---%@",asn1enc);
        
       // NSData *asn1enc = [GMSm2Utils asn1DecodeToC1C3C2Data:asn1dec];
        
        //NSString  *base64 = [asn1dec base64EncodedStringWithOptions:0];
       // NSLog(@"enc0---%@",base64);
        
//        NSString *javaBase64 = @"MIHHAiAdE8u3mJh2KEtqjToGOUHAybAeVhapNIBQZX88j4+EmQIhAN1ugxnu0x4JahdfIznFYsGzhQQjjrbswOKWTv8ZYkpBBCB8YE012ol6ccFTVhMaMwJ4MLmobdm9Nt6EcBWndtxymAReS7GF6CYaU5q1JN0CYE0pvNlhE5wOjg5xlLzlhGITDnRRuQaeuNkWTKwImkrF1GjbG8x3E28XI2JBcJcvEvqVsI0V6RShVmrLKa8giHjwNRUcLVSvXO/QcnT4KI7cQA==";
    NSString *javaBase64 = @"MIH7AiA35Rvi+KlPA4LDD1sL8bup1ofpr2PmC+rWD22UOBeRzgIgf096MiLHc43thsh4RNFxCLZUzEgXETcg8kucMcGJTVsEIJOyP6Gq99wkDI4ju4LcWXc/y2jYVTTw7iI/nn7hyFMhBIGSm8ZnAj3yaNqrTPYEKzvv2XT1s54ppLVuGbbareq2QZQ/W0hvHP3mVQPBJFPpOZQRofyTLZmJMt0wwiAg3dyu7AbfxZwDryMqUx1zF/sxCteqLgOkzoHFTNpAFeqgVe70unXqfBAPq+mQxZEyDrQTEguzsOG0b8y0bqPmHp9d5PnvAqRX3ei0JeaURYyWjU+4s6E=";
        
        NSData *javaEncData = [[NSData alloc] initWithBase64EncodedString:javaBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        NSData *javaDecData = [GMSm2Utils decryptToData:javaEncData privateKey:kSM2PriKey];
        NSString *javaResult = [[NSString alloc] initWithData:javaDecData encoding:NSUTF8StringEncoding];
        NSLog(@"javaResult----%@", javaResult);
}

- (void)drawshanRect {

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 1.0;
    //圆环的颜色
//    layer.strokeColor = [UIColor clearColor].CGColor;
    //背景填充色 183 204 229
    layer.fillColor = [UIColor colorWithRed:183/255.0 green:204/255.0 blue:229/225.0 alpha:0.4].CGColor;
    CGFloat radius = 288 * 0.5;
    //按照顺时针方向
    
    
    //初始化一个路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:radius startAngle:(1.2 * M_PI) endAngle:1.8 * M_PI clockwise:YES];
    
    layer.path = [path CGPath];
    [self.view.layer addSublayer:layer];
    
}

- (void)changeProgress:(UISlider *)sender {

//    self.progress.progress = (sender.value - sender.minimumValue) / (sender.maximumValue - sender.minimumValue);
    
    _barView.progress = (sender.value - sender.minimumValue) / (sender.maximumValue - sender.minimumValue);
}



- (void)playLinkAction:(CADisplayLink *)sender {
    // 1/60
    
    // 1s 1/3
//    CFTimeInterval = CACurrentMediaTime();
//    CFTimeInterval time = 1.0f;
//    NSLog(@"time");
    
    self.progress.progress += 1/100.0f;
    // 保留两位小数
    
    
    if (self.playLink.paused) {
        self.playLink.paused = NO;
    }
    
    NSString *pro = [NSString stringWithFormat:@"%.2f",self.progress.progress];
    if ([pro isEqualToString:_base]) {
        self.playLink.paused = YES;
        if ([_base isEqualToString:@"0.33"]) {
            _base = @"0.66";
        }else {
            _base = @"1.00";

        }
        
        if ([pro isEqualToString:@"1.00"]) {
            NSLog(@"stop---");
            [self stopLink];
        }
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    _progressLayer.strokeEnd += 0.1;
//    [self.progress startProcessAnimation];
    [self.barView startProcessAnimation];
    
//    [self startLink];
    
//    [self batchRequestConfig];
    
    
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:1.0];
//    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
//    self.myLayer.position = [[touches anyObject] locationInView:self.view];
//
//    [CATransaction commit];
    
    
//    if (!_isPresent) {
//        [self fos_showView];
//    }else {
//        [self fos_dismissView];
//    }
    
//    [_bottom fosStartAnimation];
    

    
    
    
//    self.progress.progress += 1/3.0;
    
    [_textField becomeFirstResponder];
    


    
}

- (void)startLink {
    if (self.playLink) {
        self.playLink.paused = NO;
    }
}

- (void)stopLink {
    if (self.playLink) {
        self.playLink.paused = YES;
        [self.playLink invalidate];
        self.playLink = nil;
    }
}


- (void)test_rectToCircle {
    
    
    /* 放大缩小 */
    
    // 设定为缩放
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    // 动画选项设定
    animation.duration = 1.5; // 动画持续时间
    animation.repeatCount = MAXFLOAT; // 重复次数
    animation.values = @[@0.5, @0.6, @0.7, @0.8, @0.9, @1, @0.9, @0.8, @0.7, @0.6, @0.5];
    animation.additive = YES;
    animation.removedOnCompletion = NO;
    
    CALayer *rectLayer = [CALayer layer];
    rectLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"detect_rect_scale"].CGImage);
    // 594 600
    rectLayer.frame = CGRectMake(0, 0, 150, 150);
    rectLayer.position = self.view.layer.position;
    
    [rectLayer addAnimation:animation forKey:@""];
    [self.view.layer addSublayer:rectLayer];

}



- (void)testClockReverse {
    
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"face_liveness_mask"].CGImage);
    
    CFTimeInterval time = 1;
    CALayer *outLayer = [CALayer layer];
    outLayer.frame = CGRectMake(100, 100, 160, 160);
    outLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"dropdown_icon"].CGImage);
    
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basic.fromValue = [NSNumber numberWithFloat:0.f];
    basic.toValue = [NSNumber numberWithFloat:M_PI * 2];
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    basic.duration = time;
    basic.fillMode = kCAFillModeForwards;
    basic.removedOnCompletion = NO; //动画后是否回到最初状态（配合kCAFillModeForwards使用）
    basic.repeatCount = MAXFLOAT;
    
    [outLayer addAnimation:basic forKey:nil];
    
    
    CALayer *interLayer = [CALayer layer];
    interLayer.frame = CGRectMake(100, 300, 160, 160);
    interLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"dropdown_icon"].CGImage);
    
    CABasicAnimation *basic1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basic1.fromValue = [NSNumber numberWithFloat:M_PI * 2];
    basic1.toValue = [NSNumber numberWithFloat:0.f];
    basic1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    basic1.duration = time;
    basic1.fillMode = kCAFillModeForwards;
    basic1.removedOnCompletion = NO; //动画后是否回到最初状态（配合kCAFillModeForwards使用）
    basic1.repeatCount = MAXFLOAT;
    
    [interLayer addAnimation:basic1 forKey:nil];
    
    [self.view.layer addSublayer:outLayer];
    [self.view.layer addSublayer:interLayer];
}

/**
 
 import UIKit

 @IBDesignable
 class SpinnerView : UIView {

     override var layer: CAShapeLayer {
         get {
             return super.layer as! CAShapeLayer
         }
     }

     override class var layerClass: AnyClass {
         return CAShapeLayer.self
     }

     override func layoutSubviews() {
         super.layoutSubviews()
         layer.fillColor = nil
         layer.strokeColor = UIColor.black.cgColor
         layer.lineWidth = 3
         setPath()
     }

     override func didMoveToWindow() {
         animate()
     }

     private func setPath() {
         layer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: layer.lineWidth / 2, dy: layer.lineWidth / 2)).cgPath
     }

     struct Pose {
         let secondsSincePriorPose: CFTimeInterval
         let start: CGFloat
         let length: CGFloat
         init(_ secondsSincePriorPose: CFTimeInterval, _ start: CGFloat, _ length: CGFloat) {
             self.secondsSincePriorPose = secondsSincePriorPose
             self.start = start
             self.length = length
         }
     }

     class var poses: [Pose] {
         get {
             return [
                 Pose(0.0, 0.000, 0.7),
                 Pose(0.6, 0.500, 0.5),
                 Pose(0.6, 1.000, 0.3),
                 Pose(0.6, 1.500, 0.1),
                 Pose(0.2, 1.875, 0.1),
                 Pose(0.2, 2.250, 0.3),
                 Pose(0.2, 2.625, 0.5),
                 Pose(0.2, 3.000, 0.7),
             ]
         }
     }

     func animate() {
         var time: CFTimeInterval = 0
         var times = [CFTimeInterval]()
         var start: CGFloat = 0
         var rotations = [CGFloat]()
         var strokeEnds = [CGFloat]()

         let poses = type(of: self).poses
         let totalSeconds = poses.reduce(0) { $0 + $1.secondsSincePriorPose }

         for pose in poses {
             time += pose.secondsSincePriorPose
             times.append(time / totalSeconds)
             start = pose.start
             rotations.append(start * 2 * .pi)
             strokeEnds.append(pose.length)
         }

         times.append(times.last!)
         rotations.append(rotations[0])
         strokeEnds.append(strokeEnds[0])

         animateKeyPath(keyPath: "strokeEnd", duration: totalSeconds, times: times, values: strokeEnds)
         animateKeyPath(keyPath: "transform.rotation", duration: totalSeconds, times: times, values: rotations)

         animateStrokeHueWithDuration(duration: totalSeconds * 5)
     }

     func animateKeyPath(keyPath: String, duration: CFTimeInterval, times: [CFTimeInterval], values: [CGFloat]) {
         let animation = CAKeyframeAnimation(keyPath: keyPath)
         animation.keyTimes = times as [NSNumber]?
         animation.values = values
         animation.calculationMode = .linear
         animation.duration = duration
         animation.repeatCount = Float.infinity
         layer.add(animation, forKey: animation.keyPath)
     }

     func animateStrokeHueWithDuration(duration: CFTimeInterval) {
         let count = 36
         let animation = CAKeyframeAnimation(keyPath: "strokeColor")
         animation.keyTimes = (0 ... count).map { NSNumber(value: CFTimeInterval($0) / CFTimeInterval(count)) }
         animation.values = (0 ... count).map {
             UIColor(hue: CGFloat($0) / CGFloat(count), saturation: 1, brightness: 1, alpha: 1).cgColor
         }
         animation.duration = duration
         animation.calculationMode = .linear
         animation.repeatCount = Float.infinity
         layer.add(animation, forKey: animation.keyPath)
     }

 }
 */


- (void)test_activityIndicatorView {
    
    [self juhua];
    
    [self.juhua.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.juhua.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;

    [self.juhua startAnimating];
    
}

- (void)testAnmaiton {
    
    
    _bottom = [[FOSBottomView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 300, self.view.bounds.size.width, 300)];
    _bottom.fosDuration = 0.9f;
    
    [self.view addSubview:_bottom];
    
}


- (void)testAES {
    
    
    NSString *appSecret = @"13478f53794c4091b487bef61f053161";
    NSString *md5Key = [DYFCryptoUtils MD5EncodedString:appSecret];
    NSLog(@"md5---%@",md5Key);
    
    // key 123
    NSString *text = [NSString stringWithFormat:@"%@",@"123"];
    
    NSString *enc = [DYFCryptoUtils AESEncrypt:text key:text];
    NSLog(@"enc--%@",enc);
    
    
    NSString *enc1 = [DYFCryptoUtils AES128Encrypt:text key:text];
    NSLog(@"enc1---%@",enc1);
    
    NSString *dec = [DYFCryptoUtils AESDecrypt:enc key:md5Key];
    NSLog(@"dec---%@",dec);
    
    
    
    
}


- (void)testDES {
    
    
    NSString *appSecret = @"13478f53794c4091b487bef61f053161";
    NSString *md5Key = [DYFCryptoUtils MD5EncodedString:appSecret];
    NSLog(@"md5---%@",md5Key);
    
    NSString *enc = [DYFCryptoUtils DESEncrypt:@"123" key:@"123"];
    NSLog(@"des enc--%@",enc);
    
    
    NSString *dec = [DYFCryptoUtils DESDecrypt:enc key:md5Key];
    NSLog(@"dec---%@",dec);
    
}


- (void)initSubviews {
    
    [self imageView];
    
    [self.imageView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.imageView.heightAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    
    [self.imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
    [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    
}

// sm2 加解密及 ASN1 编码解码
- (void)test_sm2 {
    
    
    
    NSString *testStr = @"{\"sessionId\":\"1234\",\"customerNo\":\"123456\",\"requestContent\":\"打开他行账户\",\"requestType\":\"text\"}";
    
    NSData *testData = [testStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *enc0 = [GMSm2Utils encryptData:testData publicKey:kSM2PubKey];

    NSData *asn1dec = [GMSm2Utils asn1DecodeToC1C3C2Data:enc0];
//    NSLog(@"enc0---%@",asn1enc);
    
//    NSData *asn1enc = [GMSm2Utils asn1DecodeToC1C3C2Data:asn1dec];
    
    NSString  *base64 = [asn1dec base64EncodedStringWithOptions:0];
    NSLog(@"enc0---%@",base64);
    
    NSString *en1 = @"BMwGpoyPq72AKoUOCcjs/HJ4VGKGbdCpPahgafm7Bf/VDkrRMc8/fQadvv2lv0wznJoIyo2OSRTfyFLwujZyqDng6AZqw6PBLkx4FA2U+F5ZxJmGdca2Gp7oLdN1OHWzaAZvbOuFGbwojNMLPdVjjcgLzKBkEBbJUQkVLZrQ7GCJZddoKFwE8wV25U+BYFDdadOZTbUxcUPYRv/dWLy5pTrcwn+cimcfck/zyGSG0vqCqkP1oX/69P5Y";
    
    // asn1 encode or decode
    
    NSString *dec1 = [GMSm2Utils asn1EncodeWithC1C3C2:en1];
    
    //
    NSString *asDec1 = [GMSm2Utils decryptToText:dec1 privateKey:kSM2PriKey];
    NSLog(@"asdec1--%@",dec1);

    
    /*
     BMwGpoyPq72AKoUOCcjs/HJ4VGKGbdCpPahgafm7Bf/VDkrRMc8/fQadvv2lv0wznJoIyo2OSRTfyFLwujZyqDng6AZqw6PBLkx4FA2U+F5ZxJmGdca2Gp7oLdN1OHWzaAZvbOuFGbwojNMLPdVjjcgLzKBkEBbJUQkVLZrQ7GCJZddoKFwE8wV25U+BYFDdadOZTbUxcUPYRv/dWLy5pTrcwn+cimcfck/zyGSG0vqCqkP1oX/69P5Y
     
     O0GsOGaIw5V+QirjuCnVGx/09DdPFxENxINcG27sIEquccDMB9g1dO+uYmuq0JdHstvsHL5+5jK1b3c1v4GzY4uiiAE4a4MKstICYSN5QJQqe3ub91HLwOShIuz4D5Z7cVFmUZL84o75r6aJCm9WYHHw0YU1fMGkCV0ugOFvo5Bj7XVtCm36/PDJoYnWYCCkqlZgZOladNiAVIEdFQKZhGxGYweARw5SkBkRTMdQr5GH2MId/aagLtf6TLiKlW0Mn3qtH3w=
     
     */
    // 生成一对新的公私钥
    NSArray *keyPair = [GMSm2Utils createKeyPair];
    NSString *pubKey = keyPair[0]; // 测试用 04 开头公钥，Hex 编码格式
    NSLog(@"pub---%@",pubKey);
    NSString *priKey = keyPair[1]; // 测试用私钥，Hex 编码格式
    NSLog(@"pri---%@",priKey);

    
    NSString *plaintext = self.gPwd; // 明文原文 123456;
    NSString *plainHex = [GMUtils stringToHex:plaintext]; // 明文 123456 的 Hex 编码格式 313233343536
    NSData *plainData = [self.gPwd dataUsingEncoding:NSUTF8StringEncoding]; // 明文 123456 的 NSData 格式
    
    // sm2 加密，依次是普通明文，Hex 格式明文，NSData 格式明文
    NSString *enResult1 = [GMSm2Utils encryptText:plaintext publicKey:pubKey]; // 加密普通字符串
    NSString *enResult2 = [GMSm2Utils encryptHex:plainHex publicKey:pubKey]; // 加密 Hex 编码格式字符串
    NSData *enResult3 = [GMSm2Utils encryptData:plainData publicKey:pubKey]; // 加密 NSData 类型数据
    
    // sm2 解密
    NSString *deResult1 = [GMSm2Utils decryptToText:enResult1 privateKey:priKey]; // 解密为普通字符串明文
    NSString *deResult2 = [GMSm2Utils decryptToHex:enResult2 privateKey:priKey]; // 解密为 Hex 格式明文
    NSData *deResult3 = [GMSm2Utils decryptToData:enResult3 privateKey:priKey]; // 解密为 NSData 格式明文
    
    // 判断 sm2 加解密结果
    if ([deResult1 isEqualToString:plaintext] || [deResult2 isEqualToString:plainHex] || [deResult3 isEqualToData:plainData]) {
        NSLog(@"sm2 加密解密成功");
    }else{
        NSLog(@"sm2 加密解密失败");
    }
    
    // ASN1 解码
    NSString *c1c3c2Result1 = [GMSm2Utils asn1DecodeToC1C3C2:enResult1]; // 解码为 c1c3c2字符串
    NSArray<NSString *> *c1c3c2Result2 = [GMSm2Utils asn1DecodeToC1C3C2Array:enResult2]; // 解码为 @[c1,c3,c2]
    NSData *c1c3c2Result3 = [GMSm2Utils asn1DecodeToC1C3C2Data:enResult3]; // 解码为 c1c3c2拼接的Data
    
    // ASN1 编码
    NSString *asn1Result1 = [GMSm2Utils asn1EncodeWithC1C3C2:c1c3c2Result1];
    NSString *asn1Result2 = [GMSm2Utils asn1EncodeWithC1C3C2Array:c1c3c2Result2];
    NSData *asn1Result3 = [GMSm2Utils asn1EncodeWithC1C3C2Data:c1c3c2Result3];
    
    // 判断 ASN1 解码编码结果，应相等
    if ([asn1Result1 isEqualToString:enResult1] || [asn1Result2 isEqualToString:enResult2] || [asn1Result3 isEqualToData:enResult3]) {
        NSLog(@"ASN1 解码编码成功");
    }else{
        NSLog(@"ASN1 解码编码失败");
    }
    
    NSMutableString *mStr = [NSMutableString stringWithString:@""];
    [mStr appendString:@"\n-------SM2加解密及编码-------"];
    [mStr appendFormat:@"\n生成SM2公钥：\n%@", pubKey];
    [mStr appendFormat:@"\n生成SM2私钥：\n%@", priKey];
    [mStr appendFormat:@"\nSM2加密密文：\n%@", enResult1];
    [mStr appendFormat:@"\nASN1 解码SM2密文：\n%@", c1c3c2Result1];
    [mStr appendFormat:@"\nASN1编码SM2密文：\n%@", asn1Result1];
    [mStr appendFormat:@"\nSM2解密结果：\n%@", deResult1];
    
    NSLog(@"%@",mStr);
//        self.gTextView.text = mStr;
    
}

- (void)fos_showView {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.myView.frame = CGRectMake(0, self.view.bounds.size.height - 200, self.view.bounds.size.width, 200);
        _isPresent = YES;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)fos_dismissView {
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.myView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 200);
        _isPresent = NO;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)test_md5 {
    
    
    NSString *sessionID = [[NSUUID UUID] UUIDString];
    NSLog(@"sessionid---%@",sessionID);

    // 14C98594-C9B7-493B-8223-E60133E45B21
    //
    
    NSString *bundlid = @"com.csii.madp.standard";
//    NSString *platformType = @"iPhone9,2_iOS13.6.1_1.0.0_iOS";
    NSString *sdkVersion = @"1.0.0";
    NSString *sdktype = @"bioauth";
    NSString *timeStr = @"1607323686529";
    NSString *license = @"3Q6QuP5FtZsPCYaD";
    NSString *letString = @"fosafer20180725";
    
    
//    FOSLogDebug(@"before1111 md5 %@-%@-%@-%@-%@-%@",bundleId,time,testKey,sdkType,sdkVersion,letString);

    
    NSString *beforeStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",bundlid,timeStr,license,sdktype,sdkVersion,letString];
    
    NSLog(@"加密之前111---%@",beforeStr);
    NSString *sign = [self getMD5String:beforeStr];
    NSLog(@"sign---%@",sign);
}

- (NSString *)getMD5String:(NSString *)aString {
    
    NSData *dataString = [aString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutData = [[NSMutableData alloc] initWithData:dataString];
    const char * original_str = (const char *)[mutData bytes];
    unsigned char digist[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)mutData.length, digist);
    NSData    *data = [NSData dataWithBytes:(const void *)digist length:sizeof(unsigned char)*CC_MD5_DIGEST_LENGTH];
    return [self convertDataToHexStr:data];
}

- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return [string uppercaseString];
}

- (void)dealloc {
    
    if (self.fosTimer) {
        [self.fosTimer invalidate];
        self.fosTimer = nil;
    }
}


//dispatch_group_t dispatch_group_create(void) {
    //申请内存空间
//    dispatch_group_t dg = (dispatch_group_t)_dispatch_alloc(DISPATCH_VTABLE(group), sizeof(struct dispatch_semaphore_s));
    
//    _dispatch_alloc(DISPATCH_VT)
    //使用LONG_MAX初始化信号量结构体
//    _dispatch_semaphore_init(LONG_MAX, dg);
//    return dg;
    
    
//}


//- (void)batchRequestConfig {
//    dispatch_group_t group = dispatch_group_create();
//    NSArray *list = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
//    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        //标记开始本次请求
//        dispatch_group_enter(group);
////        [self fetchConfigurationWithCompletion:^(NSDictionary *dict) {
//            //标记本次请求完成
//            dispatch_group_leave(group);
//        }];
//    }];
    
//    __weak typeof(self)weakSelf = self;
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        //所有请求都完成了,执行刷新UI等操作
//
//
//        NSLog(@"finish refresh UI");
//        weakSelf.showLabel.text = [NSString stringWithFormat:@"等待完成%ld次",_count++];
//
//
//
//    });
//}
//- (void)fetchConfigurationWithCompletion:(void(^)(NSDictionary *dict))completion {
//    //AFNetworking或其他网络请求库
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //模拟网络请求
//        sleep(10);
//        !completion ? nil : completion(nil);
//    });
//}


- (void)testGroupHttp {
    
    dispatch_group_t fsGroup = dispatch_group_create();
    
    //模拟网络请求1
        dispatch_group_enter(fsGroup);
        //实际运用时，用网络请求的方法代替下面的内容，不要忘记leave异步
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (int i = 0; i < 5; i++) {
                [NSThread sleepForTimeInterval:1];
                NSLog(@"当前线程：%@，是否是主线程：%@...1111···%d",[NSThread currentThread],[NSThread isMainThread]?@"是":@"否",i);//当前线程：<NSThread: 0x60000027ef40>{number = 3, name = (null)}，是否是主线程：否...1111···0
            }
            dispatch_group_leave(fsGroup);
        });
        NSLog(@"当前线程：%@，是否是主线程：%@...4444···",[NSThread currentThread],[NSThread isMainThread]?@"是":@"否");
    
    
    //模拟网络请求2
       dispatch_group_enter(fsGroup);
       //实际运用时，用网络请求的方法代替下面的内容，不要忘记leave      异步
       dispatch_async(dispatch_get_global_queue(0, 0), ^{
           for (int i = 0; i < 5; i++) {
               [NSThread sleepForTimeInterval:1];
               NSLog(@"当前线程：%@，是否是主线程：%@...2222···%d",[NSThread currentThread],[NSThread isMainThread]?@"是":@"否",i);//当前线程：<NSThread: 0x604000272540>{number = 4, name = (null)}，是否是主线程：否...2222···0
           }
           dispatch_group_leave(fsGroup);
       });
       
       dispatch_group_notify(fsGroup, dispatch_get_main_queue(), ^{
           NSLog(@"当前线程：%@，是否是主线程：%@...3333···",[NSThread currentThread],[NSThread isMainThread]?@"是":@"否");//当前线程：<NSThread: 0x604000071d40>{number = 1, name = main}，是否是主线程：是...3333···
       });
}

- (void)set_gaoTian:(NSString *)_gaoTian {
    
    
}


- (void)testCopy {
    
    NSMutableString *mutStr = [NSMutableString stringWithString:@"123"];
    NSString *copyStr = mutStr;
    NSLog(@"mutStr--%p----copy---%p",mutStr,copyStr);
    
    
    
    [mutStr appendString:@"456"];
    NSLog(@"mul--%@---%@",mutStr,copyStr);
}

- (void)test_systemButton {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"i am a button" forState:UIControlStateNormal];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:btn];
    
    
    [btn.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [btn.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
}


- (void)testLayoutGuide {
    
    
    // 打印 attributes
//    unsigned int outCount = 0;
//    objc_property_t* propertys = class_copyPropertyList([ViewController class], &outCount);
//    for (unsigned i = 0; i < outCount; i++) {
//        objc_property_t property = propertys[i];
//        assert(property != nil);
//        const char* name = property_getName(property);
//        NSLog(@"name: %s", name);
//
//        NSString* attrs = @(property_getAttributes(property));
//        NSLog(@"code: %@", attrs);
//    }
    
    
    /**
     
     将 frame 布局 自动转化为约束布局，
     转化的结果是为这个视图自动添加所有需要的约束，如果我们这时给视图添加自己创建的约束就一定会约束冲突。

     为了避免上面说的约束冲突，我们在代码创建 约束布局 的控件时 直接指定这个视图不能用frame 布局（即translatesAutoresizingMaskIntoConstraints=NO），可以放心的去使用约束了。
     
     
     假设我们现在有这样的布局需求，两个view，一个红色的view，一个绿色的view，这两个view左右排列，撑满整个屏幕，但是离屏幕的边界（不是内容边距margin）都有20的间隙，两个view之间相隔8，并且绿色的view宽度是红色view的两倍。
     
     
     redView.translatesAutoresizingMaskIntoConstraints = false
     greenView.translatesAutoresizingMaskIntoConstraints = false

     //获取安全区域的layoutGudie
     let safeArea = self.view.safeAreaLayoutGuide

     //Y轴方向布局
     redView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20.0).isActive = true
     safeArea.bottomAnchor.constraint(equalTo:redView.bottomAnchor , constant: 20.0).isActive = true
     greenView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20.0).isActive = true
     safeArea.bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: 20.0).isActive = true
     //X轴方向布局
     redView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20.0).isActive = true
     greenView.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: 8.0).isActive = true
     safeArea.trailingAnchor.constraint(equalTo: greenView.trailingAnchor, constant:20.0).isActive = true
     //尺寸相关的布局
     greenView.widthAnchor.constraint(equalTo: redView.widthAnchor, multiplier: 2.0).isActive = true

     */
    
    
    // 三个视图 水平排布 等间距
    
    // 每个视图之间的距离是 30
    
    CGFloat offSet = 20.f;
//    CGFloat height = self.view.frame.size.height - 40;
//    CGFloat w = (self.view.frame.size.width - 4 * offSet) / 3;
    

    UIView *tempView0 = [[UIView alloc] init];
    tempView0.backgroundColor = [UIColor greenColor];
    tempView0.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tempView0];
    
    UIView *tempView1 = [[UIView alloc] init];
    tempView1.backgroundColor = [UIColor redColor];
    tempView1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tempView1];
    
//    UIView *tempView2 = [[UIView alloc] init];
//    tempView2.backgroundColor = [UIColor yellowColor];
//    tempView2.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:tempView2];
    
    
    // make layout
//    [tempView0.widthAnchor constraintEqualToConstant:w].active = YES;
//    [tempView0.heightAnchor constraintEqualToConstant:height].active = YES;
    UILayoutGuide *safeArea;
    if (@available(iOS 11.0, *)) {
        safeArea = self.view.safeAreaLayoutGuide;
    } else {
        // Fallback on earlier versions
        
//        safeArea = self.view;
    }
    
    
    
    [tempView0.topAnchor constraintEqualToAnchor:safeArea.topAnchor constant:20].active = YES;
    [tempView0.bottomAnchor constraintEqualToAnchor:safeArea.bottomAnchor constant:-20].active = YES;
    [tempView0.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:offSet].active = YES;
//    [tempView0.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor constant:200].active = YES;
    

//    [tempView1.widthAnchor constraintEqualToAnchor:tempView0.widthAnchor].active = YES;
    
    [tempView1.widthAnchor constraintEqualToAnchor:tempView0.widthAnchor multiplier:2].active = YES;
    [tempView1.topAnchor constraintEqualToAnchor:tempView0.topAnchor].active = YES;
    [tempView1.bottomAnchor constraintEqualToAnchor:tempView0.bottomAnchor].active = YES;
//    [tempView1.centerYAnchor constraintEqualToAnchor:tempView0.centerYAnchor].active = YES;
    [tempView1.leadingAnchor constraintEqualToAnchor:tempView0.trailingAnchor constant:8].active = YES;
    [tempView1.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor constant:-offSet].active = YES;
//
//    [tempView2.widthAnchor constraintEqualToAnchor:tempView0.widthAnchor].active = YES;
//    [tempView2.heightAnchor constraintEqualToAnchor:tempView0.heightAnchor].active = YES;
//    [tempView2.centerYAnchor constraintEqualToAnchor:tempView0.centerYAnchor].active = YES;
//    [tempView2.leadingAnchor constraintEqualToAnchor:tempView1.trailingAnchor constant:offSet].active = YES;
//
//    [tempView2.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-offSet].active = YES;
}

- (UILabel *)showLabel {
    if (!_showLabel) {
        UILabel *aLabel = [[UILabel alloc] init];
        aLabel.backgroundColor = [UIColor greenColor];
        aLabel.textColor = UIColor.redColor;
        aLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:aLabel];
        
        _showLabel = aLabel;
    
    }
    return _showLabel;
}

- (UIView *)myView {
    if (!_myView) {
        CGFloat padding = (self.view.bounds.size.width - 200) * 0.5;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(padding, 200, 200, 200)];
        view.backgroundColor = UIColor.redColor;
        [self.view addSubview:view];
        _myView = view;
    }
    return _myView;
}



- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *img = [[UIImageView alloc] init];
        img.backgroundColor = [UIColor redColor];
        img.translatesAutoresizingMaskIntoConstraints = NO;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"liveness_layout_head_mask" ofType:@"webp"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        img.image = [UIImage imageWithData:data];
        [self.view addSubview:img];
        _imageView = img;
    }
    return _imageView;
}

- (UIActivityIndicatorView *)juhua {
    if (!_juhua) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.backgroundColor = [UIColor redColor];
        indicator.alpha = .5f;

        indicator.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:indicator];
        
        
        _juhua = indicator;
    }
    return _juhua;
}


@end
