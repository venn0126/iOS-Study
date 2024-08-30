//
//  ChengReserverMgr.h
//  TestHookEncryption
//
//  Created by Augus on 2024/8/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChengReserverMgr : NSObject

+ (instancetype)shared;

@property (nonatomic, assign) BOOL stopRequested;

- (void)guan_startReservingTickets;

- (void)guan_stopReservingTickets;



@end

NS_ASSUME_NONNULL_END
