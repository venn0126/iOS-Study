//
//  SNHotViewModel.h
//  TestWidgetDemo
//
//  Created by Augus on 2021/8/27.
//

#import <Foundation/Foundation.h>

@class SNHotItemModel;


typedef enum : NSUInteger {
    SNViewModelTypeHot,
    SNViewMddelTypeBroadcast,
} SNViewModelType;

NS_ASSUME_NONNULL_BEGIN

typedef void(^success) (id data);
typedef void(^fail) (void);

@interface SNHotViewModel : NSObject

/// To update model for ViewModel
/// 业务逻辑，网络请求，数据缓存...
- (instancetype)initWithSuccess:(success)success fail:(fail)fail;

// 选中的标签
@property (nonatomic, copy) NSString *seletName;
// 存放数据数组
@property (nonatomic, strong, readonly) NSMutableArray<SNHotItemModel *> *items;
// Refresh Action
- (void)refreshSNHotViewModel:(SNViewModelType)type;


@end

NS_ASSUME_NONNULL_END
