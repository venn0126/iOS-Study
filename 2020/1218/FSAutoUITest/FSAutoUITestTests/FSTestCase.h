//
//  FSTestCase.h
//  FSAutoUITestTests
//
//  Created by Augus on 2020/12/18.
//

#import <XCTest/XCTest.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSTestCase : XCTestCase

/**
 
 */
- (void)waitShortTimeForExpectations;

/**
 
 */
- (void)waitLongTimeForExpectations;

/**
 
 */
- (void)waitShortTimeForExpectations:(NSArray<XCTestExpectation *> *)expectations;

/**
 
 */

- (void)waitLongTimeForExpectations:(NSArray<XCTestExpectation *> *)expectations;

/**
 
 */
- (void)addAttachmentWithScreenshot:(XCUIScreenshot *)screenshot attachmentName:(NSString *)attachmentName;

@end

NS_ASSUME_NONNULL_END
