//
//  NWPerson+Extension.m
//  YPYDemo
//
//  Created by Augus on 2021/3/17.
//

#import "NWPerson+Extension.h"

@implementation NWPerson (Extension)

+ (void)load {
    
    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));

}



- (void)personPrint {
    
    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));

}

- (void)foo {
    
    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));

}

@end
