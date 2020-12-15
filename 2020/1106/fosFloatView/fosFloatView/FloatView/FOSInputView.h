//
//  FOSInputView.h
//  fosFloatView
//
//  Created by Augus on 2020/11/9.
//

#import <UIKit/UIKit.h>


typedef void (^voiceClick)(void);


NS_ASSUME_NONNULL_BEGIN

@interface FOSInputView : UIView

@property (nonatomic, copy) voiceClick voiceBlock;


@end

NS_ASSUME_NONNULL_END
