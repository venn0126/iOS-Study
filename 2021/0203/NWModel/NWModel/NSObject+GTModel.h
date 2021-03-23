//
//  NSObject+GTModel.h
//  NWModel
//
//  Created by Augus on 2021/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (GTModel)


/// A dictionary instance to a model.
/// @param dictionary a dictionary instance
/// @return id a model instance.
+ (id)gt_modelWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
