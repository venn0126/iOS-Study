//
//  GTPerosn.m
//  TestObjc
//
//  Created by Augus on 2023/1/13.
//

#import "GTPerosn.h"

@implementation GTPerosn


- (void)test {
    
    
    void (^block)(void) = ^{
        
        NSLog(@"it is a block %@",self);
    };
    
    block();
}

@end
