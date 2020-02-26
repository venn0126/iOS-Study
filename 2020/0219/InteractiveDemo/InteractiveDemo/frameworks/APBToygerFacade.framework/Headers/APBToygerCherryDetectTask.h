//
//  APFCherryDetectTask.h
//  APBToygerFacade
//
//  Created by richard on 01/02/2018.
//  Copyright © 2018 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BioAuthEngine/AFEStatusBar.h>
#import "APBToygerDetectTask.h"
#import "APBToygerBaseTask.h"
#import <BioAuthEngine/BioAuthEngine.h>
#import <ZolozSensorServices/CameraService.h>
#import <ZolozSensorServices/MotionService.h>



@interface APBToygerCherryDetectTask : APBToygerBaseTask <ZolozCameraServiceDelegate, ZolozMotionServiceDelegate, IStatusBarDelegate,AFECircularViewProtocol>


@end
