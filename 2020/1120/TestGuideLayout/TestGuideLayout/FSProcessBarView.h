//
//  FSProcessBarView.h
//  TestGuideLayout
//
//  Created by Augus on 2021/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSProcessBarView : UIView

@property (nonatomic, assign)  CGFloat progress;


- (void)startProcessAnimation;
- (void)stopProcessAnimation;



@end

NS_ASSUME_NONNULL_END
