//
//  FOSGuideView.h
//  fosFloatView
//
//  Created by Augus on 2020/11/9.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    FOSGuideViewStyleDefault,
    FOSGuideViewStyleHidden,
} FOSGuideViewStyle;

NS_ASSUME_NONNULL_BEGIN

@interface FOSGuideView : UIView

@property (nonatomic, assign)  FOSGuideViewStyle style;


@end

NS_ASSUME_NONNULL_END
