//
//  GuanBaseModel.h
//  TestHookEncryption
//
//  Created by Augus on 2023/8/14.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

NS_ASSUME_NONNULL_BEGIN


/// 最后一层的展示模型
@interface GuanCellModel : NSObject

@property (nonatomic, copy) NSString *guanTitleText;
@property (nonatomic, assign) BOOL guanRigthOn;
@property (nonatomic, copy) NSString *guanRightText;
@property (nonatomic, copy) NSString *guanCellId;


@end

/// 第二层中section包含的row model
@interface GuanSectionModel : NSObject

@property (nonatomic, copy) NSString *guanSectionTitle;
@property (nonatomic, copy) NSArray <GuanCellModel *>*guanRowData;

@end

/// 基础 model
@interface GuanBaseModel : NSObject


@end







NS_ASSUME_NONNULL_END
