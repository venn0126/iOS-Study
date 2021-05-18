//
//  TestObj2.m
//  NWUITest
//
//  Created by Augus on 2021/5/14.
//

#import "TestObj2.h"

@implementation TestObj2

+ (void)load {

    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));
}

+ (void)initialize {
    
    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));

}

- (void)printName {
    
    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));

}

@end
