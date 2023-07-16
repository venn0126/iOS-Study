//
//  GTClassModel.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import <Foundation/Foundation.h>


@class GTIvarModel, GTPropertyModel, GTMethodModel, GTProtocolModel, GTSemanticString;

NS_ASSUME_NONNULL_BEGIN

@interface GTClassModel : NSObject

/// The Obj-C runtime @c Class
@property (weak, nonatomic, readonly) Class backing;
/// The name of the class, e.g. @c NSObject
@property (strong, nonatomic, readonly) NSString *name;
/// The protocols the class conforms to
@property (strong, nonatomic, readonly) NSArray<GTProtocolModel *> *protocols;

@property (strong, nonatomic, readonly) NSArray<GTPropertyModel *> *classProperties;
@property (strong, nonatomic, readonly) NSArray<GTPropertyModel *> *instanceProperties;

@property (strong, nonatomic, readonly) NSArray<GTMethodModel *> *classMethods;
@property (strong, nonatomic, readonly) NSArray<GTMethodModel *> *instanceMethods;
/// Instance variables, including values synthesized from properties
@property (strong, nonatomic, readonly) NSArray<GTIvarModel *> *ivars;

- (instancetype)initWithClass:(Class)cls;
+ (instancetype)modelWithClass:(Class)cls;
/// Generate an @c interface for the class
/// @param comments Generate comments with information such as the
///   image or category the declaration was found in
/// @param synthesizeStrip Remove methods and ivars synthesized from properties
- (NSString *)linesWithComments:(BOOL)comments synthesizeStrip:(BOOL)synthesizeStrip;

- (GTSemanticString *)semanticLinesWithComments:(BOOL)comments synthesizeStrip:(BOOL)synthesizeStrip;

/// Classes the class references in the declaration
///
/// In other words, all the classes that the compiler would need to see
/// for the header to pass the type checking stage of compilation.
- (NSSet<NSString *> *)classReferences;
/// Protocols the class references in the declaration
///
/// In other words, all the protocols that the compiler would need to see
/// for the header to pass the type checking stage of compilation.
- (NSSet<NSString *> *)protocolReferences;

@end

NS_ASSUME_NONNULL_END
