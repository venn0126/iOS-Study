//
//  main.m
//  JRTT
//
//  Created by Augus on 2020/1/14.
//  Copyright © 2020 fosafer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//#import "Part1.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        
//        Part1 *p = [[Part1 alloc] init];
//        [p performSelector:@selector(VENNInit)];
//        return 0;
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
