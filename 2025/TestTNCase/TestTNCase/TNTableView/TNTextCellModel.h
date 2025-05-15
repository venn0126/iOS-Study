//
//  TNTextCellModel.h
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import "TNCellModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TNTextCellModel : TNCellModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *contentFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *contentColor;




@end

NS_ASSUME_NONNULL_END
