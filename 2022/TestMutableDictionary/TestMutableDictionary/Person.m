//
//  Person.m
//  TestMutableDictionary
//
//  Created by Augus on 2022/7/7.
//

#import "Person.h"

@implementation Person

+ (instancetype)augusPerson {
    return [[Person alloc] init];
}

+ (void)say:(NSString *)text callback:(void (^)(NSString * _Nonnull, int, NSString * _Nonnull, double, BOOL))callback {
    
    NSLog(@"%@ %@",@(__func__), @(__LINE__));
}

@end
