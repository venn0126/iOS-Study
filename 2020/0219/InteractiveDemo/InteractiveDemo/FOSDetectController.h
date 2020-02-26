//
//  FOSDetectController.h
//  InteractiveDemo
//
//  Created by Wei Niu on 2018/11/13.
//  Copyright © 2018年 Fosafer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^imageBlock)(id result);
@interface FOSDetectController : UIViewController

@property (nonatomic, assign) BOOL isPortrait;
@property (nonatomic, copy) imageBlock imageCallBack;
@property (nonatomic, assign) NSInteger index;




@end

NS_ASSUME_NONNULL_END
