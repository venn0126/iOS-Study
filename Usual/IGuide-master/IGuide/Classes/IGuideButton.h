//
//  IGuideButton.h
//  IIGuideViewController
//
//  Created by whatsbug on 2019/12/18.
//  Copyright © 2019 whatsbug. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IGuideButtonDelegate <NSObject>

@optional

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer;

@end

@interface IGuideButton : UIButton

@property(nonatomic, assign) UIEdgeInsets safeInsets;
@property(nonatomic, weak) id<IGuideButtonDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
