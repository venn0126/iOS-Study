//
//  main.m
//  TestMutableDictionary
//
//  Created by Augus on 2022/5/30.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


void augusBL(void) {
    
    int a = 5;
    int b = 2;
    if (a > b) {
        printf("a > b");
    } else {
        NSLog(@"a <= b");
    }
}

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
//        augusBL();
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
