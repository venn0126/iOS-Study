//
//  main.m
//  NWUITest
//
//  Created by Augus on 2021/4/22.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//#import <MangoSDK/MangoSDK.h>

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
    
    
//    MGTool *tool = [MGTool new];
//    [tool mg_logName];
}
