//
//  NSObject+Test.m
//  TestObjc
//
//  Created by Augus on 2023/1/10.
//

#import "NSObject+Test.h"

@implementation NSObject (Test)


+ (void)test {
    
    
}

- (void)test {
    
    NSLog(@"%@ %p",@(__func__),self);
}

@end
