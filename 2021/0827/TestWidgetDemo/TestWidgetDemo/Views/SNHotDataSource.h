//
//  SNHotDataSource.h
//  TestWidgetDemo
//
//  Created by Augus on 2021/8/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SNHotItemModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^config)(id cell,id model,NSIndexPath *indexPath);

@interface SNHotDataSource : NSObject<UITableViewDataSource>

- (instancetype)initWithIdentifier:(NSString *)identifier config:(config)config;
@property (nonatomic, copy) NSArray<SNHotItemModel *> *items;


@end

NS_ASSUME_NONNULL_END
