//
//  main.m
//  CADisplayLinkTest
//
//  Created by Augus on 2022/3/26.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


static __attribute__((constructor))
void augus_constructor() {
    printf("it is first call");
    printf("it is second call");
    NSLog(@"augus is  constructor");
}


static __attribute__((destructor))
void augus_destructor() {
    NSLog(@"augus is  destructor");
}

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
