//
//  SlientAuthController.m
//  offFaceDemo
//
//  Created by Augus on 2020/2/24.
//  Copyright © 2020 fosafer. All rights reserved.
//

#import "SlientAuthController.h"
#import <CoreMotion/CoreMotion.h>
#import <FosaferAuth/FosaferAuth.h>
#import "FOSHeaderModel.h"
#import "FOSTool.h"

#define kTServer                 @"https://apicloud.fosafer.com"
#define kBioFaceContractId       @"D202008064889"
#define kBioFaceProductInfo      @"111111"
#define kAppName                 @"testapp"

#define kSlientLicense @"9qJiovOnmf4ib70F"
#define kSlientSdkType @"slientdet"
#define kSlientBundleID @"Co.-Ltd..FosaferAuthSlientDet"

typedef void(^alertFinish)(void);

@interface SlientAuthController ()<FOSAuthenticatorDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *hintLabel;

@end

@implementation SlientAuthController{
    
    FOSAuthenticator *_authenticator;
    NSString *_digits;
    AVCaptureSession *_cachedSession;
    CMMotionManager *_motionManager;

    
    CFTimeInterval _beginReadTime;
    CFTimeInterval _startCollectTime;
    NSInteger _step;
    
    // 手机是否竖直
    BOOL _isPortrait;
    // pop操作记录
    BOOL _isPop;
    // 完成当前流程记录
    BOOL _finished;
    // 记录当前流程的开始时刻
    BOOL _overTime;
    
    NSString *_offLine;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self checkCameraPermission:YES]) {
        [self startDetect];
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _isPop = YES;
    [_authenticator cancel];
    [self stopMotionDetect];
}

- (void)viewDidLoad {
//    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"静默检测";
    [self initSubviews];

}

- (void)initSubviews {
    
     self.imageView.frame = self.view.bounds;
     self.imageView.image = [UIImage imageNamed:@"face_scan_background"];
     [self.view addSubview:self.imageView];
     
     self.hintLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
     self.hintLabel.center = CGPointMake(self.view.center.x, self.view.center.y - 200);
     self.hintLabel.text = @"请对准检测框";
     [self.view addSubview:self.hintLabel];
     
    
    
}

- (void)alertTitle:(NSString *)title message:(NSString *)message cancel:(alertFinish)cancel confirm:(alertFinish)confirm {
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                 handler:^(UIAlertAction * action) {
            cancel();
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              
              confirm();
              
        }]];
    
        [self presentViewController:alert animated:YES completion:nil];
    });
}

- (void)alert:(NSString *)message finish:(alertFinish)finish {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {
            
            finish();
        }];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    });
}

- (BOOL)checkCameraPermission:(BOOL)block {
    __block BOOL hasCameraPermission = YES;
    NSString *mediaType = AVMediaTypeVideo;
    dispatch_semaphore_t waitCameraPermission = dispatch_semaphore_create(0);
    [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
        hasCameraPermission = granted;
        dispatch_semaphore_signal(waitCameraPermission);
    }];
    if (block) {
        dispatch_semaphore_wait(waitCameraPermission, DISPATCH_TIME_FOREVER);
    }
    if (!hasCameraPermission) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"无法使用相机"
                                                                       message:@"没有相机访问权限"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel
                                                handler:^(UIAlertAction * action) {}]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    return hasCameraPermission;
}

- (void)startDetect {
    [self startMontionDetect];
    _overTime = NO;
    _finished = NO;
    _isPop = NO;
    self.hintLabel.text = @"";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:EFace] forKey:FOS_KEY_AUTH_TYPE];
    [params setObject:[UIColor clearColor] forKey:FOS_KEY_FACE_OBJECT_COLOR];
    [params setObject:kTServer forKey:FOS_KEY_SERVER];
    
    _offLine = @"offLine";
    [params setObject:_offLine forKey:FOS_KEY_LINE];
    
    FOSHeaderModel *model = [FOSTool unArchivedModel];
    if (model.slientContractId.length > 0 && model.slientProductInfo && model.accessToken.length > 0) {
        [params setObject:model.slientContractId forKey:FOS_KEY_CONTRACT_ID];
        [params setObject:[NSString stringWithFormat:@"%lu",(unsigned long)model.slientProductInfo] forKey:FOS_KEY_PRODUCT_INFO];
        [params setObject:model.accessToken forKey:FOS_KEY_AUTHORIZATION];
    } else {
        [self alert:@"请先到设置页面获取token" finish:^{
            [self fos_pop];
        }];
        return;
    }
    [params setObject:kAppName forKey:FOS_KEY_APP_NAME];
    [params setObject:kSlientSdkType forKey:FOS_KEY_SDK_TYPE];
    [params setObject:kSlientLicense forKey:FOS_KEY_SDK_LICENSE];
    [params setObject:kSlientBundleID forKey:FOS_KEY_LICENSE_BUNDLEID];
    
    CGFloat pre_scale = 0.7;
    if (self.view.frame.size.height >= 812) {
        pre_scale = 0.8;
    }
    [params setObject:[NSNumber numberWithFloat:pre_scale] forKey:FOS_CAMERA_PREVIEWLAYER_SCALE];
    
    if (!_authenticator) {
        _authenticator = nil;
    }
    
    _authenticator = [[FOSAuthenticator alloc] initWithParams:params preview:self.view videoSession:_cachedSession];
    if (![_cachedSession isEqual:[_authenticator videoSession]]) {
        _cachedSession = [_authenticator videoSession];
    }
    
    __block FOSAuthenticator *authenticator = _authenticator;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
        id result = [authenticator prepare];
        if (result == nil) {
            dispatch_async(dispatch_get_main_queue(), ^() {
                
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^() {
                authenticator = nil;
                NSLog(@"prepare error: %@", result);
                __weak typeof(self)weakSelf = self;
                if ([result isKindOfClass:[NSError class]]) {
                    NSError *error = result;
                    NSDictionary *dict = error.userInfo;
                    NSString *msg = [dict objectForKey:@"msg"];
                    NSString *str = @"";
                    if (msg.length > 0) {
                        str = [NSString stringWithFormat:@"发生错误：%@\n code : %ld", msg,(long)error.code];
                    }else {
                        str = [NSString stringWithFormat:@"发生错误: %@\n code : %ld\n",[error localizedDescription],(long)error.code];
                    }
                    [weakSelf alert:str finish:^{
                                            [weakSelf.navigationController popViewControllerAnimated:YES];

                                        }];
                } else {
                    NSString *msg = [result objectForKey:@"msg"];
                    int code = [[result objectForKey:@"code"] intValue];
                    [weakSelf alert:[NSString stringWithFormat:@"发生错误：%@\n code : %d", msg,code] finish:^{
                                            [weakSelf.navigationController popViewControllerAnimated:YES];

                                        }];
                }
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^() {
            [authenticator startWorking];
            authenticator.delegate = self;
            authenticator = nil;
        });
    });
}

#pragma mark - FOSAuthenticator Delegate

- (void)authenticatorDidStartWorking:(FOSAuthenticator *)authenticator {
    NSLog(@"authenticatorDidStartWorking");
    _startCollectTime = CACurrentMediaTime();
    
}

- (void)authenticator:(FOSAuthenticator *)authenticator faceInfo:(NSDictionary *)faceInfo {

    // 超时判断
    __weak typeof(self) weakSelf = self;
    NSInteger delayInSeconds = 10;
    CFTimeInterval detectTime = CACurrentMediaTime() - _startCollectTime;
    if (detectTime > delayInSeconds) {
        if (_finished || _isPop) {
            return;
        }
        _overTime = YES;
        [authenticator cancel];
        [weakSelf stopMotionDetect];
         __weak typeof(self)weakSelf = self;
            [weakSelf alertTitle:@"" message:@"操作超时" cancel:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            } confirm:^{
                [weakSelf startDetect];
            }];
        return;
    }
    
    int detectResult = [[faceInfo objectForKey:@"detect_result"] intValue];
    
    if (!_isPortrait) {
        self.hintLabel.text = @"请竖直手机";
        return;
    }
   

    BOOL large = [[faceInfo objectForKey:@"fos_large"] boolValue];
    BOOL small = [[faceInfo objectForKey:@"fos_small"] boolValue];
    BOOL dark = [[faceInfo objectForKey:@"fos_dark"] boolValue];
    BOOL bright = [[faceInfo objectForKey:@"fos_bright"] boolValue];
    
    if(!dark){
        self.hintLabel.text = @"光线不足";
    }else if(!bright){
        self.hintLabel.text = @"光线过强";
    }else if (!large) {
        self.hintLabel.text = @"请远离一点";
    } else if(!small){
        self.hintLabel.text = @"请靠近一点";
    } else {
        self.hintLabel.text = @"请将人脸移入框内";

    }

    // 检测阶段关闭竖直
     [self stopMotionDetect];
    if (detectResult == 0) {
        _finished = YES;
        [_authenticator finishWorking];
        self.hintLabel.text = @"检测完成";
    }
    
}

- (void)authenticatorDidEndCollecting:(FOSAuthenticator *)authenticator {
    NSLog(@"authenticatorDidEndCollecting");
    
    
    if (_isPop || _overTime) {
        return;
    }
    self.hintLabel.text = @"数据采集完成";
    // 进行自定义网络逻辑
//    if ([_offLine isEqualToString:@"offLine"]) {
//        [self fos_slientAuth];
//    }
    
    
    [self fos_pop];
}

- (void)authenticator:(FOSAuthenticator *)authenticator collectedImages:(NSArray *)images {
    for (NSData *image in images) {
        NSLog(@"人脸图像数据: %ld", (long)[image length]);
    }
    
    
    if ([_offLine isEqualToString:@"offLine"]) {
        
        FOSHeaderModel *model = [FOSTool unArchivedModel];
        if (!model) {
            model = [[FOSHeaderModel alloc] init];
        }
        
        if (images.count == 1) {
            model.imageData = images.firstObject;
        }else if(images.count == 2){
            
            model.faceInfo = images.firstObject;
            model.imageData = images[1];
        }
        [FOSTool saveModel:model];
    }
    
}

- (void)authenticator:(FOSFaceModeler *)authenticator error:(NSError *)error {
    NSLog(@"error: %@", error);
    self.hintLabel.text = @"";
    NSDictionary *userInfo = error.userInfo;
    
    if (_isPop || _overTime) {
        return;
    }
    
    NSString *msg;
    NSString *dicMsg = [userInfo objectForKey:@"msg"];
    NSString *localMsg = [error localizedDescription];
    
    if (dicMsg.length > 0) {
        msg = dicMsg;
    }else if(localMsg.length > 0){
        msg = localMsg;
    }else {
        msg = @"未知错误";
    }
    __weak typeof(self)weakSelf = self;

    [self alertTitle:@"" message:msg cancel:^{
          [weakSelf.navigationController popViewControllerAnimated:YES];
      } confirm:^{
          [weakSelf startDetect];
      }];
    error = nil;
}

// 在线模式才会走此方法
- (void)authenticator:(FOSFaceModeler *)authenticator result:(NSDictionary *)result {
    
    NSLog(@"infoooo----%@",result);
    
    NSError *error = [result objectForKey:@"error"];
    if (error) {
        if (error.code == FOS_ERROR_CONNECTION_TIMED_OUT) {
            // TODO 网络连接超时
        } else if (error.code == FOS_ERROR_CANNOT_CONNECT_TO_HOST) {
            // TODO 无法连接到服务器
        } else if (error.code == FOS_ERROR_CONNECTION_LOST) {
            // TODO 网络连接丢失
        }
        return;
    }
    

    __weak typeof(self) weakSelf = self;
    NSDictionary *parsedResults = [result objectForKey:@"parsedResults"];
    NSInteger code = [[parsedResults objectForKey:@"code"] integerValue];
    if (code == 0) {
        [weakSelf alert:@"静默识别成功" finish:^{
            [weakSelf fos_pop];
        }];
    }else {
        [weakSelf alertTitle:@"静默识别失败" message:parsedResults[@"msg"] cancel:^{
            [weakSelf startDetect];
        } confirm:^{
            [weakSelf fos_pop];
        }];
    }
}


#pragma mark - montion

- (void)startMontionDetect{
    
    if (_motionManager) {
        [self stopMotionDetect];
    }
    
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.accelerometerUpdateInterval = 1;
    }
    [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
        if (!error) {
            [self outputAccelertionData:accelerometerData.acceleration];
        }else{
            NSLog(@"motion manger error :%@", error);
        }
    }];
}

- (void)outputAccelertionData:(CMAcceleration)acceleration{
    
    if (acceleration.y <= -0.95) {
        //        NSLog(@"竖直方向");
        _isPortrait = YES;
    }else {
        _isPortrait = NO;
    }
}

- (void)stopMotionDetect {
    if (_motionManager) {
        [_motionManager stopAccelerometerUpdates];
        _motionManager = nil;
    }
}


#pragma mark - Privacy Action

- (void)fos_pop {
    
    [self.navigationController popViewControllerAnimated:YES];
    [_authenticator cancel];
}
#pragma mark - Getter & Setter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [_imageView sizeToFit];
    }
    return _imageView;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.textColor = [UIColor redColor];
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        _hintLabel.font = [UIFont systemFontOfSize:20];
        
    }
    return _hintLabel;
}



@end
