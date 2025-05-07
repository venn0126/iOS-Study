//
//  TNPersonModel.m
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import "TNPersonModel.h"

@implementation TNEatModel


@end


@implementation TNPersonMessageModel


@end


@implementation TNBabyFatherInfoModel


@end


@implementation TNPregnancyHistoryItemBabyInfoModel


@end


@implementation TNPregnancyHistoryItemBabyInfosModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"babyInfo" : [TNPregnancyHistoryItemBabyInfoModel class]};
}

@end


@implementation TNPregnancyHistoryItemModel


@end



@implementation TNPregnancyHistorysModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pregnancyHistory" : [TNPregnancyHistoryItemModel class]};
}

@end




@implementation TNPersonModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{
             @"personId":@"id",
             //@"sex":@"sexDic.sex" // 声明sex字段在sexDic下的sex
             };
}

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
  // value使用[TNEatModel class]或TNEatModel.class或@"TNEatModel"都可
  return @{@"eats" : [TNEatModel class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
  // 可以在这里处理一些数据逻辑，如NSDate格式的转换
    NSLog(@"当 JSON 转为 Model 完成后，该方法会被调用---");
    return YES;
}

// 当 Model 转为 JSON 完成后，该方法会被调用。
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    NSLog(@"当 Model 转为 JSON 完成后，该方法会被调用---");
    return YES;
}

@end
