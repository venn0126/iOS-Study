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
#import "NSDateFormatter+Extension.h"
#import <objc/runtime.h>
#import "SNGradientLabel.h"
#import "SNTableViewCell.h"


void AugusCPSR(void);

typedef NS_OPTIONS(NSUInteger, SNASANetworkType) {
    SNASANetworkTypeToken            = 1 << 0,   // iOS 14.3+,get token request
    SNASANetworkTypeAdService        = 1 << 1,   // ad service framework get attribution data request
    SNASANetworkTypeiAd              = 1 << 2    // iad framework get attribution data request
};

static CGFloat const kImageViewWidth = 100.0f;
static NSString * const kTableViewCellId = @"kTableViewCellId";

typedef void(^grayImageCompletion)(id result);

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat dynamicImageViewY;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) NSTimer *timer;


@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UIButton *updateData;
@property (nonatomic, strong) GTViewModel *viewModel;

@property (nonatomic, strong) NSTimer *retryTimer;
@property (nonatomic, copy) NSDictionary *dataModel;
@property (nonatomic, assign) NSInteger tokenNetworkErrorRetryIndex;
@property (nonatomic, assign) NSInteger adServiceNetworkErrorRetryIndex;
@property (nonatomic, assign) NSInteger iAdNetworkErrorRetryIndex;
@property (nonatomic, strong) UITableView *subTableView;
@property (nonatomic, strong) UIView *footerView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = UIColor.whiteColor;
    self.view.backgroundColor = UIColor.whiteColor;
    _dynamicImageViewY = 0;
//    [self createImageView];
//    [self createAnimationButton];
//    [self createDisplayLink];
    
    
    
//    [self createNSTimerOfRunLoop];
    
//    [self testAssetsResources];
    
    
//    [self testViewModelBase];
    
//    [self testDateFormat];
    
    
//    testSum(1, 2, 3, 4, 5, 6, 7, 8, 9);
    
//    getTestStr(1, 2, 3, 4, 5, 6, 7);

//    [self doNotImportH];
    
//    [self testASAAttributionData:SNASANetworkTypeToken];
    
    
//    [self testGrayModel];
    
//    AugusCPSR();
    
//    augusFunc();
    
//    [self testCPSR];
    
    
//    [self testLabelAddGradientLayer];
    
    [self testSubTableViewOfHorizontal];
}


- (void)testSubTableViewOfHorizontal {
    
    [self.view addSubview:self.subTableView];
    [self.view addSubview:self.footerView];
}


#pragma mark - UITableViewDataSouce

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellId];
    if (!cell) {
        cell = [[SNTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTableViewCellId];
    }
    
    
    return cell;
}


- (UIColor *)randomColor {
    
    CGFloat red = arc4random() % 256 / 256.0;
    CGFloat green = arc4random() % 256 / 256.0;
    CGFloat blue = arc4random() % 256 / 256.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    NSLog(@"%@", color);
    
 
    return color;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UIScreen.mainScreen.bounds.size.width - 80;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    

}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSUInteger index = [_people indexOfObject:person];
//     NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
     if ([self.subTableView.indexPathsForVisibleRows containsObject:indexPath]) {
       [self.subTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];

         NSLog(@"in indexpath.row %ld",(long)indexPath.row);
         if (indexPath.row == 2) {// visible cell
             self.footerView.hidden = NO;
         } else {
             self.footerView.hidden = YES;
         }
     }
//    NSIndexPath *indexPathTwo = [NSIndexPath indexPathForRow:2 inSection:0];
//    CGRect cellRect = [self.subTableView rectForRowAtIndexPath:indexPathTwo];
//    BOOL completelyVisible = CGRectContainsRect(self.subTableView.bounds, cellRect);
//    if (completelyVisible) {
//        self.footerView.hidden = NO;
//    } else {
//        self.footerView.hidden = YES;
//    }
    
}


//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 70;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//
//    UIView *footerView = [[UIView alloc] init];
//    footerView.backgroundColor = UIColor.redColor;
//    return footerView;
//}


- (void)testLabelAddGradientLayer {
    
    SNGradientLabel *label = [[SNGradientLabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.textColor = UIColor.whiteColor;
    [self.view addSubview:label];
    
    label.text = @"sssssss";
    
    
    
    for (int i = 0; i < 1000000; i++) {
        
        label.highColor = UIColor.yellowColor;
        label.lowColor = UIColor.blueColor;
        
        label.startPoint = CGPointMake(0, 1);
        label.endPoint = CGPointMake(1, 0);
        NSLog(@"---%d",i);
    }
    



}


- (void)testCPSR {
    
    NSInteger a = 3;
    NSInteger b = 4;
    if (a-b) {
        NSLog(@"it is is true");
    }
    
    
}


void augusFunc(){
    asm(
        "mov w0, #-0x2\n"
        "adds w0, w0, #0x1\n"
        "adds w0, w0, #0x1\n"
        "subs w0, w0, #0x1\n"
        );
}



- (void)testGrayModel {
    [self.view addSubview:self.imageView];
    self.imageView.frame = CGRectMake(100, 100, 100, 100);
    self.imageView.image = [UIImage imageNamed:@"ico_file1_v5"];
    UIImage *orginImage = [UIImage imageNamed:@"ico_sfile6_v5"];
    
//    for (int i = 0; i < 100000; i++) {
//        UIImage *greyImage = [self grayImageFromOriginalImage:orginImage];
//        if (i == 0) {
//            self.imageView.image = greyImage;
//        }
//        NSLog(@"wyy touch begin len %d %p",i,greyImage);
//    }
    
    
    CIImage *ciImage = [CIImage imageWithCGImage:orginImage.CGImage];
    for (int i = 0; i < 100000; i++) {
        UIImage *greyImage = [self imageFromCIImage:ciImage scale:2.0 orientation:UIImageOrientationUp];
        if (i == 0) {
            self.imageView.image = greyImage;
            
        }
        NSLog(@"augus touch begin len %d %p",i,greyImage);
    }
}



- (void)testASAAttributionData:(SNASANetworkType)type {
    
    NSInteger temp = 0;
    switch (type) {
        case SNASANetworkTypeToken:{
            temp = _tokenNetworkErrorRetryIndex;
            _tokenNetworkErrorRetryIndex++;
        }break;
        case SNASANetworkTypeAdService:{
            temp = _adServiceNetworkErrorRetryIndex;
            _adServiceNetworkErrorRetryIndex++;
        }break;
        case SNASANetworkTypeiAd:{
            temp = _iAdNetworkErrorRetryIndex;
            _iAdNetworkErrorRetryIndex++;
        }
        break;
    }
    
    [self testNetworkRetry:temp];
    
    
}

- (UIImage *)grayImageFromOriginalImage:(UIImage *)image {
    
        
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        
        const int RED =1;
        const int GREEN =2;
        const int BLUE =3;
        
        // Create image rectangle with current image width/height
        CGRect imageRect = CGRectMake(0,0, image.size.width* image.scale, image.size.height* image.scale);
        
        int width = imageRect.size.width;
        int height = imageRect.size.height;
        
        // the pixels will be painted to this array
        uint32_t *pixels = (uint32_t*) malloc(width * height *sizeof(uint32_t));
        
        // clear the pixels so any transparency is preserved
        memset(pixels,0, width * height *sizeof(uint32_t));
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        // create a context with RGBA pixels
        CGContextRef context = CGBitmapContextCreate(pixels, width, height,8, width *sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
        
        // paint the bitmap to our context which will fill in the pixels array
        CGContextDrawImage(context,CGRectMake(0,0, width, height), [image CGImage]);
        
        for(int y = 0; y < height; y++) {
            for(int x = 0; x < width; x++) {
                uint8_t *rgbaPixel = (uint8_t*) &pixels[y * width + x];
                
                // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
                uint32_t gray = 0.3 * rgbaPixel[RED] +0.59 * rgbaPixel[GREEN] +0.11 * rgbaPixel[BLUE];
                
                // set the pixels to gray
                rgbaPixel[RED] = gray;
                rgbaPixel[GREEN] = gray;
                rgbaPixel[BLUE] = gray;
            }
        }
        
        // create a new CGImageRef from our context with the modified pixels
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        
        // we're done with the context, color space, and pixels
        CGContextRelease(context);
        CGColorSpaceRelease(colorSpace);
        free(pixels);
        
        // make a new UIImage to return
        UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:UIImageOrientationUp];
        
        // we're done with image now too
        CGImageRelease(imageRef);
            
    return  resultUIImage;
    
}


static const size_t kComponentsPerPixel = 4;
static const size_t kBitsPerComponent = sizeof(unsigned char) * 8;
static void releasePixels(void *info, const void *data, size_t size)
{
    free((void*)data);
}
- (UIImage *)imageFromCIImage:(CIImage *)img scale:(CGFloat)scale orientation:(UIImageOrientation)orientation
{
    int width = (int)img.extent.size.width;
    int height = (int)img.extent.size.height;
   
    long memsize = sizeof(unsigned char) * width * height * kComponentsPerPixel;
    unsigned char *rawData = malloc(memsize);
   
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer: @NO}];
   
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
//    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceGray();
   
    [context render:img toBitmap:rawData rowBytes:width*kComponentsPerPixel bounds:img.extent format:kCIFormatRGBA8 colorSpace:rgb];
   
    CGDataProviderRef provider = CGDataProviderCreateWithData(nil, rawData, memsize, releasePixels);
   
    CGImageRef imageFromContext = CGImageCreate(width,
                                                height,
                                                kBitsPerComponent,
                                                kBitsPerComponent * kComponentsPerPixel,
                                                width*kComponentsPerPixel,
                                                rgb,
                                                kCGBitmapByteOrderDefault | kCGImageAlphaLast,
                                                provider,
                                                NULL,
                                                false,
                                                kCGRenderingIntentDefault);
    UIImage *outImage = [UIImage imageWithCGImage:imageFromContext scale:scale orientation:orientation];
   
    CGImageRelease(imageFromContext);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(rgb);
   
    return outImage;
}


- (void)testNetworkRetry:(NSInteger)index {
    

    NSNumber *tokenNumber = [NSNumber numberWithInteger:index];
    NSTimeInterval timeInterval = (NSTimeInterval)[[self.dataModel objectForKey:tokenNumber] doubleValue];
    NSLog(@"first time interval is %f -- %ld",timeInterval, _tokenNetworkErrorRetryIndex);
    if (!timeInterval) {
        timeInterval = 10.0;
    }
    NSLog(@"second time interval is %f -- %ld",timeInterval, _tokenNetworkErrorRetryIndex);

    if (_retryTimer) {
        [self stopRetryTimer];
    }
    _retryTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self testASAAttributionData:SNASANetworkTypeToken];
        self->_tokenNetworkErrorRetryIndex++;
    }];
    
}


- (void)stopRetryTimer {
    
    if (_retryTimer) {
        [_retryTimer invalidate];
        _retryTimer = nil;
    }
}

- (void)doNotImportH {
    
    id cls = objc_getClass("UIColor");
    [cls performSelector:NSSelectorFromString(@"BG1") withObject:nil];
    NSLog(@"cls %@",cls);
    
    
    NSArray *testArray = @[@1,@2,@5];
    id max = [testArray valueForKeyPath:@"@max.self"];
    NSLog(@"max is %@",max);
}

int testSum(int a,int b, int c, int d, int e, int f, int g, int h ,int i) {
    return a + b + c + d + e + f + g + h + i;
}

struct TestStr {
    int a;
    int b;
    int c;
    int d;
    int e;
    int f;
    int g;
};

struct TestStr getTestStr(int a, int b, int c,int d ,int e, int f, int g) {
    
    struct TestStr testStr;
    testStr.a = a;
    testStr.b = b;
    testStr.c = c;
    testStr.d = d;
    testStr.e = e;
    testStr.f = f;
    testStr.g = g;
    return testStr;
}




- (void)testDateFormat {
        
//    NSDateFormatter *formatter = [NSDateFormatter new];
//    // 是否需要指定区域，否则默认是en_US
//    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
//    [formatter setLocalizedDateFormatFromTemplate:@"jj:mm:ss"];
//    NSLog(@"%@: 'jj:mm' => '%@' ('%@')", formatter.locale.localeIdentifier, formatter.dateFormat, [formatter stringFromDate:[NSDate date]]);
//    formatter.dateFormat = [NSString stringWithFormat:@"yyyy-MM-dd %@",formatter.dateFormat];
//    NSLog(@"last result %@",[formatter stringFromDate:[NSDate date]]);
    
    NSString *test0 = [NSDateFormatter toStringByDate:[NSDate date] format:@"yyyy-MM-dd"];
    NSLog(@"test 0 is %@",test0);
    
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

- (NSDictionary *)dataModel {
    if (!_dataModel) {
        _dataModel = @{@0 : @2,
                       @1 : @4,
                       @2 : @6,
                       @3 : @8,
                       @4 : @10,};
    }
    return _dataModel;
}

- (UITableView *)subTableView {
    if (!_subTableView) {
        // width -> height; heigt -> width
        _subTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, 100, self.view.bounds.size.width - 100) style:UITableViewStylePlain];
        _subTableView.showsVerticalScrollIndicator = NO;
        _subTableView.showsHorizontalScrollIndicator = NO;
        _subTableView.backgroundColor = UIColor.clearColor;
        _subTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _subTableView.delegate = self;
        _subTableView.dataSource = self;
        _subTableView.backgroundColor = UIColor.greenColor;
        _subTableView.pagingEnabled = YES;
        _subTableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        _subTableView.center = CGPointMake(self.view.frame.size.width / 2, 200);

    }
    return _subTableView;
}


- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.subTableView.frame), self.subTableView.frame.origin.y, 70, self.subTableView.frame.size.height)];
        _footerView.backgroundColor = UIColor.redColor;
        _footerView.hidden = YES;
    }
    return _footerView;
}

@end
