//
//  FSBottomView.h
//  fosFloatView
//
//  Created by Augus on 2020/11/11.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FosBottomViewMode) {
    
    FosBottomViewModeSpeech,
    FosBottomViewModeHand
};


NS_ASSUME_NONNULL_BEGIN

@interface FSBottomView : UIView

@property (nonatomic, assign)  FosBottomViewMode mode;


@end

NS_ASSUME_NONNULL_END
