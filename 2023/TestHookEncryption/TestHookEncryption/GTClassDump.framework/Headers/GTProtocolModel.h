//
//  GTProtocolModel.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import <Foundation/Foundation.h>


@class GTMethodModel, GTPropertyModel, GTSemanticString, GTParseType;

NS_ASSUME_NONNULL_BEGIN

@interface GTProtocolModel : NSObject

/// The Obj-C runtime @c Protocol
@property (strong, nonatomic, readonly) Protocol *backing;
/// The name of the protocol, e.g. @c NSObject
@property (strong, nonatomic, readonly) NSString *name;
/// The protocols the protocol conforms to
@property (strong, nonatomic, readonly) NSArray<GTProtocolModel *> *protocols;

@property (strong, nonatomic, readonly) NSArray<GTPropertyModel *> *requiredClassProperties;
@property (strong, nonatomic, readonly) NSArray<GTPropertyModel *> *requiredInstanceProperties;

@property (strong, nonatomic, readonly) NSArray<GTMethodModel *> *requiredClassMethods;
@property (strong, nonatomic, readonly) NSArray<GTMethodModel *> *requiredInstanceMethods;

@property (strong, nonatomic, readonly) NSArray<GTPropertyModel *> *optionalClassProperties;
@property (strong, nonatomic, readonly) NSArray<GTPropertyModel *> *optionalInstanceProperties;

@property (strong, nonatomic, readonly) NSArray<GTMethodModel *> *optionalClassMethods;
@property (strong, nonatomic, readonly) NSArray<GTMethodModel *> *optionalInstanceMethods;

- (instancetype)initWithProtocol:(Protocol *)prcl;
+ (instancetype)modelWithProtocol:(Protocol *)prcl;

/// Generate an @c interface for the protocol
/// @param comments Generate comments with information such as the
///   image the declaration was found in
/// @param synthesizeStrip Remove methods and ivars synthesized from properties
- (NSString *)linesWithComments:(BOOL)comments synthesizeStrip:(BOOL)synthesizeStrip;

- (GTSemanticString *)semanticLinesWithComments:(BOOL)comments synthesizeStrip:(BOOL)synthesizeStrip;

/// Classes the protocol references in the declaration
///
/// In other words, all the classes that the compiler would need to see
/// for the header to pass the type checking stage of compilation.
- (NSSet<NSString *> *)classReferences;
/// Protocols the protocol references in the declaration
///
/// In other words, all the protocols that the compiler would need to see
/// for the header to pass the type checking stage of compilation.
- (NSSet<NSString *> *)protocolReferences;

@end

NS_ASSUME_NONNULL_END
