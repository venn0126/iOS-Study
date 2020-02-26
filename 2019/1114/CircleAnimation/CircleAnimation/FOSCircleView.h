//
//  FOSCircleView.h
//  CircleAnimation
//
//  Created by Augus on 2019/11/14.
//  Copyright © 2019 fosafer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FOSCircleView : UIView


- (instancetype)initWithFrame:(CGRect)frame views:(NSArray *)views;
- (void)setViewHighlightedIndex:(NSInteger)aTag;
- (void)resetViewState;
- (BOOL)viewStateForIndex:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END
