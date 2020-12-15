//
//  CameraViewController.m
//  IDCardDemo
//
//  Created by linmac on 16-10-15.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "CameraViewController.h"
#import "CameraDrawView.h"
#import "YMLine.h"
#import "UIViewExt.h"
#import "YMIDCardEngine.h"
#import "UKImage.h"
#import <sys/sysctl.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <ImageIO/ImageIO.h>
#import "CC_Config.h"
//#import <MADCore/MADSingleClass.h>

#define SYSTEM_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SYSTEM_WIDTH  [UIScreen mainScreen].bounds.size.width

@interface CameraViewController ()<UIAlertViewDelegate,BcrResultCallbackDelegate>{
    
    CameraDrawView *_cameraDrawView;
    BOOL _on;
    
    NSTimer *_timer;
    CAShapeLayer *_maskWithHole;
    AVCaptureDevice *_device;//当前摄像设备
    BOOL _isFoucePixel;
    int _maxCount;
    float _isIOS8AndFoucePixelLensPosition;
    
    NSInteger   bcrResultValue;
    NSInteger   bcrFreeValue;
//    MADSingleClass *singleClass;
}

@property (assign, nonatomic) BOOL adjustingFocus;//是否正在对焦
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    // Do any additional setup after loading the view.
    _maxCount = 4;//最大连续检边次数
    //初始化相机
    [self initialize];
    
    //创建相机界面控件
    [self createCameraView];
    idCardRangeRect = _cameraDrawView.engIdCardRect;

//    singleClass = [MADSingleClass getInstance];
//    [((YMIDCardEngine *)[singleClass performSelector:NSSelectorFromString(@"ymIDCardEngine")]) setBcrResultCallbackDelegate:self];
    [_ymIDCardEngine setBcrResultCallbackDelegate:self];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    idCardRangeRect = _cameraDrawView.engIdCardRect;
    
    if(!_isFoucePixel){//如果不支持相位对焦，开启自定义对焦
        //定时器 开启连续对焦
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.3 target:self selector:@selector(fouceMode) userInfo:nil repeats:YES];
    }
    
    AVCaptureDevice*camDevice =[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    int flags = NSKeyValueObservingOptionNew;
    //注册反差对焦通知（5s以下机型）
    [camDevice addObserver:self forKeyPath:@"adjustingFocus" options:flags context:nil];
    if (_isFoucePixel) {
        [camDevice addObserver:self forKeyPath:@"lensPosition" options:flags context:nil];
    }
    [self.session startRunning];
    
    if (self.exIdCardIndex == cardType_Bank) {
        _cameraDrawView.LabIdDetail.hidden = YES;
    }
    else if (self.exIdCardIndex == cardType_VIN)
    {
        _cameraDrawView.LabIdDetail.hidden = YES;
        _cameraDrawView.LabbankDetail.hidden = YES;
        _cameraDrawView.ImageVBankLine.hidden = YES;
    }
    else
    {
        _cameraDrawView.LabbankDetail.hidden = YES;
        _cameraDrawView.ImageVBankLine.hidden = YES;
    }
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除聚焦监听
    AVCaptureDevice*camDevice =[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [camDevice removeObserver:self forKeyPath:@"adjustingFocus"];
    if (_isFoucePixel) {
        [camDevice removeObserver:self forKeyPath:@"lensPosition"];
    }
    [self.session stopRunning];
    
}
- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    //关闭定时器
    if(!_isFoucePixel){
        [_timer invalidate];
    }
}

//监听对焦
-(void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
    if([keyPath isEqualToString:@"adjustingFocus"]){
        self.adjustingFocus =[[change objectForKey:NSKeyValueChangeNewKey] isEqualToNumber:[NSNumber numberWithInt:1]];
        //对焦中
    }
    if([keyPath isEqualToString:@"lensPosition"]){
        _isIOS8AndFoucePixelLensPosition =[[change objectForKey:NSKeyValueChangeNewKey] floatValue];
    }
}

//初始化相机
- (void) initialize
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        //判断摄像头授权
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
            if (self.blockComplete) {
                self.blockComplete(@{@"status":@"fail",@"errMsg":@"相机权限被拒绝"});
                return;
            }
        }
    }
    //1.创建会话层
    self.session = [[AVCaptureSession alloc] init];
    //设置图片品质
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    //2.创建、配置输入设备
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == AVCaptureDevicePositionBack)
        {
            _device = device;
            self.captureInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        }
    }
    [self.session addInput:self.captureInput];
    
    ///创建、配置预览输出设备
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    captureOutput.alwaysDiscardsLateVideoFrames = YES;
    
    dispatch_queue_t queue;
    queue = dispatch_queue_create("cameraQueue", NULL);
    [captureOutput setSampleBufferDelegate:self queue:queue];
    
    NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
    NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
    NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
    [captureOutput setVideoSettings:videoSettings];
    
    [self.session addOutput:captureOutput];
    
    //3.创建、配置输出
    self.captureOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [self.captureOutput setOutputSettings:outputSettings];
    [self.session addOutput:self.captureOutput];
    
    //判断对焦方式
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        AVCaptureDeviceFormat *deviceFormat = _device.activeFormat;
        if (deviceFormat.autoFocusSystem == AVCaptureAutoFocusSystemPhaseDetection){
            _isFoucePixel = YES;
            _maxCount = 5;//最大连续检边次数
        }
    }
    
    //设置预览
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession: self.session];
    self.preview.connection.videoOrientation = [self videoOrientationFromCurrentDeviceOrientation];
    NSLog(@"%f,%f",self.view.frame.size.width, self.view.frame.size.height);
    self.preview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.preview];
    
    [self.session startRunning];
}

- (AVCaptureVideoOrientation) videoOrientationFromCurrentDeviceOrientation {
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationPortrait: {
            return AVCaptureVideoOrientationPortrait;
        }
        case UIInterfaceOrientationLandscapeLeft: {
            return AVCaptureVideoOrientationLandscapeLeft;
        }
        case UIInterfaceOrientationLandscapeRight: {
            return AVCaptureVideoOrientationLandscapeRight;
        }
        case UIInterfaceOrientationPortraitUpsideDown: {
            return AVCaptureVideoOrientationPortraitUpsideDown;
        }
        case UIInterfaceOrientationUnknown: {
            return AVCaptureVideoOrientationPortrait;
            break;
        }
    }
}

//创建相机界面
- (void)createCameraView{
    //设置检边视图层
    _cameraDrawView = [[CameraDrawView alloc]initWithFrame:self.view.bounds];
    _cameraDrawView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_cameraDrawView];
    [_cameraDrawView setNeedsDisplay];
    
    //返回、闪光灯按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMakeBack(SYSTEM_WIDTH-70,SYSTEM_HEIGHT - 60, 65, 35)];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"cancel_s"] forState:UIControlStateNormal];
    backBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
//    backBtn.transform = CGAffineTransformMakeRotation(M_PI_2);
    [_cameraDrawView addSubview:backBtn];
//    [self.view bringSubviewToFront:backBtn];
    
    UIButton *flashBtn = [[UIButton alloc]initWithFrame:CGRectMakeFlash(255+5,30, 35, 35)];
    [flashBtn setImage:[UIImage imageNamed:@"flash_on_s"] forState:UIControlStateNormal];
    [flashBtn addTarget:self action:@selector(flashBtn) forControlEvents:UIControlEventTouchUpInside];
    flashBtn.hidden = YES;
    [self.view addSubview:flashBtn];
    
}

//从摄像头缓冲区获取图像
#pragma mark - AVCaptureSession delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    //获取当前帧数据
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    
    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
    int width = (int)CVPixelBufferGetWidth(imageBuffer);
    int height = (int)CVPixelBufferGetHeight(imageBuffer);
    CGSize imageSize;
    imageSize.width = width;
    imageSize.height = height;
    
    CGRect rect0 = [self getImageSize:imageSize byCardRect:idCardRangeRect];
    NSLog(@"kkk");
    BRect bRect;
    bRect.lx = rect0.origin.x;
    bRect.ly = rect0.origin.y;
    bRect.rx = rect0.origin.x + rect0.size.width;
    bRect.ry = rect0.origin.y + rect0.size.height;
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationPortrait: {
            bRect.lx = rect0.origin.y;
            bRect.ly = rect0.origin.x;
            bRect.rx = rect0.origin.y + rect0.size.height;
            bRect.ry = rect0.origin.x + rect0.size.width;
        }
            break;
        case UIInterfaceOrientationLandscapeRight: {
            bRect.lx = rect0.origin.x;
            bRect.ly = rect0.origin.y;
            bRect.rx = rect0.origin.x + rect0.size.width;
            bRect.ry = rect0.origin.y + rect0.size.height;
        }
            break;
    }
    
#pragma mark -- begin
    int edge = 0;
    switch (self.exIdCardIndex) {
        case cardType_Bank:
        {
            switch (self.interfaceOrientation) {
                case UIInterfaceOrientationPortrait: {
//                    edge = [((YMIDCardEngine *)[singleClass performSelector:NSSelectorFromString(@"ymIDCardEngine")]) doBcrRecognizeVedioWithBufferVertical:baseAddress andWidth:width andHeight:height andRect:bRect andChannelNumberStr:((YMIDCardEngine *)[singleClass performSelector:NSSelectorFromString(@"ymIDCardEngine")]).chNumberStr];
                    edge = [_ymIDCardEngine doBcrRecognizeVedioWithBufferVertical:baseAddress andWidth:width andHeight:height andRect:bRect andChannelNumberStr:_ymIDCardEngine.chNumberStr];
                }
                    break;
                case UIInterfaceOrientationLandscapeRight: {
//                    edge = [((YMIDCardEngine *)[singleClass performSelector:NSSelectorFromString(@"ymIDCardEngine")]) doBcrRecognizeVedioWithBuffer:baseAddress andWidth:width andHeight:height andRect:bRect andChannelNumberStr:((YMIDCardEngine *)[singleClass performSelector:NSSelectorFromString(@"ymIDCardEngine")]).chNumberStr];
                     edge = [_ymIDCardEngine doBcrRecognizeVedioWithBuffer:baseAddress andWidth:width andHeight:height andRect:bRect andChannelNumberStr:_ymIDCardEngine.chNumberStr];
                }
                    break;
            }
        }
            break;
        
        case cardType_ID:
        {
            switch (self.interfaceOrientation) {
                case UIInterfaceOrientationPortrait: {
//                    bRect.lx = 10;
//                    bRect.ly = 100;
//                    bRect.rx = 1000;
//                    bRect.ry = 1100;
//                    edge = [((YMIDCardEngine *)[singleClass performSelector:NSSelectorFromString(@"ymIDCardEngine")]) doBcrRecognizeVedioWithVertical_ID:baseAddress andWidth:width andHeight:height andRect:bRect andChannelNumberStr:((YMIDCardEngine *)[singleClass performSelector:NSSelectorFromString(@"ymIDCardEngine")]).chNumberStr];
                     edge = [_ymIDCardEngine doBcrRecognizeVedioWithVertical_ID:baseAddress andWidth:width andHeight:height andRect:bRect andChannelNumberStr:_ymIDCardEngine.chNumberStr];
                }
                    break;
                case UIInterfaceOrientationLandscapeRight: {
//                    edge = [((YMIDCardEngine *)[singleClass performSelector:NSSelectorFromString(@"ymIDCardEngine")]) doBcrRecognizeVedioWith_ID:baseAddress andWidth:width andHeight:height andRect:bRect andChannelNumberStr:((YMIDCardEngine *)[singleClass performSelector:NSSelectorFromString(@"ymIDCardEngine")]).chNumberStr];
                    edge = [_ymIDCardEngine doBcrRecognizeVedioWith_ID:baseAddress andWidth:width andHeight:height andRect:bRect andChannelNumberStr:_ymIDCardEngine.chNumberStr];
                }
                    break;
            }
        }
            break;

        default:
            break;
    }
    NSLog(@"edge = %d",edge);
    
    NSString *str = @"";
    switch (edge) {
        case 100:
        {
            str = @"本地时间过期";
            [_session stopRunning];
            bcrFreeValue = 1;
            [self performSelectorOnMainThread:@selector(showCamaraAlert:) withObject:str waitUntilDone:NO];
        }
            break;
        case 101:
        {
            str = @"识别时间过期";
            [_session stopRunning];
            bcrFreeValue = 1;
            [self performSelectorOnMainThread:@selector(showCamaraAlert:) withObject:str waitUntilDone:NO];
        }
            break;
        case 200:
        {
            str = @"授权失败";
            [_session stopRunning];
            bcrFreeValue = 1;
            [self performSelectorOnMainThread:@selector(showCamaraAlert:) withObject:str waitUntilDone:NO];
        }
            break;
        case 300:
        {
            str = @"识别次数超过";
            [_session stopRunning];
            bcrFreeValue = 1;
            [self performSelectorOnMainThread:@selector(showCamaraAlert:) withObject:str waitUntilDone:NO];
        }
            break;
        case 600:
        {
            str = @"软件加密失败";
            [_session stopRunning];
            bcrFreeValue = 1;
            [self performSelectorOnMainThread:@selector(showCamaraAlert:) withObject:str waitUntilDone:NO];
        }
            break;
        case 900:
        {
            str = @"识别次数创建权限失败";
            [_session stopRunning];
            bcrFreeValue = 1;
            [self performSelectorOnMainThread:@selector(showCamaraAlert:) withObject:str waitUntilDone:NO];
        }
            break;
        case 901:
        {
            str = @"识别时间创建权限失败";
            [_session stopRunning];
            bcrFreeValue = 1;
            [self performSelectorOnMainThread:@selector(showCamaraAlert:) withObject:str waitUntilDone:NO];
        }
            break;
            
        default:
            break;
    }
    
    //找边成功
    if (bcrResultValue == 1)
    {
        bcrResultValue = 0;
        //停止取景
        [_session stopRunning];
        [self performSelectorOnMainThread:@selector(perFormDoOcr) withObject:nil waitUntilDone:NO];
    }
    
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);

}

-(void)showCamaraAlert:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:(NSString*)sender delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)deviceOrientationDidChange
{
    self.preview.connection.videoOrientation = [self videoOrientationFromCurrentDeviceOrientation];
    NSLog(@"%f,%f",self.view.frame.size.width, self.view.frame.size.height);
    self.preview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.preview];
    
    [_cameraDrawView removeFromSuperview];
    [self createCameraView];
    idCardRangeRect = _cameraDrawView.engIdCardRect;
//    appDlg = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [((YMIDCardEngine *)[singleClass performSelector:NSSelectorFromString(@"ymIDCardEngine")]) setBcrResultCallbackDelegate:self];

     [_ymIDCardEngine setBcrResultCallbackDelegate:self];
    
    if (self.exIdCardIndex == cardType_Bank) {
        _cameraDrawView.LabIdDetail.hidden = YES;
    }
    else if (self.exIdCardIndex == cardType_VIN)
    {
        _cameraDrawView.LabIdDetail.hidden = YES;
        _cameraDrawView.LabbankDetail.hidden = YES;
        _cameraDrawView.ImageVBankLine.hidden = YES;
    }
    else
    {
        _cameraDrawView.LabbankDetail.hidden = YES;
        _cameraDrawView.ImageVBankLine.hidden = YES;
    }
}

// Create a UIImage from sample buffer data
- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    return (image);
}

-(void)perFormDoOcr
{
    CGRect rect;
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    NSString *resultStr = @"";
    switch (self.exIdCardIndex) {
        case cardType_Bank:
        {
//            resultDict = (NSMutableDictionary*)[((YMIDCardEngine *)[singleClass performSelector:NSSelectorFromString(@"ymIDCardEngine")]) doBCRWithRect:rect];
            resultDict = [_ymIDCardEngine doBCRWithRect:rect];
        }
            break;
        case cardType_ID:
        {
//            resultDict = (NSMutableDictionary*)[((YMIDCardEngine *)[singleClass performSelector:NSSelectorFromString(@"ymIDCardEngine")]) doBCRWithRect_ID:rect];
            resultDict = [_ymIDCardEngine doBCRWithRect_ID:rect];
            resultStr = [self makeCardResultWithDicVideo_ID:resultDict];
            if (resultStr.length)
            {
                [resultDict setObject:resultStr forKey:RES_IDSTR];
            }
            if ([resultDict objectForKey:RESID_IMAGE] != NULL) {
                [resultDict setObject:[resultDict objectForKey:RESID_IMAGE] forKey:RESID_IMAGE];
            }
            if ([resultDict objectForKey:RESID_HEADIMAGE] != NULL) {
                [resultDict setObject:[resultDict objectForKey:RESID_HEADIMAGE] forKey:RESID_HEADIMAGE];
            }
        }
            break;
            
        default:
            break;
    }
    if (self.blockComplete) {
        self.blockComplete(resultDict);
    }


    [self dismissViewControllerAnimated:NO completion:nil];
}
- (NSString *)makeCardResultWithDicVideo_ID:(NSDictionary*)dic
{
    NSMutableString *message = [NSMutableString string];
    if (!dic.count)
        return nil;
    
    if ([[[dic objectForKey:RESID_NAME] objectForKey:@"value"] length]) {
        [message appendFormat:@"姓名:%@\n",[[dic objectForKey:RESID_NAME] objectForKey:@"value"]];
    }
    if ([[[dic objectForKey:RESID_SEX] objectForKey:@"value"] length]) {
        [message appendFormat:@"性别:%@\n",[[dic objectForKey:RESID_SEX] objectForKey:@"value"]];
    }
    if ([[[dic objectForKey:RESID_FOLK] objectForKey:@"value"] length]) {
        [message appendFormat:@"民族:%@\n",[[dic objectForKey:RESID_FOLK] objectForKey:@"value"]];
    }
    if ([[[dic objectForKey:RESID_BIRT] objectForKey:@"value"] length] ) {
        [message appendFormat:@"出生日期:%@\n",[[dic objectForKey:RESID_BIRT] objectForKey:@"value"]];
    }
    if ([[[dic objectForKey:RESID_ADDRESS] objectForKey:@"value"] length]) {
        [message appendFormat:@"住址:%@\n",[[dic objectForKey:RESID_ADDRESS] objectForKey:@"value"]];
    }
    if ([[[dic objectForKey:RESID_NUM] objectForKey:@"value"] length]) {
        [message appendFormat:@"公民身份号码:%@\n",[[dic objectForKey:RESID_NUM] objectForKey:@"value"]];
    }
    if ([[[dic objectForKey:RESID_ISSUE] objectForKey:@"value"] length]) {
        [message appendFormat:@"签发机关:%@\n",[[dic objectForKey:RESID_ISSUE] objectForKey:@"value"]];
    }
    if ([[[dic objectForKey:RESID_VALID] objectForKey:@"value"] length]) {
        [message appendFormat:@"有效期限:%@\n",[[dic objectForKey:RESID_VALID] objectForKey:@"value"]];
    }
    if ([[[dic objectForKey:RESID_TYPE] objectForKey:@"value"] length]) {
        [message appendFormat:@"正反面判断:%@\n",[[dic objectForKey:RESID_TYPE] objectForKey:@"value"]];
    }
    if ([[[dic objectForKey:RESID_COVER] objectForKey:@"value"] length]) {
        [message appendFormat:@"遮挡判断:%@\n",[[dic objectForKey:RESID_COVER] objectForKey:@"value"]];
    }
    
    return message;
}

-(CGRect)getImageSize:(CGSize)imageSize byCardRect:(CGRect)R
{
    NSLog(@"imageSize:%f, %f", imageSize.width, imageSize.height);
    CGFloat tempWidth = 0.0;
    CGFloat tempHight = 0.0;
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationPortrait: {
            tempWidth = CCSCREENH_HEIGHT;
            tempHight = CCSCREEN_WIDTH;
        }
            break;
        case UIInterfaceOrientationLandscapeRight: {
            tempWidth = CCSCREEN_WIDTH;
            tempHight = CCSCREENH_HEIGHT;
        }
            break;
    }
    
    float screenWidth = tempWidth;//MAX(screenBound.size.width, screenBound.size.height);
    float screenHeight = tempHight;//MIN(screenBound.size.width, screenBound.size.height);
    float screenRadio = screenHeight/screenWidth;
    
    float imageWidth = imageSize.width;
    float imageHeight = imageSize.height;
    float imageRadio = imageHeight/imageWidth;
    
    CGRect  imageRect = CGRectZero;
    if (screenRadio<imageRadio)
    {
        float radio = screenWidth/imageWidth;
        float offsetheigh = imageSize.height*radio - screenHeight;
        float realHeight = imageHeight*radio;
        imageRect = CGRectMake((R.origin.x)/realHeight*imageSize.height,
                               (R.origin.y+offsetheigh/2)/screenWidth*imageSize.width,
                               R.size.width/realHeight*imageSize.height,
                               R.size.height/screenWidth*imageSize.width);
        
        //设置暂停画面frame
        //        [pauseBgView setFrame:CGRectMake(0, -offsetheigh/2.0f, screenWidth, screenHeight+offsetheigh)];
    }else
    {
        float radio = screenHeight/imageHeight;
        float offsetWidth = imageSize.width*radio - screenWidth;
        float realWith = imageWidth*radio;
        imageRect = CGRectMake((R.origin.x+offsetWidth/2)/screenHeight*imageSize.height,
                               (R.origin.y)/realWith*imageSize.width,
                               R.size.width/screenHeight*imageSize.height,
                               R.size.height/realWith*imageSize.width);
        //设置暂停画面frame
        //        [pauseBgView setFrame:CGRectMake(-offsetWidth/2.0f, 0, screenWidth+offsetWidth, screenHeight)];
    }
    
    return imageRect;
}

//获取摄像头位置
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == position)
        {
            return device;
        }
    }
    return nil;
}

//对焦
- (void)fouceMode{
    NSError *error;
    AVCaptureDevice *device = [self cameraWithPosition:AVCaptureDevicePositionBack];
    if ([device isFocusModeSupported:AVCaptureFocusModeAutoFocus])
    {
        if ([device lockForConfiguration:&error]) {
            CGPoint cameraPoint = [self.preview captureDevicePointOfInterestForPoint:self.view.center];
            [device setFocusPointOfInterest:cameraPoint];
            [device setFocusMode:AVCaptureFocusModeAutoFocus];
            [device unlockForConfiguration];
        } else {
            NSLog(@"Error: %@", error);
        }
    }
}

#pragma mark - ButtonAction
//返回按钮按钮点击事件
- (void)backAction{
    switch (self.exIdCardIndex) {
        case cardType_ID:
//            [((YMIDCardEngine *)[singleClass performSelector:NSSelectorFromString(@"ymIDCardEngine")]) ymClearAll_ID];
            [_ymIDCardEngine ymClearAll_ID];
            break;
            
        case cardType_JZ:
//            [((YMIDCardEngine *)[singleClass performSelector:NSSelectorFromString(@"ymIDCardEngine")]) ymClearAll_JZ];;
             [_ymIDCardEngine ymClearAll_JZ];
            break;
            
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.blockComplete) {
        self.blockComplete(@{@"status":@"fail",@"errMsg":@"用户进行了取消操作"});
    }
}

//闪光灯按钮点击事件
- (void)flashBtn{
    
    AVCaptureDevice *device = [self cameraWithPosition:AVCaptureDevicePositionBack];
    if (![device hasTorch]) {
        //        NSLog(@"no torch");
    }else{
        [device lockForConfiguration:nil];
        if (!_on) {
            [device setTorchMode: AVCaptureTorchModeOn];
            _on = YES;
        }
        else
        {
            [device setTorchMode: AVCaptureTorchModeOff];
            _on = NO;
        }
        [device unlockForConfiguration];
    }
}

//隐藏状态栏
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

CG_INLINE CGRect
CGRectMakeBack(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    
//    if (SYSTEM_HEIGHT==480) {
//        rect.origin.y = y-20;
//        rect.origin.x = x;
//        rect.size.width = width;
//        rect.size.height = height;
//    }else{
//        rect.origin.x = x * SYSTEM_WIDTH/320;
//        rect.origin.y = y * SYSTEM_HEIGHT/568;
//        rect.size.width = width * SYSTEM_WIDTH/320;
//        rect.size.height = height * SYSTEM_HEIGHT/568;
//
//    }
    rect.origin.y = y-20;
    rect.origin.x = x;
    rect.size.width = width;
    rect.size.height = height;
    
    return rect;
}

CG_INLINE CGRect
CGRectMakeFlash(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    
    if (SYSTEM_HEIGHT==480) {
        rect.origin.y = y-20;
        rect.origin.x = x;
        rect.size.width = width;
        rect.size.height = height;
    }else{
        rect.origin.x = x * SYSTEM_WIDTH/320;
        rect.origin.y = y * SYSTEM_HEIGHT/568;
        rect.size.width = width * SYSTEM_WIDTH/320;
        rect.size.height = height * SYSTEM_HEIGHT/568;
        
    }
    return rect;
}

-(void)bcrResultCallbackWithValue:(NSInteger)value
{
    bcrResultValue = value;
}

@end
