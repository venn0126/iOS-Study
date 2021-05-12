//
//  YSPlayerController.h
//  NWUITest
//
//  Created by Augus on 2021/5/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSPlayerController : NSObject

- (id)initWithURL:(NSURL *)url;

@property (nonatomic, strong, readonly) UIView *view;


@end

NS_ASSUME_NONNULL_END
