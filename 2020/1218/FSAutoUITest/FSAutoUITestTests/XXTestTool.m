//
//  XXTestTool.m
//  FSAutoUITestTests
//
//  Created by Augus on 2020/12/18.
//

#import <XCTest/XCTest.h>
#import "FSTestCase.h"
#import "FosTool.h"

@interface XXTestTool : FSTestCase

@end

@implementation XXTestTool

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

// 测试工具类日期接口
- (void)testToolDateFormatter {
    
    NSString *originStr = @"2020-12-18 14:30:22";
    NSDate *date = [FosTool dateFormatWithString:originStr];
    NSString *dateStr = [FosTool stringFormatWithDate:date];
    XCTAssertEqualObjects(dateStr, originStr);
    
}

// 测试工具类的本地化函数

- (void)testLocalDataArchieve {
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setObject:@"8201119129" forKey:@"appCode"];
    
    // dict to json
    NSString *jsonStr = [FosTool convertToJsonData:dataDict];
    NSData *data0 = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    [FosTool saveModel:data0 key:@"data0"];
    
    
    id data1 = [FosTool unArchivedModelObjectOfClass:[NSData class] key:@"data0"];
    
    // data to str
    NSString *jsonStr1 = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    XCTAssertEqualObjects(jsonStr1, jsonStr);

}

@end
