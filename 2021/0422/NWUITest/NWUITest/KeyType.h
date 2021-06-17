//
//  KeyType.h
//  NWUITest
//
//  Created by Augus on 2021/6/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyType : NSObject<NSCopying>

@property (nonatomic, copy) NSString *keyName;
- (instancetype)initWithKeyName:(NSString *)keyName;


@end

NS_ASSUME_NONNULL_END
