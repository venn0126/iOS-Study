//
//  SNCalculateMethod.h
//  SNCalculatorDemo
//
//  Created by Augus on 2023/6/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNCalculateMethod : NSObject

/// 总位数，规定计算位数最多16位
@property (nonatomic, assign) int totalDecimals;

/// 是否是小数
@property (nonatomic, assign) BOOL isDecimal;

/// 小数位数
@property (nonatomic, assign) int decimals;

- (long double)performOperation:(NSString *)operation outputTextField:(UITextField *)outputTextField;

- (void)clear:(UITextField *)outputTextField;

- (void)displayString:(NSString *)str withMethod:(NSString *)method outputTextField:(UITextField *)outputTextField;

- (void)processDigit:(int)digit outputTextField:(UITextField *)outputTextField;

/// 按下了操作符
- (void)processOp:(NSString *)op outputTextField:(UITextField *)outputTextField;;


@end

NS_ASSUME_NONNULL_END
