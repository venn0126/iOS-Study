//
//  GTPerson+Test.m
//  TestObjcSome
//
//  Created by Augus on 2023/1/21.
//

#import "GTPerson+Test.h"
#import <objc/runtime.h>

@implementation GTPerson (Test)


//- (void)setName:(NSString *)name {
//
//
//}
//
//
//- (NSString *)name {
//    return @"123";
//}

- (void)setName:(NSString *)name {
    
    
    
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (NSString *)name {
    
    return objc_getAssociatedObject(self, @selector(name));
}


@end
