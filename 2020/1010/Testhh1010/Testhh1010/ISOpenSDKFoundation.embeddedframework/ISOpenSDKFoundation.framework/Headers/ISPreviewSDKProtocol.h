//
//  ISPreviewSDKProtocol.h
//  ISOpenSDKFoundation
//
//  Created by Felix Liu on 15/12/22.
//  Copyright © 2015年 IntSig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISOpenSDKStatus.h"
#import <CoreMedia/CoreMedia.h>

typedef void(^DetectCardFinishHandler)(int result, NSArray *borderPointsArray);
typedef void(^RecognizeCardFinishHandler)(NSDictionary *cardInfo);
typedef void(^ConstructResourcesFinishHandler)(ISOpenSDKStatus status);

@protocol ISPreviewSDKProtocol <NSObject>

@optional

+ (id)sharedISOpenSDKController;
- (void)constructResourcesWithAppKey:(NSString *)appKey subAppkey:(NSString *)subAppKey finishHandler:(ConstructResourcesFinishHandler)handler;
- (ISOpenSDKStatus)detectCardWithOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
                                           cardRect:(CGRect)rect//rect should be a golden rect for credit cards that are shaped with its proportions
                            detectCardFinishHandler:(DetectCardFinishHandler)detectCardFinishHandler
                         recognizeCardFinishHandler:(RecognizeCardFinishHandler)recognizeFinishHandler;
- (void)destructResources;

@end
