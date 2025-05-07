//
//  TNTextCell.h
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import <UIKit/UIKit.h>
#import "TNTextCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TNTextCell : UITableViewCell

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *contentLabel;

- (void)configureWithModel:(TNTextCellModel *)model;


@end

NS_ASSUME_NONNULL_END
