//
//  GTOneTapSentMessageManger.h
//  TestObjcSome
//
//  Created by Augus on 2023/2/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^GTOneTapSentMessageBlock)(id arg1);

@interface GTOneTapSentMessageManger : NSObject

+ (instancetype)sharedInstance;


/// 存储SCChatConversationDataCoordinator


/// 存储SCTextSender

@property (nonatomic, strong) NSArray *sections;

/// 聊天会话数据的中转站
//@property (nonatomic, strong) SCChatConversationDataCoordinator *chatConversationDataCoordinator;

@property (nonatomic, copy) NSArray *snapchatters;

/// 会话Id数组
@property (nonatomic, copy) NSArray *conversationIds;


- (void)gt_startTimerWithTimeInterval:(NSTimeInterval)interval block:(void (NS_SWIFT_SENDABLE ^)(NSTimer *timer))block;

- (void)gt_stopTimer;


@end

NS_ASSUME_NONNULL_END
