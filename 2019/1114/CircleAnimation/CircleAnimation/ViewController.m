//
//  ViewController.m
//  CircleAnimation
//
//  Created by Augus on 2019/11/14.
//  Copyright © 2019 fosafer. All rights reserved.
//

#import "ViewController.h"
#import "FOSCircleView.h"
#import "CircleProgressBar.h"
#import "FosNumber.h"


extern NSString *CTSettingCopyMyPhoneNumber();

@interface ViewController ()

//@property (nonatomic, strong) FOSCircleView *cView;


@property (nonatomic, strong) CircleProgressBar *circleView;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIImageView *guideImageView;
@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, weak) NSString *strWeak;




@end

@implementation ViewController{
    
    UILabel *myTest1;
    NSTimeInterval animationDuration;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropdown_icon"]];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
            animation.fromValue = [NSNumber numberWithFloat:1.0f];
            animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
            animation.autoreverses = YES;
            animation.duration = 0.5;
            animation.repeatCount = MAXFLOAT;
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
        [_arrowImageView.layer addAnimation:animation forKey:nil];
    }
    return _arrowImageView;
}


- (CircleProgressBar *)circleView {
    if (!_circleView) {
        _circleView = [[CircleProgressBar alloc] init];
    }
    return _circleView;
}

- (UIImageView *)guideImageView {
    
    if (!_guideImageView) {
        _guideImageView = [[UIImageView alloc] init];
    }
    return _guideImageView;
}


- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitle:@"不可点击" forState:UIControlStateDisabled];
        [_nextButton setTintColor:[UIColor redColor]];
        [_nextButton setBackgroundColor:[UIColor greenColor]];
//        _nextButton.enabled = NO;
    }
    return _nextButton;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSLog(@"2-%@",_strWeak);
//    NSLog(@"333Retain Count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(_strWeak)));

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    NSLog(@"3-%@",_strWeak);
//    NSLog(@"444Retain Count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(_strWeak)));

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
//    @autoreleasepool {
//        NSLog(@"000Retain Count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(_strWeak)));

//        _strWeak = [NSString stringWithFormat:@"www"];
//        NSLog(@"111Retain Count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(_strWeak)));
//
//    }
//    NSLog(@"222Retain Count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(_strWeak)));
//    NSLog(@"1-%@",_strWeak);
    
    
//        NSString *str1 = @"haha";
////       [str1 retain];
//       NSString *str2 = [[NSString alloc] initWithString:@"haha"];
//       NSString *str3 = [[NSString alloc]initWithFormat:@"haha"];
//       NSString *str4 = [NSString stringWithFormat:@"haha"];
//       NSString *str5 = [[NSString alloc]initWithFormat:@"0123456789"];
//       NSString *str55 = [[NSString alloc]initWithFormat:@"0123456789"];
//       NSString *str6 = [[NSString alloc]initWithFormat:@"哈哈"];
//       
//       NSLog(@"%u---%p",(unsigned)[str1 retainCount],str1);
//       NSLog(@"%u---%p",(unsigned)[str2 retainCount],str2);
//       NSLog(@"%u---%p",(unsigned)[str3 retainCount],str3);
//       NSLog(@"%u---%p",(unsigned)[str4 retainCount],str4);
//       NSLog(@"%u---%p",(unsigned)[str5 retainCount],str5);
//       NSLog(@"%u---%p",(unsigned)[str55 retainCount],str55);
//       NSLog(@"%u---%p",(unsigned)[str6 retainCount],str6);
    
    
    [self testImageAnimation];

}

- (void)testImageView {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.center = self.view.center;
    imageView.image = [UIImage imageNamed:@"face_circle_00"];
    [self.view addSubview:imageView];
    
    CABasicAnimation *animation = [CABasicAnimation
    animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat: M_PI * 2];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]; // 动画效果慢进慢出
    animation.duration = 10; //动画持续时间
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO; //动画后是否回到最初状态（配合kCAFillModeForwards使用）
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [imageView.layer addAnimation:animation forKey:nil];
}

- (void)testImageAnimation {
    
    
    /*
      NSString *path = [[NSBundle mainBundle] pathForResource:@"BioGif" ofType:@"bundle"];
      NSBundle *gifBundle = [NSBundle bundleWithPath:path];
      NSString *gifPath = [gifBundle pathForResource:gifName ofType:@"gif"];
      NSData *gifData = [NSData dataWithContentsOfFile:gifPath];
     */
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BioGif" ofType:@"bundle"];
    NSBundle *gifBundle = [NSBundle bundleWithPath:path];
//    NSString *gifPath = [gifBundle pathForResource:gifName ofType:@"png"];
    

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 300, 300 * 1200.0 / 1125.0);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    // gif_00000
    // gif_00059
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 0; i < 60; i++) {
        
        NSString *imageName;
        if (i  < 10) {
            // face_circle02_00
//            imageName = [NSString stringWithFormat:@"face_circle02_0%d",i];
            imageName = [NSString stringWithFormat:@"face_circle01_0%d@3x",i];
        } else {
//            imageName = [NSString stringWithFormat:@"face_circle02_%d",i];
            imageName = [NSString stringWithFormat:@"face_circle01_%d@3x",i];


        }
        
        NSString *gifPath = [gifBundle pathForResource:imageName ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:gifPath];
        
//        UIImage *image = [UIImage imageNamed:imageName];
        
        [imageArray addObject:image];
    }
    
    
    imageView.animationImages = imageArray;
    imageView.animationDuration = 1;
    
    [imageView startAnimating];
}

- (void)testLayerCircle {
    
    
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.lineWidth = 10;
    //圆环的颜色
    layer.strokeColor = [UIColor blueColor].CGColor;
    //背景填充色
    layer.fillColor = [UIColor clearColor].CGColor;
    //设置半径为10
    CGFloat radius = 100;
    //按照顺时针方向
    BOOL clockWise = true;
    //初始化一个路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:clockWise];
    layer.path = [path CGPath];
    [self.view.layer addSublayer:layer];
}

- (void)testAnimation {
    
    //    NSMutableArray *tempArray = [NSMutableArray array];
    //    for (int i = 0; i < 8; i++) {
    //        UIView *view = [[UIView alloc] init];
    //        [tempArray addObject:view];
    //    }
    //
    //    self.cView = [[FOSCircleView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width) views:tempArray];
    //    self.cView.center = self.view.center;
    //    self.cView.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:self.cView];
        

    //    CircleProgressBar *circleView =
        
    //    [self.view addSubview:self.circleView];
    //    self.circleView.frame = CGRectMake(0, 0, 200, 200);
    //    self.circleView.center = self.view.center;
    ////    self.circleView.backgroundColor = [UIColor whiteColor];
    ////    self.circleView.hintHidden = YES;
    //    self.circleView.startAngle = -90;
        
        
    //        self.view.backgroundColor = [UIColor lightGrayColor];
    //
    //
    //        myTest1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 60, 40)];
    //        myTest1.backgroundColor = [UIColor blueColor];
    //        myTest1.textAlignment = NSTextAlignmentCenter;
    //        myTest1.text = @"venn";
    //        myTest1.textColor = [UIColor whiteColor];
    //        [self.view addSubview:myTest1];
    //
    //
    //    self.arrowImageView.frame = CGRectMake(100, 100, 24, 24);
    //    [self.view addSubview:self.arrowImageView];
        
        
    //    [myTest1.layer addAnimation:[self rotation:2 degree:kRadianToDegrees(90) direction:1 repeatCount:MAXFLOAT] forKey:nil];

        
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    //        animation.fromValue = [NSNumber numberWithFloat:1.0f];
    //        animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    //        animation.autoreverses = YES;
    //        animation.duration = 0.5;
    //        animation.repeatCount = MAXFLOAT;
    //        animation.removedOnCompletion = NO;
    //        animation.fillMode = kCAFillModeForwards;
    //       animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    //    [myTest1.layeraddAnimation:[selfrotation:2degree:kRadianToDegrees(90) direction:1repeatCount:MAXFLOAT] forKey:nil];

    //    [myTest1.layer addAnimation:animation forKey:nil];
        
        
        self.guideImageView.frame = CGRectMake(0, 0, 300, 300);
        self.guideImageView.center = CGPointMake(self.view.center.x, self.view.center.y);
        [self.view addSubview:self.guideImageView];
        
        self.nextButton.frame = CGRectMake(0, 0, 100, 50);
        [self.nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //    self.nextButton.enabled = NO;
        [self.view addSubview:self.nextButton];
        self.nextButton.hidden = YES;
        
        
        animationDuration = 0.0f;
        [self playOneTime:self.guideImageView gifName:@"sv_collect_guide"];
        NSLog(@"animation duration %f",animationDuration);
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((animationDuration) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.nextButton.hidden = NO;
        });
        
}
- (void)nextButtonAction:(UIButton *)sender {
    NSLog(@"跳转到第二个页面");
}


- (void)playOneTime:(UIImageView *)imageView gifName:(NSString *)gifName{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BioGif" ofType:@"bundle"];
    NSBundle *gifBundle = [NSBundle bundleWithPath:path];
    NSString *gifPath = [gifBundle pathForResource:gifName ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:gifPath];
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)gifData, NULL);
    size_t count = CGImageSourceGetCount(source);
    UIImage *animatedImage;
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:gifData];
    } else {
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        for (size_t i = 0; i < count; i++) {
            // 拿出了Gif的每一帧图片
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            //Learning... 设置动画时长 算出每一帧显示的时长(帧时长)
            CFDictionaryRef gifInfo = CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
            NSTimeInterval frameDuration = 0.0f;
            NSDictionary *frameProperties = (__bridge NSDictionary *)gifInfo;
            NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
            
            NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            if (delayTimeUnclampedProp) {
                frameDuration = [delayTimeUnclampedProp floatValue];
            }
            else {
                
                NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
                if (delayTimeProp) {
                    frameDuration = [delayTimeProp floatValue];
                }
            }
            duration += frameDuration;
            UIImage *img = [UIImage imageWithCGImage:image];
//            UIImage *sImg = [FOSTool imageWithImage:img scaledToWidth:100];
            [images addObject:img];
            if (i == count - 1) {
                imageView.image = img;
            }
            // 释放真图片对象
            CFRelease(image);
            
        }
        imageView.animationImages = images;
        // 播放总时间
        imageView.animationDuration = duration;
        // 播放次数, 0为无限循环
        imageView.animationRepeatCount = 1;
        // 开始播放
        [imageView startAnimating];
        
        animationDuration = duration;
        
        
    }
    
   
    // 释放源Gif图片
    CFRelease(source);
}


//- (CABasicACnimation *)opacityForever_Animation:(float)time {
//
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
//    animation.fromValue = [NSNumber numberWithFloat:1.0f];
//    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
//    animation.autoreverses = YES;
//    animation.duration = time;
//    animation.repeatCount = MAXFLOAT;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//   animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
//
//    return animation;
//
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    CGFloat progress = 1 / 9.0;
    [self.circleView setProgress:(self.circleView.progress + progress) animated:YES];
//    [self.circleView setProgress:0 animated:NO];
    
}


@end
