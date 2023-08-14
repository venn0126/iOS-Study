//
//  GuanBaseTableCell.h
//  TestHookEncryption
//
//  Created by Augus on 2023/8/14.
//

#import <UIKit/UIKit.h>


/// MARK: 全局变量
///

#define kGuanTableScreenWidth [UIScreen mainScreen].bounds.size.width
#define kGuanTableScreenHeight [UIScreen mainScreen].bounds.size.height

/// Cell类型


/// 常用间距
static const CGFloat kGuanTitleLeftMargin = 20.0;


NS_ASSUME_NONNULL_BEGIN

@class GuanBaseTableCell, GuanSwitch, GuanCellModel;

@protocol GuanBaseTableCellDelegate <NSObject>

@optional

/// 右侧是开关的点击事件
/// - Parameters:
///   - cell: 当前cell
///   - switcher: 当前开关
- (void)guanRigthSwitcherCell:(GuanBaseTableCell *)cell actionForSwitcher:(GuanSwitch *)switcher;

/// 右侧是文本的点击事件
/// - Parameters:
///   - cell: 当前cell
///   - label: 当前文本
- (void)guanRigthLabelCell:(GuanBaseTableCell *)cell actionForTap:(UITapGestureRecognizer *)tap;


@end

@interface GuanBaseTableCell : UITableViewCell


/// 基础cell的某个区域的回调代理
@property (nonatomic, weak) id<GuanBaseTableCellDelegate> delegate;


/// 配置cell的数据
/// - Parameter model: 模型
- (void)configureModel:(GuanCellModel *)model;


/// 自定义子视图
- (void)configureSubviews;

@end

NS_ASSUME_NONNULL_END
