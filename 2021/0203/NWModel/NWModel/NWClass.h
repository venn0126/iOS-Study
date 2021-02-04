//
//  NWClass.h
//  NWModel
//
//  Created by Augus on 2021/2/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_OPTIONS(NSUInteger, NWEncodeType){
    
    NWEncodeTypeMask            = 0xFF,/// <mask of type value
    NWEncodeTypeUnknown         = 0,/// < unknown
    NWEncodeTypeVoid            = 1,/// < void
    NWEncodeTypeBool            = 2,/// <bool
    
};

@interface NWClass : NSObject

- (nullable instancetype)initWithName:(NSString *)name;

- (void)logName;

@end

NS_ASSUME_NONNULL_END
