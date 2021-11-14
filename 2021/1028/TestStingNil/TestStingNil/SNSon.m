//
//  SNSon.m
//  TestStingNil
//
//  Created by Augus on 2021/11/14.
//

#import "SNSon.h"
#import "SNAppConfig.h"
#import "SNPerson.h"


@interface SNSon ()


@end

@implementation SNSon


- (void)requestConfigAsync {
    
    SNAppConfig *config = [[SNPerson shared] config];
//    NSString *dateString =
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];

    NSDate *currentDate = [NSDate date];
    NSString *dateString = [formatter stringFromDate:currentDate];
    NSDictionary *dict = @{@"_abTestExpose":dateString};
    [config.appConfigABTest updateWithDic:dict];
    
}


@end
