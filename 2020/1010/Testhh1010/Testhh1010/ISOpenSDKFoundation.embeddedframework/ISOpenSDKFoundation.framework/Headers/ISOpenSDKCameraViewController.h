//
//  ISOpenSDKCameraViewController.h
//  ISOpenSDKFoundation
//
//  Created by Simon Liu on 17/04/13.
//  Copyright © 2017年 xzliu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ISOpenSDKStatus.h"

typedef NS_ENUM(NSInteger, ISOpenPreviewSDKType)
{
    ISOpenPreviewSDKTypeBankCardReader = 1 << 0,
    ISOpenPreviewSDKTypeIDReader = 1 << 1,
    ISOpenPreviewSDKTypeDrivingLicense = 1 << 2,
    ISOpenPreviewSDKTypeVehicleLicense = 1 << 3,
    ISOpenPreviewSDKTypepassPort = 1 << 4,
    ISOpenPreviewSDKTypeBankCardReaderMini = 1 << 5,
    ISOpenPreviewSDKTypeCarInsurance = 1 << 6,
    
};

@protocol ISOpenSDKCameraViewControllerDelegate <NSObject>

@optional
//所有回调方法均在主线程返回
- (void)constructResourcesDidFinishedWithStatusCode:(ISOpenSDKStatus)status;//相机模块初始化SDK回调
- (void)accessCameraDidFailed;//相机模块授权失败SDK回调
- (void)cameraViewController:(UIViewController *)viewController didFinishDetectCardWithResult:(int)result borderPoints:(NSArray *)borderPoints;//相机模块边缘检测回调
- (void)cameraViewController:(UIViewController *)viewController didFinishRecognizeCard:(NSDictionary *)resultInfo cardSDKType:(ISOpenPreviewSDKType)sdkType;//相机模块识别结果回调
- (void)cameraViewController:(UIViewController *)viewController didClickCancelButton:(id)sender;//相机模块返回按钮点击回调

@end

@interface ISOpenSDKCameraViewController : UIViewController

- (instancetype)initWithPreviewSDKType:(ISOpenPreviewSDKType)previewSDKType appkey:(NSString *)appKey subAppkey:(NSString *)subAppkey;

@property (nonatomic, assign) BOOL needShowBackButton;//是否显示右上角返回按钮
@property (nonatomic, assign) BOOL needShowflashLightButton;//是否显示左上角闪光灯按钮
@property (nonatomic, assign) BOOL shouldHightlightCorners;//找边成功之后是否高亮显示
@property (nonatomic, strong) UIView *coverView;//相机界面出现前的遮盖界面，默认为空，不显示
@property (nonatomic, weak) id<ISOpenSDKCameraViewControllerDelegate>delegate;
@property (nonatomic, copy) NSString *customInfo;//自定义文字信息
@property (nonatomic, assign) CGFloat customInfoFontOfSize;//自定义文字大小设置

@property (nonatomic, assign) NSInteger frameInterval;//识别帧数间隔，默认为系统每秒最小帧数／6，即30帧下为5
@property (nonatomic, assign) BOOL continousRecognize;//识别完成后是否继续返回识别结果，默认为NO。设置为Yes后将会在每次识别成功时调用识别结果回调方法。
@property (nonatomic, assign) BOOL debugMode;//开启debug log
@property (nonatomic, assign) BOOL addPictureSuffix;//YES选择加载图片为.png
@property (nonatomic, copy) NSString *idCardCoverContent;
@property (nonatomic, assign) BOOL isVerticalBool;

@property (nonatomic, assign) BOOL isExposureModeBool;
@property (nonatomic, assign) BOOL isRecognitionModeBool;

@property (nonatomic, assign) BOOL idCard_RecongitionMode;
@property (nonatomic, assign) BOOL idCard_Continuous_UniversalMode;
@property (nonatomic, assign) BOOL idCard_Continuous_HeadersMode;
@property (nonatomic, assign) BOOL idCard_continuous_EmblemMode;
@property (nonatomic, assign) BOOL idCard_Only_HeadersMode;
@property (nonatomic, assign) BOOL idCard_Only_EmblemMode;
@property (nonatomic, strong) UIColor *customInfoColor;
@property (nonatomic, assign) CGFloat customInfoTopFontSize;
@property (nonatomic, assign) CGFloat customInfoCenterFontSize;
@property (nonatomic, assign) BOOL isOpenDefaultHintCCBImage;
@property (nonatomic, assign) BOOL isPlaySound;
@end
