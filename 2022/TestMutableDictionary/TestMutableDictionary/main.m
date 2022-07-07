//
//  main.m
//  TestMutableDictionary
//
//  Created by Augus on 2022/5/30.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Person.h"


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
//        Person *p = [Person augusPerson];
//        NSLog(@"这就是街舞 %@",p);
        
        // NSGlobalBlock
        // returnType (^blockName)(parameterTypes) = ^returnType(parameters) {...};
        NSInteger a = 5;
        int (^block)(float someHeight) = ^int(float someHeight) {
            
            NSLog(@"这就是stack block %.2f--%ld", someHeight, a);
            
            return 10;
        };
        block(0.65);
        
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
