//
//  DDTabBarController.h
//  DDDemo
//
//  Created by Augus on 2021/5/16.
//

#import <UIKit/UIKit.h>

typedef void (^completionHander)(void);

NS_ASSUME_NONNULL_BEGIN


@interface DDTabBarController : UITabBarController

- (void)dd_updateTabBarIcon:(completionHander)completion;

@end

NS_ASSUME_NONNULL_END
