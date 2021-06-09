//
//  TestObj.m
//  NWUITest
//
//  Created by Augus on 2021/5/12.
//

#import "TestObj.h"
#import "TestSonObj.h"

@implementation TestObj

+ (void)load {
    
    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));
    
    TestSonObj *son = [TestSonObj new];
    [son print_SonName];
}

+ (void)initialize {
    
    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));

    
}

- (void)printName {
    
    
}

@end
