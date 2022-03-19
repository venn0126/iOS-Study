//
//  ViewController.h
//  TestStingNil
//
//  Created by Augus on 2021/11/11.
//

#import <UIKit/UIKit.h>


/**
 
 /// Foundation Class Type
 typedef NS_ENUM (NSUInteger, YYEncodingNSType) {
     YYEncodingTypeNSUnknown = 0,
     YYEncodingTypeNSString,
     YYEncodingTypeNSMutableString,
     YYEncodingTypeNSValue,
     YYEncodingTypeNSNumber,
     YYEncodingTypeNSDecimalNumber,
     YYEncodingTypeNSData,
     YYEncodingTypeNSMutableData,
     YYEncodingTypeNSDate,
     YYEncodingTypeNSURL,
     YYEncodingTypeNSArray,
     YYEncodingTypeNSMutableArray,
     YYEncodingTypeNSDictionary,
     YYEncodingTypeNSMutableDictionary,
     YYEncodingTypeNSSet,
     YYEncodingTypeNSMutableSet,
 };
 */



typedef NS_OPTIONS(NSInteger, AugusCellType) {
    AugusCellTypeNone = 0,
    AugusCellTypeHistory = 1 << 0,
    AugusCellTypeHotWords = 1 << 1,
    AugusCellTypeHotList = 1 << 2,
};

@interface ViewController : UIViewController


@end

