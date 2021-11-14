//
//  SNPerson.m
//  TestStingNil
//
//  Created by Augus on 2021/11/13.
//

#import "SNPerson.h"
#import "SNSon.h"
#import "SNAppConfig.h"
#import "SNAppConfigABTest.h"

@interface SNPerson ()

@property (nonatomic, strong) NSMutableDictionary *tempConfig;

@end

@implementation SNPerson {
    
    
    SNSon *_son;
}

+ (instancetype)shared {
    
    static SNPerson *person = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        person = [[self alloc] init];
    });
    return person;
}

- (SNAppConfig *)config {
    if (!_config) {
        _config = [[SNAppConfig alloc] init];
    }
    return _config;
}

- (void)updateConfig {
    
//    NSString *dateString = [[NSDate date] dateByAddingTimeInterval:10];
//    [self.tempConfig setValue:dateString forKey:@"name"];
//    self.name = [self.tempConfig objectForKey:@"name"];
}

- (void)requestConfigAsync {
    
    if (_son) {
        _son = nil;
    }
    _son = [[SNSon alloc] init];
    [_son requestConfigAsync];
    
}

- (SNAppConfigABTest *)configABTest {
    return self.config.appConfigABTest;
}

#pragma mark - Lazy Load

- (NSMutableDictionary *)tempConfig {
    if (!_tempConfig) {
        _tempConfig = [[NSMutableDictionary alloc] init];
    }
    return _tempConfig;
}

@end
