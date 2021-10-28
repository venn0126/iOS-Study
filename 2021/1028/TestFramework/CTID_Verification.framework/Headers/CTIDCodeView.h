//
//  CTIDCodeView.h
//  CTIDVerifyCode
//
//  Created by vince on 2018/8/24.
//  Copyright © 2018年 yuw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTIDCodeView : UIView

//0 获取控件版本号
+(NSString *)getAuthIDCardDataVer;

/// 1 初始化资源
/// @param randomNumber 随机数
-(instancetype)initWithRandomNumber:(NSString *)randomNumber;

///2  getAuthCodeData     获取网证口令数据
@property (nonatomic,copy) void (^getAuthCodeData)(NSDictionary *resultDict);




@end
