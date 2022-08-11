//
//  HotListHandler.m
//  AugusShortcuts
//
//  Created by Augus on 2022/8/11.
//

#import "HotListHandler.h"

@implementation HotListHandler

- (void)handleHotList:(HotListIntent *)intent completion:(void (^)(HotListIntentResponse * _Nonnull))completion {
    
    NSString *inputValue = intent.inputValue;
    NSString *storeKey = intent.storeKey;
    if (!inputValue || !storeKey) {
        NSLog(@"open hotlist fail");
        
        HotListIntentResponse *failResponse = [[HotListIntentResponse alloc] initWithCode:HotListIntentResponseCodeFailure userActivity:nil];
        completion(failResponse);
        return;
    }
    
    NSLog(@"open hotlist success");
    HotListIntentResponse *successResponse = [[HotListIntentResponse alloc] initWithCode:HotListIntentResponseCodeSuccess userActivity:nil];
    completion(successResponse);
}

@end
