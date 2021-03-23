//
//  NWUser.h
//  NWModel
//
//  Created by Augus on 2021/2/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NWUser : NSObject

@property (nonatomic, assign) NSUInteger uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;


@end

NS_ASSUME_NONNULL_END
