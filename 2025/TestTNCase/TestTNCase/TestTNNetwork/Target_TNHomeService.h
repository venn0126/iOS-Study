//
//  Target_TNHomeService.h
//  TestTNCase
//
//  Created by Augus Venn on 2025/5/15.
//

#import <Foundation/Foundation.h>
#import "TNHomeService.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const TNNetworkingHomeServiceIdentifier;


@interface Target_TNHomeService : NSObject

- (TNHomeService *)Action_TNHomeService:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
