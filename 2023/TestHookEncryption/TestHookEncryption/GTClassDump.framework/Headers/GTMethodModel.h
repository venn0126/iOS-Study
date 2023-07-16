//
//  GTMethodModel.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@class GTParseType, GTSemanticString;


NS_ASSUME_NONNULL_BEGIN

@interface GTMethodModel : NSObject

/// The Obj-C runtime @c objc_method_description
@property (nonatomic, readonly) struct objc_method_description backing;
/// The signature of the method, e.g. @c initWithMethod:isClass:
@property (strong, nonatomic, readonly) NSString *name;
/// The types of the arguments to the method, e.g. @c [id, @c BOOL]
@property (strong, nonatomic, readonly) NSArray<GTParseType *> *argumentTypes;
/// The return type of the method
@property (strong, nonatomic, readonly) GTParseType *returnType;
/// If the method is a class method, otherwise an instance method
@property (nonatomic, readonly) BOOL isClass;

- (instancetype)initWithMethod:(struct objc_method_description)methd isClass:(BOOL)isClass;
+ (instancetype)modelWithMethod:(struct objc_method_description)methd isClass:(BOOL)isClass;

- (GTSemanticString *)semanticString;

/// Classes the method references in the declaration
///
/// In other words, all the classes that the compiler would need to see
/// for the header to pass the type checking stage of compilation.
- (NSSet<NSString *> *)classReferences;
/// Protocols the method references in the declaration
///
/// In other words, all the protocols that the compiler would need to see
/// for the header to pass the type checking stage of compilation.
- (NSSet<NSString *> *)protocolReferences;

@end

NS_ASSUME_NONNULL_END
