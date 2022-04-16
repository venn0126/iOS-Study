//
//  GTViewModel.h
//  CADisplayLinkTest
//
//  Created by Augus on 2022/4/16.
//

#import <Foundation/Foundation.h>

typedef void(^viewModelBlock)(id _Nullable result, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface GTViewModel : NSObject

- (instancetype)initWithObserverName:(NSString *)observerName;

- (void)bindDataWithBlock:(viewModelBlock)viewModelBlock;

- (void)loadData;

@end

NS_ASSUME_NONNULL_END
