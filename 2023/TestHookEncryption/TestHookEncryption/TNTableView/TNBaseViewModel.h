//
//  TNBaseViewModel.h
//  TestHookEncryption
//
//  Created by Augus on 2025/5/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TNBaseViewModel : NSObject

@property (nonatomic, copy) void (^onDataChanged)(void);

- (void)reloadData;
- (void)notifyDataChanged;

@end

NS_ASSUME_NONNULL_END
