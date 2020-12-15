//
//  FSGuideButton.h
//  fosFloatView
//
//  Created by Augus on 2020/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol FSGuideButtonDelegate <NSObject>

@optional

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer;

@end

@interface FSGuideButton : UIButton

@property(nonatomic, assign) UIEdgeInsets safeInsets;
@property(nonatomic, weak) id<FSGuideButtonDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
