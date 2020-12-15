//
//  ISCardReaderController.h
//  ISIDReaderOlmSDK
//
//  Created by Simon Liu on 2020/1/16.
//  Copyright © 2020 柳宣泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ISOpenSDKFoundation/ISOpenSDKFoundation.h>

extern NSString * const kCardItemName;//姓名
extern NSString * const kCardItemGender;//性别
extern NSString * const kCardItemNation;//民族
extern NSString * const kCardItemBirthday;//出生日期
extern NSString * const kCardItemAddress;//住址
extern NSString * const kCardItemIDNumber;//号码
extern NSString * const kCardItemIssueAuthority;//签发机关
extern NSString * const kCardItemValidity;//有效期限

typedef void(^ConstructResourcesFinishHandler)(ISOpenSDKStatus status);
typedef void(^RecognizeCardFinishHandler)(NSDictionary *cardInfo);

@interface ISCardReaderController : NSObject

+ (ISCardReaderController *)sharedController;

- (void)constructResourcesWithAppKey:(NSString *)appKey subAppkey:(NSString *)subAppKey finishHandler:(ConstructResourcesFinishHandler)handler;
- (ISOpenSDKStatus)processCardImage:(UIImage *)image
                  returnCroppedImage:(BOOL) croppedImage
                 returnPortraitImage:(BOOL) portraitImage
                   withFinishHandler:(RecognizeCardFinishHandler)handler;
- (void)destructResources;
+ (NSString *)getSDKVersion;

@end
