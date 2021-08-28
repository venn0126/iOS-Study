//
//  SNHotViewCell.h
//  TestWidgetDemo
//
//  Created by Augus on 2021/8/28.
//

#import <UIKit/UIKit.h>
@class SNHotItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface SNHotViewCell : UITableViewCell

- (void)configCellData:(SNHotItemModel *)model;

@end

NS_ASSUME_NONNULL_END
