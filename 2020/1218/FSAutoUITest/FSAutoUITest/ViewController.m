//
//  ViewController.m
//  FSAutoUITest
//
//  Created by Augus on 2020/12/18.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>


#define XBScreenWidth   [UIScreen mainScreen].bounds.size.width
#define XBScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface ViewController () <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (strong, nonatomic) AVCaptureSession *avSession;
@property (strong, nonatomic) AVCaptureDevice *backCameraDevice;
@property (nonatomic, strong) UISlider *slider;

@property (nonatomic, strong) UIImageView *testImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
#if TARGET_OS_SIMULATOR
    NSAssert(0, @"请使用真机测试");
#endif
    [super viewDidLoad];
//    [self setupSession];
//
//    [self slider];
    
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!_avSession.isRunning) {
        [_avSession startRunning];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (!_avSession.isRunning) {
        [_avSession stopRunning];
    }
}

- (AVCaptureDevice *)backCamera
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == AVCaptureDevicePositionBack) {
            return device;
        }
    }
    return nil;
}

- (void)setupSession
{
    //创建session会话
    _avSession = [[AVCaptureSession alloc] init];
    [_avSession beginConfiguration];
    _avSession.sessionPreset = AVCaptureSessionPreset640x480;
    //通过capture对象创建输入设备对象
    NSError *error = nil;
    _backCameraDevice = [self backCamera];
    
    if (!self.backCameraDevice.focusPointOfInterestSupported) {
        NSLog(@"focus is not support");
        return;
    }
    
    
    [_backCameraDevice lockForConfiguration:&error];
    _backCameraDevice.focusMode = AVCaptureFocusModeLocked;
    [_backCameraDevice unlockForConfiguration];
    AVCaptureDeviceInput *inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:_backCameraDevice error:&error];
    //将输入设备添加到会话
    if ([_avSession canAddInput:inputDevice]) {
        [_avSession addInput:inputDevice];
    }else{
        NSLog(@"不能添加视频输入设备");
        return;
    }
    //添加一个输出设备
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    videoOutput.videoSettings = @{(__bridge NSString *)kCVPixelBufferPixelFormatTypeKey : [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA]};
    
    videoOutput.alwaysDiscardsLateVideoFrames = YES;
    
    if ([_avSession canAddOutput:videoOutput]) {
        [_avSession addOutput:videoOutput];
    }else{
        NSLog(@"不能添加视频输出设备");
        return;
    }
    
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_avSession];
    //只有设置GravityResizeAspectFill或GravityResize，然后设置frame才有效，图像不会按照frame的大小显示
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    previewLayer.frame = CGRectMake(0, 20, 320, 240);
    [self.view.layer addSublayer:previewLayer];

    [_avSession commitConfiguration];
}


#pragma mark - Slider Action

- (void)foucsChange:(UISlider *)sender {
    
    
    NSLog(@"sender --%f",sender.value);
    NSError *error = nil;
    [_backCameraDevice lockForConfiguration:&error];
    [_backCameraDevice setFocusModeLockedWithLensPosition:sender.value completionHandler:nil];
    [_backCameraDevice unlockForConfiguration];
    
}


- (UISlider *)slider {
    if (!_slider) {
        UISlider *slider = [[UISlider alloc] init];
        slider.frame = CGRectMake(0, 400, self.view.bounds.size.width, 50);
        [slider addTarget:self action:@selector(foucsChange:) forControlEvents:UIControlEventValueChanged];
//        slider.minimumValue = 1.0;
//        slider.maximumValue = _backCameraDevice.maxAvailableVideoZoomFactor;
        [self.view addSubview:slider];
        
        _slider = slider;
        
    }
    return _slider;
}

- (UIImageView *)testImageView {
    
    if (!_testImageView) {
        _testImageView = [[UIImageView alloc] init];
        _testImageView.backgroundColor = [UIColor greenColor];
        _testImageView.image = [UIImage imageNamed:@""];
    }
    return _testImageView;
}


@end
