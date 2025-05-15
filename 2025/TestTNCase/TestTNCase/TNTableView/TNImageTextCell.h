//
//  TNImageTextCell.h
//  TestHookEncryption
//
//  Created by Augus on 2025/5/7.
//

#import <UIKit/UIKit.h>
#import "TNImageTextCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TNImageTextCell : UITableViewCell

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *contentLabel;
@property (nonatomic, strong, readonly) UIImageView *customImageView;

- (void)configureWithModel:(TNImageTextCellModel *)model;


@end

NS_ASSUME_NONNULL_END
