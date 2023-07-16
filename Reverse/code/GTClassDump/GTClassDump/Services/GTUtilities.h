//
//  GTUtilities.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTUtilities : NSObject

/// The paths of the images in the loaded dyld shared cache
+ (NSArray<NSString *> *)dyldSharedCacheImagePaths;

@end

NS_ASSUME_NONNULL_END
