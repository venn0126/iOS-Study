//
//  TheosTemplate.m
//  TheosTemplate
//
//  Created by zhz on 2022/6/12.
//

#import "NewClass.h"

void theoslog(NSString * info) {
    NSLog(@"log: %@", info);
}

@implementation NewClass

+ (NSInteger)sum:(NSInteger) a add:(NSInteger)b {
    return a + b;
}

@end
