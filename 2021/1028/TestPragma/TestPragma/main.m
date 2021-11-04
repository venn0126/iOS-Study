//
//  main.m
//  TestPragma
//
//  Created by Augus on 2021/11/4.
//

#import <Foundation/Foundation.h>


#pragma mark - Public Methods

void testLog(void) {
    NSLog(@"it is log");
}


#pragma mark - Main

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, Main!");
        testLog();
    }
    return 0;
}







