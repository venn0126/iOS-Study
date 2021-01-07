#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "IGuide.h"
#import "IGuideAnnotationViewModelProtocol.h"
#import "IGuideAnnotationViewProtocol.h"
#import "IGuideAppleAnnotationView.h"
#import "IGuideButton.h"
#import "IGuideIndicatorLineView.h"
#import "IGuideIndicatorTriangleView.h"
#import "IGuideItem.h"
#import "IGuideJerryAnnotationView.h"
#import "IGuideTomAnnotationView.h"
#import "IGuideViewController.h"
#import "NSNumber+Guide.h"
#import "UIColor+Guide.h"
#import "UIView+Guide.h"

FOUNDATION_EXPORT double IGuideVersionNumber;
FOUNDATION_EXPORT const unsigned char IGuideVersionString[];

