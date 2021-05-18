//
//  TestSonObj+TSOCateory.m
//  NWUITest
//
//  Created by Augus on 2021/5/13.
//

#import "TestSonObj+TSOCateory.h"

@implementation TestSonObj (TSOCateory)

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
