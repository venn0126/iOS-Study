//
//  SNAppConfigABTest.m
//  TestStingNil
//
//  Created by Augus on 2021/11/14.
//

#import "SNAppConfigABTest.h"

@implementation SNAppConfigABTest

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSDictionary *dict = @{@"_abTestExpose":@"TianTestExpose"};
    [self updateWithDic:dict];
    
    return self;
}

- (void)updateWithDic:(NSDictionary *)dic {
    
    _abTestList = [dic objectForKey:@"_abTestList"];
    _abTestExpose = [dic objectForKey:@"_abTestExpose"];
//
//    // 读取setting.go下发的24h频道ABtest分桶数据
    [_abTestList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (np_dictionaryContainsKey(obj, kSetting_SmcClient_hot24_abTestResult)) {
//            _pSmcClient_Hot24_abTestResult = [obj objectForKey:kSetting_SmcClient_hot24_abTestResult defalutObj:kabtest_hot24Feed];
//        }
//
//        _fastBrowsingAtNegativeScreen = [[obj stringValueForKey:kSetting_SmcClient_NegativeScreen_abTestResult defaultValue:@"1002"] isEqualToString:@"1002"];
        [NSUserDefaults.standardUserDefaults setObject:@"test_ab" forKey:@"Test_AB"];
    }];

}


+ (NSString *)appVersion {
    static dispatch_once_t onceToken;
    static NSString *appVersion;
    dispatch_once(&onceToken, ^{
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        //6.2.3.1 -> 6.2.3
        if (version.length > 5) {
            appVersion = [version substringToIndex:5];
        } else {
            appVersion = version;
        }
    });
    return appVersion;
}

@end
