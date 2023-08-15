//
//  GuanSwitch.m
//  TestHookEncryption
//
//  Created by Augus on 2023/8/14.
//

#import "GuanSwitch.h"

@implementation GuanSwitch

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    self.onTintColor = [UIColor colorWithRed:62/256.0 green:137/256.0 blue:250/256.0 alpha:1];
    return self;
}

@end
