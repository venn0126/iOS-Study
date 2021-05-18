//
//  TestObj.m
//  NWUITest
//
//  Created by Augus on 2021/5/12.
//

#import "TestObj.h"

@implementation TestObj

+ (void)load {
    
    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));
}

+ (void)initialize {
    
    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));

    
}

- (void)printName {
    
    
}

@end
