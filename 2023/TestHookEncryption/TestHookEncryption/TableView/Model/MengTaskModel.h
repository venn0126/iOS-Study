//
//  MengTaskModel.h
//  TestHookEncryption
//
//  Created by Augus on 2023/10/12.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MengTaskModel : NSObject


/// 重名了，需要修改
@property (nonatomic, assign) NSInteger id;

/// 转出的银行
@property (nonatomic, copy) NSString *bank;

/// 转出的银行卡号
@property (nonatomic, copy) NSString *card;

/// 转出人的名字
@property (nonatomic, copy) NSString *name;

/// 转出的金额
@property (nonatomic, copy) NSString *money;




@end

NS_ASSUME_NONNULL_END
