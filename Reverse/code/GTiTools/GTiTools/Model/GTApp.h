//
//  GTApp.h
//  GTiTools
//
//  Created by Augus on 2022/12/1.
//

#import <Foundation/Foundation.h>

@class GTMachO, FBApplicationInfo;

NS_ASSUME_NONNULL_BEGIN


@interface GTApp : NSObject

@property(copy, nonatomic, readonly) NSString *bundlePath;
@property(copy, nonatomic, readonly) NSString *dataPath;
@property(copy, nonatomic, readonly) NSString *bundleIdentifier;
@property(copy, nonatomic, readonly) NSString *displayName;
@property(copy, nonatomic, readonly) NSString *executableName;
@property(assign, nonatomic, readonly, getter=isSystemApp) BOOL systemApp;
@property(assign, nonatomic, readonly, getter=isHidden) BOOL hidden;
@property (strong, nonatomic, readonly) GTMachO *executable;

- (instancetype)initWithInfo:(FBApplicationInfo *)info;
+ (instancetype)appWithInfo:(FBApplicationInfo *)info;

- (void)setupExecutable;

@end

NS_ASSUME_NONNULL_END
