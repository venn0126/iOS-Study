//
//  GTModel.m
//  CADisplayLinkTest
//
//  Created by Augus on 2022/4/16.
//

#import "GTModel.h"

@implementation GTModel



- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:_newsTitle forKey:@"newsTitle"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
   _newsTitle = [coder decodeObjectForKey:@"newsTitle"];
    
    return self;
}

@end
