//
//  FOSTool.m
//  offCompoundDemo
//
//  Created by Augus on 2020/2/11.
//  Copyright © 2020 fosafer. All rights reserved.
//

#import "FOSTool.h"
#import "FOSHeaderModel.h"
#import <FosaferAuth/FosaferAuth.h>

#define kClientId       @"600001388"
#define kClientSecret   @"ju+0/2/6Sly3Gh5ExPQ0ne6CmAmM79Kfic0ChCd0Pxg="


@implementation FOSTool

+ (void)saveModel:(FOSHeaderModel *)model {
 
    NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:model];
    [[NSUserDefaults standardUserDefaults] setObject:modelData forKey:@"headerData"];
}

+ (FOSHeaderModel *)unArchivedModel {
    NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:@"headerData"];
    if (!modelData) {
        return nil;
    }
    FOSHeaderModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    return model;
}

+ (NSString *)machine {

    NSString *deviceName = [[UIDevice currentDevice] name];
    NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
    return [NSString stringWithFormat:@"%@-%@",deviceName,sysVersion];
}

+ (void)fos_authToken:(FOSHeaderModel *)model tokenFinish:(tokenFinish)tokenFinish {
    
    NSString *path = @"https://apicloud.fosafer.com/token";
    // 请先配置商户id和私钥
    if (kClientId <= 0 || kClientSecret.length <= 0) {
        NSAssert((kClientId.length > 0 && kClientSecret.length > 0), @"set token params clientId and clientSecret");
    }
    
    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys: kClientId, @"client_id",kClientSecret, @"client_secret",
                             nil];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        id result = [FOSFosafer httpPost:path params:mapData];
        NSLog(@"token result %@",result);

        if ([result isKindOfClass:[NSError class]]) {
            NSLog(@"auth token error--%@",result);
            tokenFinish(result);
            return;
        }

        NSDictionary *dict = result;
        tokenFinish(dict);
    });
}


+ (NSString *)JSONStringOfDictionary:(NSDictionary *)dic {
    if (dic == nil) {
        return @"";
    }
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    for (NSString *key in dic) {
        id object = [dic objectForKey:key];
        if ([NSJSONSerialization isValidJSONObject:object]) {
            [tempDic setObject:object forKey:key];
        } else {
            [tempDic setObject:[NSString stringWithFormat:@"%@", object] forKey:key];
        }
    }
    dic = [tempDic copy];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
        return @"";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end
