//
//  MengTableViewDataSource.h
//  TestHookEncryption
//
//  Created by Augus on 2023/10/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GuanSectionModel;

typedef void(^MengTableViewDataSourceBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface MengTableViewDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, copy) MengTableViewDataSourceBlock reloadDataBlock;

- (instancetype)initWithDataArray:(NSArray <GuanSectionModel *>* _Nullable)dataArray;

@end

NS_ASSUME_NONNULL_END
