//
//  CADisplayLinkTestTests.m
//  CADisplayLinkTestTests
//
//  Created by Augus on 2022/3/26.
//

#import <XCTest/XCTest.h>
#import "UIColor+CustomColor.h"
#import "GTViewModel.h"
#import "NSDateFormatter+Extension.h"

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


- (void)testGTViewModel {
    
    GTViewModel *viewModel = [[GTViewModel alloc] init];
    GTViewModel *viewModel1 = [[GTViewModel alloc] initWithObserverName:@""];
//    GTViewModel *viewModel2 = [[GTViewModel alloc] initWithObserverName:nil];
    
    XCTAssertNotNil(viewModel);
    XCTAssertNotNil(viewModel1);
//    XCTAssertNotNil(viewModel2);



}


- (void)testNSDateFormatter {
    
    // kind
    NSString *test0 = [NSDateFormatter toStringByDate:[NSData data] format:nil];
    XCTAssertNil(test0);

    NSString *test1 = [NSDateFormatter toStringByDate:[NSDate date] format:[NSData data]];
    XCTAssertNotNil(test1);

    // nil
    NSString *test2 = [NSDateFormatter toStringByDate:nil format:nil];
    XCTAssertNil(test2);

    NSString *test3 = [NSDateFormatter toStringByDate:[NSDate date] format:nil];
    XCTAssertNotNil(test3);
    
    NSString *test4 = [NSDateFormatter toStringByDate:[NSDate date] format:@""];
    XCTAssertNotNil(test4);
    
    NSString *test5 = [NSDateFormatter toStringByDate:[NSDate date] format:@"123"];
    XCTAssertNotNil(test5);
    
    NSString *test6 = [NSDateFormatter toStringByDate:[NSDate date] format:@"yyyy/MM/dd"];
    XCTAssertNotNil(test6);
    
    NSString *test7 = [NSDateFormatter toStringByDate:nil format:@"yyyy-MM-dd"];
    XCTAssertNil(test7);
    

    
}


@end
