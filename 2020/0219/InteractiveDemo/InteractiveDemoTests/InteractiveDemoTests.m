//
//  InteractiveDemoTests.m
//  InteractiveDemoTests
//
//  Created by Wei Niu on 2018/12/7.
//  Copyright © 2018年 Fosafer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "viewController.h"
#import "AppDelegate.h"



@interface InteractiveDemoTests : XCTestCase{
    
@private
    UIApplication   *app;
    AppDelegate     *fosAppDelegate;
    ViewController  *fosController;
}

@end

@implementation InteractiveDemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    

    
    app = [UIApplication sharedApplication];
    fosController = (ViewController*)[[UIApplication sharedApplication] delegate];
    XCTAssertNotNil(fosController, @"Cannot find fosController instance");
    
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.

       
    }];
}

@end
