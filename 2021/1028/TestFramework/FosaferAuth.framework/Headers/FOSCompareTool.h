//
//  FOSCompareTool.h
//  FosaferAuth
//
//  Created by Wei Niu on 2018/11/8.
//  Copyright © 2018年 Fosafer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^FOSCompareToolCallBack)(id result, NSError *error);

@interface FOSCompareTool : NSObject

+ (instancetype)shareInstance;

// 两项比对
- (void)fos_compareToolParams:(NSDictionary *)params completion:(FOSCompareToolCallBack)completion;

// 本地照片
//- (void)fos_localImageParams:(NSDictionary *)params completion:(FOSCompareToolCallBack)completion;

@end

NS_ASSUME_NONNULL_END
