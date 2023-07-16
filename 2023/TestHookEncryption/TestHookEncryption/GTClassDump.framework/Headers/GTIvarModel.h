//
//  GTIvarModel.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@class GTParseType, GTSemanticString;

NS_ASSUME_NONNULL_BEGIN

@interface GTIvarModel : NSObject

/// The Obj-C runtime @c Ivar
@property (nonatomic, readonly) Ivar backing;
/// The name of the ivar, e.g. @c _name
@property (strong, nonatomic, readonly) NSString *name;
/// The type of the ivar
@property (strong, nonatomic, readonly) GTParseType *type;

- (instancetype)initWithIvar:(Ivar)ivar;
+ (instancetype)modelWithIvar:(Ivar)ivar;

- (GTSemanticString *)semanticString;

@end

NS_ASSUME_NONNULL_END
