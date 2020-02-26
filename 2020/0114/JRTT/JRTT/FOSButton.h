//
//  FOSButton.h
//  JRTT
//
//  Created by Augus on 2020/2/14.
//  Copyright © 2020 fosafer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FOSButton : UIControl

- (void)fos_addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
