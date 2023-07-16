//
//  GTVariableModel.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import <Foundation/Foundation.h>

@class GTParseType;

NS_ASSUME_NONNULL_BEGIN

@interface GTVariableModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) GTParseType *type;

@end

NS_ASSUME_NONNULL_END
