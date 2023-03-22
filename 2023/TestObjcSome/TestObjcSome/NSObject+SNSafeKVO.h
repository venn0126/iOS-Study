//
//  NSObject+SNSafeKVO.h
//  TestObjcSome
//
//  Created by Augus on 2023/3/22.
//

#import <Foundation/Foundation.h>

/*
 
 crash:  An -observeValueForKeyPath:ofObject:change:context: message was received but not handled. Key path: position Observed objec
 
 
 监听者dealloc时，监听关系还存在。当监听值发生变化时，会给监听者的野指针发送消息，报野指针Crash。（底层是保存了unsafe_unretained指向监听者的指针）
 被监听者dealloc时，监听关系还存在。在监听者内存free掉后，直接会报监听者还存在监听关系而Crash；
 移除监听次数大于添加监听次数。报出多次移除的错误；
 
 最终解决：
 监听者dealloc时，自动移除监听者对其他对象的监听，No Crash；
 被监听者dealloc时，自动移除对被监听者所有的监听，No Crash；
 移除监听次数大于添加监听次数时，多次监听/移除，只执行一次，No Crash；

 */


NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SNSafeKVO)

/// 添加监听者
/// - Parameters:
///   - observer: 监听者
///   - keyPath: 监听路径
///   - options: 可选值
///   - context: 监听上下文
- (void)augus_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
                  context:(nullable void *)context;



///  移除监听者
/// - Parameters:
///   - observer:  监听者
///   - keyPath: 监听路径
///   - context: 监听上下文
- (void)augus_removeObserver:(NSObject *)observer
               forKeyPath:(NSString *)keyPath
                  context:(nullable void *)context;


/// 移除监听者
/// - Parameters:
///   - observer: 监听者
///   - keyPath: 监听路径
- (void)augus_removeObserver:(NSObject *)observer
               forKeyPath:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
