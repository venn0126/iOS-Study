//
//  GTOneTapSentMessageManger.h
//  TestObjcSome
//
//  Created by Augus on 2023/2/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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


/// 获取Document路径
+ (NSString *)gt_DocumentPath;

/// 获取Cache路径
+ (NSString *)gt_CachePath;

/// 获取Library路径
+ (NSString *)gt_LibraryPath;

/// 获取临时路径
+ (NSString *)gt_TempPath;


/// 获取某个文件夹大小（KB）
+ (CGFloat)gt_folderSizeAtPath:(NSString *)folderPath;

/// 清除某个路径下的缓存
+ (void)gt_clearCaches:(NSString *)cachePath;

/// 清除所有路径的缓存
+ (void)gt_clearAllCaches;

/// 获取当前keyWindow
+ (UIWindow *)gt_getKeyWindow;


+ (void)showAlertText:(NSString *)text dismissDelay:(NSTimeInterval)delay;

- (void)gt_showAlertText:(NSString *)text;

- (void)gt_hiddenAlert;

@end

NS_ASSUME_NONNULL_END
