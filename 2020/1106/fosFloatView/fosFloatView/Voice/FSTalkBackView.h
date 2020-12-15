//
//  FSTalkBackView.h
//  fosFloatView
//
//  Created by Augus on 2020/11/10.
//

#import <UIKit/UIKit.h>

typedef void (^talkBackBlock)(void);

NS_ASSUME_NONNULL_BEGIN

//----------------------对讲界面---------------------------------//

@interface FSTalkBackView : UIView

@property (nonatomic, copy) talkBackBlock talkBackBlock;


@end

NS_ASSUME_NONNULL_END
