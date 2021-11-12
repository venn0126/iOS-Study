//
//  TestStingNilTests.m
//  TestStingNilTests
//
//  Created by Augus on 2021/11/11.
//

#import <XCTest/XCTest.h>

@interface TestStingNilTests : XCTestCase

@end

@implementation TestStingNilTests

/// 在每一个测试方法调用前，都会被调用；用来初始化测试所需要的配置
- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}


/// 在每个测试方法调用后，都会被调用；用来重置测试的一些配置
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


/// 测试方法的举例，需要以`test`开发然后是你需要测试的功能，我一般习惯是接目的方法或者模块
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


/// 性能测试
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
