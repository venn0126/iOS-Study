//
//  GuanTableViewDataSource.h
//  TestHookEncryption
//
//  Created by Augus on 2023/8/14.
//

#import <UIKit/UIKit.h>
@class GuanSectionModel;


typedef void(^GuanTableViewDataSourceBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface GuanTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, copy) GuanTableViewDataSourceBlock reloadDataBlock;

- (instancetype)initWithDataArray:(NSArray <GuanSectionModel *>* _Nullable)dataArray;

@end

NS_ASSUME_NONNULL_END
