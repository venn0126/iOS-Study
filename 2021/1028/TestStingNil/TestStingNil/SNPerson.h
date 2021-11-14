//
//  SNPerson.h
//  TestStingNil
//
//  Created by Augus on 2021/11/13.
//

#import <Foundation/Foundation.h>
@class SNAppConfig;
@class SNAppConfigABTest;

NS_ASSUME_NONNULL_BEGIN

@interface SNPerson : NSObject

+ (instancetype)shared;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) SNAppConfig *config;

- (void)updateConfig;

- (void)requestConfigAsync;

- (SNAppConfigABTest *)configABTest;








@end

NS_ASSUME_NONNULL_END
