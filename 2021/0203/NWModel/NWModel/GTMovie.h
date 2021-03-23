//
//  GTMovie.h
//  NWModel
//
//  Created by Augus on 2021/3/17.
//

#import <Foundation/Foundation.h>
#import "NWUser.h"
#import "NSObject+GTModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GTMovie : NSObject<NSCoding>

@property (nonatomic, strong) NWUser *user;
@property (nonatomic, copy) NSString *movieId;
@property (nonatomic, copy) NSString *movieName;
@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, copy) NSArray<NWUser *> *userArray;



@end

NS_ASSUME_NONNULL_END
