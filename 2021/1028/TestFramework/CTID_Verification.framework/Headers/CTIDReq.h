//
//  CTIDReq.h
//  CTIDSDK
//
//  Created by 万启鹏 on 2019/2/13.
//  Copyright © 2019 wan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTIDReq : NSObject
///随机数
@property (nonatomic, copy) NSString *randomNumber;
///机构ID
@property (nonatomic, copy) NSString *organizeId;
///APPid
@property (nonatomic, copy) NSString *appId;
///凭证数据
@property (nonatomic, copy) NSString *ctid;
///二维码数据
@property (nonatomic, copy) NSString *qrCode;

///1、 获取二维码申请数据    type=0，二维码赋码申请数据定义的 applyData；  type=1，二维码验码申请数据定义的 applyData。
///2、 获取ID验证数据       0-无卡认证，3-无卡下载
@property (nonatomic, assign) NSInteger type;



/// 用户APP的 urlScheme
@property (nonatomic, copy) NSString *urlScheme;

@end



NS_ASSUME_NONNULL_END
