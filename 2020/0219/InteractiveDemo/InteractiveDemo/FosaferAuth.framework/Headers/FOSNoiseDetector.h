//
//  FOSNoiseDetector.h
//  Fosafer
//
//  Created by Fosafer on 1/21/16.
//  Copyright © 2016 Fosafer, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FOS_NOISE_DETECT_ERROR_NO_ENOUGH_DATA 1

@interface FOSNoiseDetector : NSObject

- (BOOL)noiseDetect:(NSInteger)detectTimeMillis error:(__autoreleasing NSError **)error;

@end
