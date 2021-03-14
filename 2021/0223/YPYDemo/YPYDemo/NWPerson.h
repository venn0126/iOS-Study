//
//  NWPerson.h
//  YPYDemo
//
//  Created by Augus on 2021/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NWPerson : NSObject

@property (nonatomic, assign)  int result;
@property (nonatomic, assign)  BOOL nwEqual;


/// A person drive car func
- (NWPerson * (^)(void))driveCar;


/// A person eat food func
- (NWPerson * (^)(void))eatFood;

/// A instance func return self
- (instancetype)with;

- (NWPerson *(^)(int))add;
- (NWPerson *(^)(int))plus;
- (NWPerson *(^)(int))muilt;
- (NWPerson *(^)(int))divide;


+ (int)makeCaculators:(void(^)(NWPerson *make))make;

/**
 
 1. 计算+2
 2. 计算 *5
 3. 比较大小
 4. 绑定返回
 */
- (NWPerson *)caculator:(int (^)(int result))caculator;

- (NWPerson *)equal:(BOOL(^)(int result))operation;

@end

NS_ASSUME_NONNULL_END
