//
//  FSMessageCell.h
//  fosFloatView
//
//  Created by Augus on 2020/11/11.
//

#import <UIKit/UIKit.h>
#import "FSMessageFrameModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSMessageCell : UITableViewCell

@property (nonatomic, strong) FSMessageFrameModel *messageFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end

NS_ASSUME_NONNULL_END
