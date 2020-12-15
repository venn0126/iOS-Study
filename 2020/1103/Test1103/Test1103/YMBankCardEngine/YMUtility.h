//
//  YMUtility.h
//  BCR
//
//  Created by bigfish on 9/9/09.
//  Copyright 2009 hyugahinat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>

@interface YMUtility : NSObject {

}

+ (void)warningAlertWithMessage:(NSString *)mes;
+ (void)informationAlertWithMessage:(NSString *)mes;


+ (CGContextRef) CreateARGBBitmapContext:(CGImageRef) image;
+ (BOOL) GetYDataFromImage:(UIImage *)image 
							   pixels:(unsigned char **)pixels;
//+ (BOOL) GetYDataFromImageVideo:(UIImage *)image
//                    pixels:(unsigned char **)pixels;
+ (int) SaveImageBMP:(NSString *)filename
								data:(unsigned char **)pYDataBuf
								width:(int) width
								height:(int)height;
//+ (void) createProgressionAlertWithMessage:(NSString *)message withActivity:(BOOL)activity;
+ (CGFloat) distanceBetweenPoints: (CGPoint) first toPoint: (CGPoint) second;

UIImage* resizedImage(UIImage *inImage, CGRect thumbRect);
+ (UIImage *) createRoundedRectImage:(UIImage*)image size:(CGSize)size;
@end
