//
//  GTObserver.m
//  TestObjc
//
//  Created by Augus on 2023/1/13.
//

#import "GTObserver.h"

@implementation GTObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    
    NSLog(@"KVO 通知变化 %@", change);
}

@end
