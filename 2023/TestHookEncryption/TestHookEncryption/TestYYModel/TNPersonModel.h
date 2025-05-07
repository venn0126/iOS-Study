//
//  TNPersonModel.h
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface TNEatModel : NSObject

@property (copy, nonatomic)NSString *food;
@property (copy, nonatomic)NSString *date;

@end


@interface TNPersonMessageModel : NSObject

@property(nonatomic, copy) NSString *marryAge;
@property(nonatomic, copy) NSString *marryStatus;
@property(nonatomic, copy) NSString *paddress;
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *pname;


@end

@interface TNBabyFatherInfoModel : NSObject

@property(nonatomic, copy) NSString *bFatherAge;
@property(nonatomic, copy) NSString *bFatherUnit;
@property(nonatomic, copy) NSString *bFatherPhone;
@property(nonatomic, copy) NSString *husbFamHistory;
@property(nonatomic, copy) NSString *bFatherPcId;
@property(nonatomic, copy) NSString *isHusbFamHistory;
@property(nonatomic, copy) NSString *bFatherJob;
@property(nonatomic, copy) NSString *bFatherHealth;
@property(nonatomic, copy) NSString *bFatherName;

@end

@interface TNPregnancyHistoryItemBabyInfoModel : NSObject

@property(nonatomic, copy) NSString *babysex;
@property(nonatomic, copy) NSString *babyWeight;
@property(nonatomic, copy) NSString *babyStatus;
@property(nonatomic, copy) NSString *ycrdn;


@end


@interface TNPregnancyHistoryItemBabyInfosModel : NSObject

@property(nonatomic, strong) NSArray<TNPregnancyHistoryItemBabyInfoModel *> *babyInfo;

@end


@interface TNPregnancyHistoryItemModel : NSObject

@property(nonatomic, copy) NSString *zycqk;
@property(nonatomic, copy) NSString *historyId;
@property(nonatomic, copy) NSString *birthTime;
@property(nonatomic, copy) NSString *bearType;
@property(nonatomic, copy) NSString *chhfqk;
@property(nonatomic, strong) TNPregnancyHistoryItemBabyInfosModel *babyInfos;


@end


@interface TNPregnancyHistorysModel : NSObject

@property(nonatomic, strong) NSArray<TNPregnancyHistoryItemModel *> *pregnancyHistory;

@end



@interface TNPersonModel : NSObject
/*
 NSDictionary *returnDic = @{
                                 @"birthPlace":@"宁夏固原市彭阳县草庙乡",
                                 @"education":@"博士",
                                 @"id":@"115",

                                 //字典
                                 @"personalMessage":@{
                                         @"marryAge":@"30",
                                         @"marryStatus":@"1",
                                         @"paddress":@"宁夏固原市",
                                         @"phone":@"158*****289",
                                         @"pname":@"sxk",
                                         },
                                 @"babyFatherInfo" : @{
                                         @"bFatherAge" : @"38",
                                         @"bFatherUnit" : @"19957253180",
                                         @"bFatherPhone" : @"2222222",
                                         @"husbFamHistory" : @"3333333",
                                         @"bFatherPcId" : @"228384848484944",
                                         @"isHusbFamHistory" : @"1",
                                         @"bFatherJob" : @"01",
                                         @"bFatherHealth" : @"1",
                                         @"bFatherName" : @"sxk"
                                         },
                                 
                                 @"pregnancyHistorys" : @{
                                         @"pregnancyHistory" : @[
                                                 @{
                                                     @"zycqk" : @"01",
                                                     @"historyId" : @"210585",
                                                     @"birthTime" : @"2019-04",
                                                     @"bearType" : @"01",
                                                     @"chhfqk" : @"01",
                                                     @"babyInfos" : @{
                                                             @"babyInfo" : @[
                                                                     @{
                                                                         @"babysex" : @"01",
                                                                         @"babyWeight" : @"3000",
                                                                         @"babyStatus" : @"01",
                                                                         @"ycrdn" : @"210585"
                                                                         },
                                                                     @{
                                                                         @"babysex" : @"01",
                                                                         @"babyWeight" : @"3000",
                                                                         @"babyStatus" : @"01",
                                                                         @"ycrdn" : @"210585"
                                                                         }
                                                                     ]
                                                             }
                                                     },
                                                 @{
                                                     @"zycqk" : @"01",
                                                     @"historyId" : @"210586",
                                                     @"birthTime" : @"2019-04",
                                                     @"bearType" : @"01",
                                                     @"chhfqk" : @"01",
                                                     @"babyInfos" : @{
                                                             @"babyInfo" : @[
                                                                     @ {
                                                                         @"babysex" : @"01",
                                                                         @"babyWeight" : @"3000",
                                                                         @"babyStatus" : @"01",
                                                                         @"ycrdn" : @"210586"
                                                                     }
                                                                     ]
                                                             }
                                                     },
                                                 ]
                                         },
                                 };


 */

@property (strong, nonatomic) NSNumber *personId;
@property(nonatomic, copy) NSString *birthPlace;
@property(nonatomic, copy) NSString *education;
@property(nonatomic, strong) TNPersonMessageModel *personalMessage;
@property(nonatomic, strong) TNBabyFatherInfoModel *babyFatherInfo;
@property(nonatomic, strong) TNPregnancyHistorysModel *pregnancyHistorys;



//@property (copy,   nonatomic) NSString *name;
//@property (assign, nonatomic) NSInteger age;
//@property (copy,   nonatomic) NSString *sex;
//@property (strong, nonatomic) NSArray *languages;
//@property (strong, nonatomic) NSDictionary *job;
//@property (strong, nonatomic) NSArray <TNEatModel *> *eats;


@end

NS_ASSUME_NONNULL_END
