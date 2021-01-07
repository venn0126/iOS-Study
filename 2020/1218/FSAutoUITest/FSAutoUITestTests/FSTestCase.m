//
//  FSTestCase.m
//  FSAutoUITestTests
//
//  Created by Augus on 2020/12/18.
//

#import "FSTestCase.h"

@interface FSTestCase ()

@property (nonatomic, assign) NSTimeInterval shortTime;
@property (nonatomic, assign) NSTimeInterval longTime;

@end

@implementation FSTestCase

- (void)setUp {
    self.shortTime = 10;
    self.longTime = 30;
}

- (void)waitShortTimeForExpectations {
    [self waitForExpectationsWithTimeout:self.shortTime handler:nil];
}

- (void)waitLongTimeForExpectations {
    [self waitForExpectationsWithTimeout:self.longTime handler:nil];
}

- (void)waitShortTimeForExpectations:(NSArray<XCTestExpectation *> *)expectations {
    [self waitForExpectations:expectations timeout:self.shortTime];
}

- (void)waitLongTimeForExpectations:(NSArray<XCTestExpectation *> *)expectations {
    [self waitForExpectations:expectations timeout:self.longTime];
}

- (void)addAttachmentWithScreenshot:(XCUIScreenshot *)screenshot attachmentName:(NSString *)attachmentName {
    XCTAttachment *attachment = [XCTAttachment attachmentWithScreenshot:screenshot];
    attachment.lifetime = XCTAttachmentLifetimeKeepAlways;
    attachment.name = attachmentName;
    [self addAttachment:attachment];
}

@end
