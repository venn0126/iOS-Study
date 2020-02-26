//
//  FosNumber.m
//  CircleAnimation
//
//  Created by Augus on 2019/12/13.
//  Copyright © 2019 fosafer. All rights reserved.
//

#import "FosNumber.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>



@implementation FosNumber


+(NSString *)myNumber{

        return CTSettingCopyMyPhoneNumber();

}

@end
