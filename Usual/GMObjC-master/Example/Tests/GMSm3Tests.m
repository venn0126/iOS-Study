//
//  GMSm3Tests.m
//  GMObjC_Tests
//
//  Created by lifei on 2019/8/18.
//  Copyright © 2019 lifei. All rights reserved.
//

#import "GMBaseTests.h"

@interface GMSm3Tests : GMBaseTests

@end

@implementation GMSm3Tests

/// 测试工具类
- (void)testGMUtils {
    for (NSInteger i = 0; i < 1000; i++) {
        NSString *plaintext = [self randomAny:10000];
        XCTAssertNotNil(plaintext, @"生成字符串不为空");
        NSString *hexStr = [GMUtils stringToHex:plaintext];
        XCTAssertNotNil(hexStr, @"16 进制字符串不为空");
        NSString *originStr = [GMUtils hexToString:hexStr];
        BOOL isSameStr = [originStr isEqualToString:plaintext];
        XCTAssertTrue(isSameStr, @"明文转 Hex 可逆");
        
        NSData *plainData = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
        XCTAssertNotNil(plainData, @"明文 Data 不为空");
        NSString *hexData = [GMUtils dataToHex:plainData];
        XCTAssertNotNil(hexData, @"明文 Data 转 Hex 不为空");
        NSData *originData = [GMUtils hexToData:hexData];
        BOOL isSameData = [originData isEqualToData:plainData];
        XCTAssertTrue(isSameData, @"明文 Data 转 Hex 可逆");
    }
}

/// 测试 sm3 出现空的情况
- (void)testSm3Null {
    NSString *strNull = nil;
    NSString *strLenZero = @"";
    NSData *dataNull = [NSData data];
    
    NSString *digStrNull = [GMSm3Utils hashWithString:strNull];
    XCTAssertNil(digStrNull, @"字符串为空摘要为空");
    
    NSString *digStrZero = [GMSm3Utils hashWithString:strLenZero];
    XCTAssertNil(digStrZero, @"字符串为空摘要为空");
    
    NSString *digDataNull = [GMSm3Utils hashWithData:dataNull];
    XCTAssertNil(digDataNull, @"字符串为空摘要为空");
}

/**
 * 测试对英文字符串提取摘要
 */
- (void)testSm3EnStr {
    for (NSInteger i = 0; i < 1000; i++) {
        int randLen = arc4random_uniform((int)1000);
        NSString *plaintext = [self randomEn:randLen];
        XCTAssertNotNil(plaintext, @"生成字符串不为空");
        
        NSString *tempDigStr = [GMSm3Utils hashWithString:plaintext];
        XCTAssertNotNil(tempDigStr, @"加密字符串不为空");
    }
    // 多次摘要相同
    int randLen = arc4random_uniform((int)1000);
    NSString *plaintext = [self randomEn:randLen];
    NSString *digStr = nil;
    for (NSInteger i = 0; i < 1000; i++) {
        XCTAssertNotNil(plaintext, @"生成字符串不为空");
        NSString *tempDigStr = [GMSm3Utils hashWithString:plaintext];
        XCTAssertNotNil(tempDigStr, @"加密字符串不为空");
        if (digStr) {
            BOOL isSameDig = [digStr isEqualToString:tempDigStr];
            XCTAssertTrue(isSameDig, @"多次摘要相同");
        }
        digStr = tempDigStr;
    }
}

/**
 * 测试对中文字符串提取摘要
 */
- (void)testSm3ZhStr {
    for (NSInteger i = 0; i < 1000; i++) {
        int randLen = arc4random_uniform((int)1000);
        NSString *plaintext = [self randomZh:randLen];
        XCTAssertNotNil(plaintext, @"生成字符串不为空");
        
        NSString *tempDigStr = [GMSm3Utils hashWithString:plaintext];
        XCTAssertNotNil(tempDigStr, @"加密字符串不为空");
    }
    // 多次摘要相同
    int randLen = arc4random_uniform((int)1000);
    NSString *plaintext = [self randomZh:randLen];
    NSString *digStr = nil;
    for (NSInteger i = 0; i < 1000; i++) {
        XCTAssertNotNil(plaintext, @"生成字符串不为空");
        NSString *tempDigStr = [GMSm3Utils hashWithString:plaintext];
        XCTAssertNotNil(tempDigStr, @"加密字符串不为空");
        if (digStr) {
            BOOL isSameDig = [digStr isEqualToString:tempDigStr];
            XCTAssertTrue(isSameDig, @"多次摘要相同");
        }
        digStr = tempDigStr;
    }
}

/**
 * 测试对中英文混合字符串提取摘要
 */
- (void)testSm3ZhEnStr {
    for (NSInteger i = 0; i < 1000; i++) {
        int randLen = arc4random_uniform((int)1000);
        NSString *plaintext = [self randomZhEn:randLen];
        XCTAssertNotNil(plaintext, @"生成字符串不为空");
        
        NSString *tempDigStr = [GMSm3Utils hashWithString:plaintext];
        XCTAssertNotNil(tempDigStr, @"加密字符串不为空");
    }
    // 多次摘要相同
    int randLen = arc4random_uniform((int)1000);
    NSString *plaintext = [self randomZhEn:randLen];
    NSString *digStr = nil;
    for (NSInteger i = 0; i < 1000; i++) {
        XCTAssertNotNil(plaintext, @"生成字符串不为空");
        NSString *tempDigStr = [GMSm3Utils hashWithString:plaintext];
        XCTAssertNotNil(tempDigStr, @"加密字符串不为空");
        if (digStr) {
            BOOL isSameDig = [digStr isEqualToString:tempDigStr];
            XCTAssertTrue(isSameDig, @"多次摘要相同");
        }
        digStr = tempDigStr;
    }
}

/**
 * 测试对文件提取摘要
 */
- (void)testSm3Data {
    XCTAssertNotNil(self.fileData, @"待加密 NSData 不为空");
    NSString *digStr = nil;
    for (NSInteger i = 0; i < 1000; i++) {
        NSString *tempDigStr = [GMSm3Utils hashWithData:self.fileData];
        XCTAssertNotNil(tempDigStr, @"加密字符串不为空");
        if (digStr) {
            BOOL isSameDig = [digStr isEqualToString:tempDigStr];
            XCTAssertTrue(isSameDig, @"多次摘要相同");
        }
        digStr = tempDigStr;
    }
}


@end
