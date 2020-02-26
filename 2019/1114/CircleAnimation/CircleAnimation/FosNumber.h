//
//  FosNumber.h
//  CircleAnimation
//
//  Created by Augus on 2019/12/13.
//  Copyright © 2019 fosafer. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <CoreTelephony/>


extern NSString * _Nullable CTSettingCopyMyPhoneNumber(void);



NS_ASSUME_NONNULL_BEGIN

@interface FosNumber : NSObject

+(NSString *)myNumber;

@end

NS_ASSUME_NONNULL_END
