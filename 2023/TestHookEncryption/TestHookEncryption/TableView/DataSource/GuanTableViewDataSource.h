//
//  GuanTableViewDataSource.h
//  TestHookEncryption
//
//  Created by Augus on 2023/8/14.
//

#import <UIKit/UIKit.h>
@class GuanSectionModel;

NS_ASSUME_NONNULL_BEGIN

@interface GuanTableViewDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithDataArray:(NSArray <GuanSectionModel *>*)dataArray;

@end

NS_ASSUME_NONNULL_END
