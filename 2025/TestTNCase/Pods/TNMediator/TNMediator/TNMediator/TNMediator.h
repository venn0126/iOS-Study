//
//  TNMediator.h
//  TNMediator
//
//  Created by Augus Venn on 2025/4/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kTNMediatorTargetPrefix;
extern NSString * const kTNMediatorActionPrefix;
extern NSString * const kTNMediatorNotFoundSelector;

@interface TNMediator : NSObject

extern NSString * _Nonnull const kTNMediatorParamsKeySwiftTargetModuleName;

+ (instancetype _Nonnull)sharedInstance;

/// 远程App调用入口
/// scheme://[target]/[action]?[params]
///  url sample:
///  xxx://targetA/actionB?id=2222
- (id _Nullable)performActionWithUrl:(NSURL * _Nullable)url completion:(void(^_Nullable)(NSDictionary * _Nullable info))completion;

/// 本地组件调用入口
- (id _Nullable )performTarget:(NSString * _Nullable)targetName action:(NSString * _Nullable)actionName params:(NSDictionary * _Nullable)params shouldCacheTarget:(BOOL)shouldCacheTarget;

/// 释放缓存的target
- (void)releaseCachedTargetWithFullTargetName:(NSString * _Nullable)fullTargetName;

/// 检查 是否有引源码
- (BOOL)check:(NSString * _Nullable)targetName moduleName:(NSString * _Nullable)moduleName;

///白名单机制

@end

/// 简化调用单例的函数
TNMediator* _Nonnull TNMS(void);

NS_ASSUME_NONNULL_END
