//
//  GTUtilies.h
//  TestHookEncryption
//
//  Created by Augus on 2023/7/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


typedef void(^GTUtiliesCompletionHandler)(void);

typedef enum : NSUInteger {
    /// 自己创建的类
    GTUtiliesClassTypeOwn,
    /// 全部的类，包括系统的
    GTUtiliesClassTypeAll,

} GTUtiliesClassType;


FOUNDATION_EXTERN void guan_showAlert(id self);
FOUNDATION_EXTERN int guan_statusToken(void);
FOUNDATION_EXTERN BOOL guan_tgtgtgtgtg(void);
FOUNDATION_EXTERN void guan_clearToken(void);


@interface GTUtilies : NSObject


+ (void)serviceHeaderName:(NSString *)name;

+ (instancetype)shared;

@property (nonatomic, copy) NSString *allUserId;

/// 解析某个头文件，然后下载到沙盒
/// - Parameters:
///   - name: 头文件名
///   - path: 下载路径
+ (void)serviceHeaderName:(NSString *)name path:(nullable NSString *)path;


+ (BOOL)parseClassHeaderWritePath:(nullable NSString *)path withName:(NSString *)name fileDataString:(NSString *)string;

+ (BOOL)parseClassHeaderWritePath:(nullable NSString *)path withName:(NSString *)name fileData:(NSData *)data;

+ (BOOL)parseClassHeaderWithName:(NSString *)name fileData:(NSData *)data;

+ (BOOL)parseClassHeaderWithName:(NSString *)name fileDataString:(NSString *)string;


/// 解析下载指定的类到某个路径
/// - Parameters:
///   - type: 类的类型
///   - path: 下载路径，可以为空，默认值为～/Document/guan/Headers/
+ (void)downloadOwnClassHeaderType:(GTUtiliesClassType)type toPath:(nullable NSString *)path;

+ (void)downloadOwnClassHeaderType:(GTUtiliesClassType)type;


/// 动态库插件适配的非系统的头文件下载
/// - Parameter path: 下载路径
+ (void)tweakDownloadOwnClassHeaderToPath:(nullable NSString *)path;

+ (void)tweakDownloadOwnClassHeader;


/// 视频转音频
/// - Parameters:
///   - videoPath: 需要转的视频路径
///   - audioPath: 需要导出的音频路径
///   - handler: 回调
+ (void)convertVideoPath:(NSString *)videoPath toAudioPath:(NSString *)audioPath completion:(GTUtiliesCompletionHandler)handler;

+ (UIWindow *)keyWindow;

+ (NSArray <UIWindow *> *)windows;

/// 调用二进制路径
+ (NSString *)pathForCallImage;

+ (void)gt_clearAppData;

+ (UIViewController *)currentViewController;

+ (NSString *)guan_Timestamp;

+ (NSString *)guan_udid;

+ (NSString *)guan_localAuthData:(NSString *)data key:(NSString *)key;

+ (NSString * _Nullable)dictionaryToJson:(NSDictionary *)dictionary;

+ (NSDictionary * _Nullable)jsonToDictionary:(NSString *)json;

+ (NSString *)guan_deviceID;


/// 是否是整点
+ (BOOL)guan_isWholeHour;

/// 是否是零点
+ (BOOL)guan_isZeroHour;

@end

NS_ASSUME_NONNULL_END
