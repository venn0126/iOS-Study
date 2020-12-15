//
//  FOSTool.h
//  offCompoundDemo
//
//  Created by Augus on 2020/2/11.
//  Copyright © 2020 fosafer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^tokenFinish)(_Nullable id result);
@class FOSHeaderModel;


NS_ASSUME_NONNULL_BEGIN

typedef void(^httpBlock)(id result);

@interface FOSTool : NSObject

+ (void)saveModel:(FOSHeaderModel *)model;

+ (FOSHeaderModel *)unArchivedModel;

+ (NSString *)machine;

// 剥离token获取方法
+ (void)fos_authToken:(FOSHeaderModel *)model tokenFinish:(tokenFinish)tokenFinish;

+ (NSString *)JSONStringOfDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
