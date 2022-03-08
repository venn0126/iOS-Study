//
//  UIDevice+Helper.h
//  TestStingNil
//
//  Created by Augus on 2022/3/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Helper)

/**
 Vendor 标识符，重新安装会变

 @return Vendor 标识符
 */
+ (NSString *)deviceIDFV;

@end

NS_ASSUME_NONNULL_END
