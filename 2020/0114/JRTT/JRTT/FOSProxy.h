//
//  FOSProxy.h
//  JRTT
//
//  Created by Augus on 2020/6/22.
//  Copyright © 2020 fosafer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FOSProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)aTarget;

@property (nonatomic, weak) id target;


@end

NS_ASSUME_NONNULL_END
