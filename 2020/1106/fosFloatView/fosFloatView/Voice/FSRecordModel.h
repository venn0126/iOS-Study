//
//  FSRecordModel.h
//  fosFloatView
//
//  Created by Augus on 2020/11/10.
//

#import <Foundation/Foundation.h>
#import "FSGlobal.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSRecordModel : NSObject

@property (nonatomic,copy) NSString *path;

@property (nonatomic,strong) NSArray *levels; // 振幅数组

@property (nonatomic,assign) NSInteger duration;

// 单例
singtonInterface;

@end

NS_ASSUME_NONNULL_END
