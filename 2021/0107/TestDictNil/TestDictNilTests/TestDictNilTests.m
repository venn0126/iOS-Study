//
//  TestDictNilTests.m
//  TestDictNilTests
//
//  Created by Augus on 2021/1/7.
//

#import <XCTest/XCTest.h>
//#import "NSDictionary+NilSafe.h"

@interface TestDictNilTests : XCTestCase

@end

@implementation TestDictNilTests

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

- (void)testLiteral {
    
    id nilValue = nil;
    id nilKey = nil;
    id nonNilKey = @"nonNilKey";
    id nonNilValue = @"nonNilValue";
    
//    NSDictionary *dict = @{
//        nonNilKey : nilValue,
//        nilKey : nonNilValue
//    };
//
//    XCTAssertEqualObjects([dict allKeys], nonNilKey);
    
    
}

@end
