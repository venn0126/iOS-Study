//
//  GTPerson.m
//  TestObjcSome
//
//  Created by Augus on 2023/1/13.
//

#import "GTPerson.h"

@implementation GTPerson

//- (void)setAge:(NSInteger)age {
//    _age = age;
//}
//
//- (NSInteger)age {
//    return _age;
//}


- (void)run {

    NSLog(@"person run %@",self.name);
}


- (void)dealloc {
    
    NSLog(@"GTPerson is dealloc");
}

@end
