//
//  SNAppConfig.m
//  TestStingNil
//
//  Created by Augus on 2021/11/14.
//

#import "SNAppConfig.h"

@implementation SNAppConfig

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    
    
    self.appConfigABTest = [[SNAppConfigABTest alloc] init];
    
    return self;
}

@end
