//
//  FOSDetectController.m
//  InteractiveDemo
//
//  Created by Wei Niu on 2018/11/13.
//  Copyright © 2018年 Fosafer. All rights reserved.
//

#import "FOSDetectController.h"
#import <CoreMotion/CoreMotion.h>
#import <FosaferAuth/FosaferAuth.h>


#define FOSAPPID        @"28804005"
#define FOSKEY          @"4c6e9a81-13fd-4f3d-885a-9a1520958846"

#define kAliveSdkType   @"alivedet"
// 中互金
#define kAliveLicense   @"BxVduY9MDUDqFdqh"
#define kAliveBundleID  @"Co.-Ltd..FosaferAuthAliveDet"


@interface FOSDetectController ()<FOSAuthenticatorDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *hintLabel;

@end

@implementation FOSDetectController{
    
    FOSAuthenticator *_authenticator;
    AVCaptureSession *_cachedSession;
    
    BOOL _isPop;
    BOOL _finished;
    BOOL _isISuccessd;
    BOOL _isOverTime;
    
    int _lastAction;
    int _currentAction;
    int _continuousPlay;
    
    NSString *_errMsg;
    CMMotionManager *_motionManager;
    
    UIImage *_blockImage;

    
    
}

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self checkCameraPermission:YES]) {
        [self startDetect];
    }
    [UIScreen mainScreen].brightness = 1.0;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
 
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _isPop = YES;
    [self stopMotionDetect];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_authenticator cancel];
    [UIScreen mainScreen].brightness = 0.7;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"交互式活体检测";
    self.view.backgroundColor = [UIColor blackColor];
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

- (void)startDetect {
    
    if (_motionManager) {
        [self stopMotionDetect];
    }
    [self startMontionDetect];
    
    _currentAction = -10;
    _lastAction = -1;
    _isOverTime = NO;
    _isISuccessd = NO;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:FOSAPPID forKey:FOS_KEY_APP_ID];
    [params setObject:FOSKEY forKey:FOSAFER_APPKEY];
    
    [params setObject:kAliveSdkType forKey:FOS_KEY_SDK_TYPE];
    [params setObject:kAliveLicense forKey:FOS_KEY_SDK_LICENSE];
    [params setObject:kAliveBundleID forKey:FOS_KEY_LICENSE_BUNDLEID];
    
    [params setObject:[NSNumber numberWithInt:EFace] forKey:FOS_KEY_AUTH_TYPE];
    [params setObject:[UIColor clearColor] forKey:FOS_KEY_FACE_OBJECT_COLOR];
    
    CGFloat pre_scale = 0.7;
    if (self.view.bounds.size.height >= 812) {
        pre_scale = 0.8;
    }
    [params setObject:[NSNumber numberWithFloat:pre_scale] forKey:FOS_CAMERA_PREVIEWLAYER_SCALE];
    
    // 设置交互活体检测类型
    // aliveAction是sdk支持的检测类型
    // 0 随机一种动作 眨眼 左摇 又摇 点头
    // 3眨眼+左摇 5眨眼+右摇 9眨眼+点头
    // 11眨眼+左摇+点头 13眨眼+右摇+点头
    NSInteger aliveAction = self.index;
    NSLog(@"检测类型 %ld",(long)self.index);
    [params setObject:[NSNumber numberWithInteger:aliveAction] forKey:FOS_INTERACTIVE_ALIVE_DETECT_TYPE];
    
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
                FOSLogDebug(@"prepare error: %@", result);
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
                    [self alertTitle:@"发生错误" message:str type:0];
                    
                } else {
                    NSString *msg = [result objectForKey:@"msg"];
                    int code = [[result objectForKey:@"code"] intValue];
                    [self alertTitle:@"发生错误" message:[NSString stringWithFormat:@"发生错误：%@\n code : %d", msg,code] type:0];
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
    FOSLogDebug(@"authenticatorDidStartWorking");
    // 默认10s主动结束
//    __weak typeof(self) wealSelf = self;
    NSInteger delayInSeconds = 10;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self->_finished) {
            return;
        }
        if (_isPop) {
            return;
        }
        AudioServicesPlaySystemSound(1111);
        [_authenticator finishWorking];
        
        [self alertTitle:@"发生错误" message:@"活体检测失败:操作超时" type:1];
        _isISuccessd = NO;
        
    });
}

- (void)authenticator:(FOSAuthenticator *)authenticator faceInfo:(NSDictionary *)faceInfo {
    
    FOSLogDebug(@"p竖直。。。。。%@--%@",@(self.isPortrait),faceInfo);
    if (!self.isPortrait) {
        self.hintLabel.text = @"请竖直手机";
        return;
    }
    
    int aliveResult = [[faceInfo objectForKey:@"detect_result"] intValue];
    FOSLogDebug(@"准备阶段 %d",aliveResult);
    
    BOOL large = [[faceInfo objectForKey:@"fos_large"] boolValue];
    BOOL small = [[faceInfo objectForKey:@"fos_small"] boolValue];
    BOOL dark = [[faceInfo objectForKey:@"fos_dark"] boolValue];
    BOOL bright = [[faceInfo objectForKey:@"fos_bright"] boolValue];
    
    // -1 info face_status = 0 没有人脸
    // -1 info face_status = 0 > 0 提示信息，
    if (aliveResult == -1) {// 准备阶段
        
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
        return;
    }
    // 检测阶段关闭竖直
    [self stopMotionDetect];
    
//    __weak typeof(self) wealSelf = self;
    if (aliveResult == -4 || aliveResult == -3) {
        
        if (aliveResult == -3) {
            _errMsg = @"活体检测失败:请按照要求做动作";
        } else { // 动作跟提示不符 -4
            _errMsg = @"活体检测失败:动作幅度过大";
        }
        AudioServicesPlaySystemSound(1111);
        if (_isPop) {
            return;
        }
        
        [self alertTitle:@"发生错误" message:_errMsg type:1];
        
        self->_finished = YES;
        [authenticator finishWorking];
        _isISuccessd = NO;
        return;
    }
    
    
    // 回传动作说明 0:眨眼 1:左摇 2:右摇 3:点头
    if (_currentAction == -10) {
        int firstAction = [[faceInfo objectForKey:@"alive_action"] intValue];
        [self hintLabelToAction:firstAction];
        // 第一次检测进行语音提示
    }
    
    _currentAction = [[faceInfo objectForKey:@"alive_action"] intValue];
    FOSLogDebug(@"动作 %d-------结果 %d",_currentAction,aliveResult);
    
    if (aliveResult == 0) {// 检测完成
        
        [authenticator finishWorking];
        self->_finished = YES;
        _isISuccessd = YES;
        return;
    }
    
    
    FOSLogDebug(@"last action first is %d--%d",_lastAction,_currentAction);
    if (_lastAction != _currentAction) {
        
        [self hintLabelToAction:_currentAction];
        //自定义语音提示功能
        _continuousPlay = 0;
    }
    _continuousPlay++;
    int continuous_frame = 50;
    if (self.hintLabel.text.length != 3) {
        continuous_frame = 65;
    }
    if (_continuousPlay % continuous_frame == 0) {
        //自定义语音提示功能
    }
    
    _lastAction = _currentAction;
    
}


- (void)authenticatorDidEndCollecting:(FOSAuthenticator *)authenticator {
    FOSLogDebug(@"authenticatorDidEndCollecting");
    if (_isISuccessd) {
        self.hintLabel.text = @"数据采集结束,请等待...";
    }
    
}

- (void)authenticator:(FOSAuthenticator *)authenticator collectedImages:(NSArray *)images {
    // call back image
    NSData *data = images.firstObject;
    _blockImage = [UIImage imageWithData:data];

}

- (void)authenticator:(FOSAuthenticator *)authenticator error:(NSError *)error {
    
    FOSLogError(@"error: %@", error);
    NSDictionary *errorDict = error.userInfo;
    NSString *error_msg = [errorDict objectForKey:@"msg"];
    if (error_msg.length > 0) {
        _errMsg = error_msg;
    } else if(![error localizedDescription]){
        _errMsg = [error localizedDescription];
    } else {
        _errMsg = @"网络异常,请稍后再试";
    }
    
    if (!_isISuccessd || _isOverTime || _isPop) {
        return;
    }
    AudioServicesPlaySystemSound(1111);
    [self alertTitle:@"发生错误" message:_errMsg type:1];
    error = nil;
}


- (void)authenticator:(FOSAuthenticator *)authenticator result:(NSDictionary *)result {
    
    FOSLogDebug(@"infoooo----%@",result);
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
    if (_isISuccessd) {
        AudioServicesPlaySystemSound(1111);
        NSDictionary *parseDict = [result objectForKey:@"parsedResults"];
        if (parseDict.count > 0) {
            NSInteger code = [[parseDict objectForKey:@"code"] integerValue];
            
            if (code == 0) {
                if (_isISuccessd) {
                    _errMsg = @"活体检测成功";
                    self.hintLabel.text = @"活体检测成功";
                    if (_isPop) {
                        return;
                    }

                    [self alertTitle:@"成功" message:_errMsg type:0];
                }
            } else {
                _errMsg = @"活体检测失败:请本人完成动作";
                if (_isPop) {
                    return;
                }
                [self alertTitle:@"发生错误" message:_errMsg type:1];
            }
        }
    }
}

#pragma mark -  Motion action

- (void)startMontionDetect{
    
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.accelerometerUpdateInterval = 1;
    }
    [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
        if (!error) {
            [self outputAccelertionData:accelerometerData.acceleration];
        }else{
            FOSLogDebug(@"motion manger error :%@", error);
        }
    }];
}

- (void)outputAccelertionData:(CMAcceleration)acceleration{
    
    if (acceleration.y <= -0.95) {
        // 竖直方向
        self.isPortrait = YES;
    }else {
        self.isPortrait = NO;
    }
}

- (void)stopMotionDetect {
    if (_motionManager) {
        [_motionManager stopAccelerometerUpdates];
        _motionManager = nil;
    }
}



#pragma mark - other action

// check camera permission
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

- (void)alertTitle:(NSString *)title message:(NSString *)message type:(NSInteger)type{
    __weak typeof (self)weakSelf = self;
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * action) {
                                                if (_blockImage != nil) {
                                                    weakSelf.imageCallBack(_blockImage);
                                                }
                                                [self.navigationController popViewControllerAnimated:YES];
                                            }]];
    if (type == 1) {
        [alert addAction:[UIAlertAction actionWithTitle:@"再试一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self startDetect];

        }]];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

/// 输入对应的aciton 提示相应动作
- (void)hintLabelToAction:(int)action {
    
    if (action == 0) {
        self.hintLabel.text = @"请眨眼";
    } else if (action == 1) {
        self.hintLabel.text = @"请向左转头";
    } else if(action == 2) {
        self.hintLabel.text = @"请向右转头";
    }else if(action == 3) {
        self.hintLabel.text = @"请点头";
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
