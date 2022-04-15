//
//  CADisplayLinkTestTests.m
//  CADisplayLinkTestTests
//
//  Created by Augus on 2022/3/26.
//

#import <XCTest/XCTest.h>
#import "UIColor+CustomColor.h"

@interface CADisplayLinkTestTests : XCTestCase

@end

@implementation CADisplayLinkTestTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


- (void)testUIColorExtension {
    
    // nil
    id color = UIColor.BG1;
    XCTAssertNotNil(color);
    
    // kind
    XCTAssertTrue([color isKindOfClass:[UIColor class]]);
    
    NSLog(@"---%@ : %@",@(__func__),@(__LINE__));
}

@end
