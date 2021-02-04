//
//  NSObject+NWModel.m
//  NWModel
//
//  Created by Augus on 2021/2/4.
//

#import "NSObject+NWModel.h"

@implementation NSObject (NWModel)

#pragma mark - Privacy Action

/// id to dict or nil
+ (NSDictionary *)__nw_dictionaryWithJSON:(id)json {
    
    if (!json || json == (id)kCFNull) {
        return nil;
    }
    
    NSDictionary *dict = nil;
    NSData *jsonData = nil;
    
    if ([json isKindOfClass:[NSDictionary class]]) {
        dict = json;
    }else if([json isKindOfClass:[NSString class]]){
        jsonData = [(NSString *)json dataUsingEncoding:NSUTF8StringEncoding];
    }else if([json isKindOfClass:[NSData class]]){
        jsonData = json;
    }
    
    if (jsonData) {
        dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:NULL];
    }
    
    if (![dict isKindOfClass:[NSDictionary class]]) {
        dict = nil;
    }
    
    return dict;
}






@end
