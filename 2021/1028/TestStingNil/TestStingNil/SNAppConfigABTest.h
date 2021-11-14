//
//  SNAppConfigABTest.h
//  TestStingNil
//
//  Created by Augus on 2021/11/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNAppConfigABTest : NSObject

@property (nonatomic, copy, readonly) NSString *abTestExpose;
@property (nonatomic, strong, readonly) NSArray *abTestList;

- (void)updateWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
