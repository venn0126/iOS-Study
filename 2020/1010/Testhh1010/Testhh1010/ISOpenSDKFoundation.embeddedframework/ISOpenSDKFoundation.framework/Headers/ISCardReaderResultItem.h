//
//  ISCardReaderResultItem.h
//  ISIDReaderSDK
//
//  Created by Felix on 15/8/13.
//  Copyright (c) 2015年 IntSig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString * const kOpenSDKCardResultTypeOriginImage;//origin image(原图)
extern NSString * const kOpenSDKCardResultTypeImage;//cropped image(切边后的图)
extern NSString * const kOpenSDKCardResultTypeHeadImage;//headImage(头像)
extern NSString * const kOpenSDKCardResultTypeCardName;//card name(卡/证名,字符串值)
extern NSString * const kOpenSDKCardResultTypeCardType;//card type(卡/证类型,整型值)
extern NSString * const kOpenSDKCardResultTypeCardItemInfo;//card item info dictionary(卡/证的详细信息)
extern NSString * const kOpenSDKCardResultTypeCardRotate;//origin image rotate(原图的旋转角度，暂时只可能返回0,90,180,270)

@interface ISCardReaderResultItem : NSObject

@property (nonatomic, copy) NSString *itemName;//item name, may be nil(每个条目的名称，可能为空)
@property (nonatomic, copy) NSString *itemValue;//item value(每个条目的值)
@property (nonatomic, strong) NSArray *pointsInOriginImage;//the position of the item in original image, contains four points. Left top, right top, right bottom and left bottom. May be nil.(每个条目在原图中的坐标位置，一共四个点，从左上顺时针到左下)
@property (nonatomic, assign) CGRect rectInCroppedImage;//the rect of the item in cropped image(每个条目在原图切边后的图中的坐标区域矩形)
@property (nonatomic, strong) UIImage *itemCroppendImage;//the cropped image of the item(每个条目的切边图)

@end
