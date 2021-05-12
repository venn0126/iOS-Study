//
//  Person.m
//  YPYDemo
//
//  Created by Augus on 2021/3/27.
//

#import "Person.h"

@interface Person ()


@end

@implementation Person

//- (instancetype)init {
//    
//    self = [super init];
//    if (!self) {
//        return nil;
//    }
//    
////    self.lastName = @"";
//    return self;
//}

//- (void)setLastName:(NSString *)lastName {
//
//    NSLog(@"🔴类名与方法名：%s（在第%d行），描述：%@", __PRETTY_FUNCTION__, __LINE__, @"根本不会调用这个方法");
//      _lastName = @"炎黄";
//}

- (void)speak {
    NSLog(@"my name is %@",self.name);
    self->firstName = @"niu";
    
}

- (void)setFirstName:(NSString *)firstName {
    self->firstName = firstName;
}

- (NSString *)getFirstName {
    return self->firstName;
}



@end
