//
//  GTParseType.h
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import <Foundation/Foundation.h>
#import <GTSemanticString.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GTTypeModifier) {
    GTTypeModifierConst,
    GTTypeModifierComplex,
    GTTypeModifierAtomic,
    
    GTTypeModifierIn,
    GTTypeModifierInOut,
    GTTypeModifierOut,
    GTTypeModifierBycopy,
    GTTypeModifierByref,
    GTTypeModifierOneway,
    
    /// The number of valid cases there are in @c GTTypeModifier
    GTTypeModifierCount
};

OBJC_EXTERN NSString *_Nullable NSStringFromGTTypeModifier(GTTypeModifier);

@interface GTParseType : NSObject


@property (nullable, strong, nonatomic) NSArray<NSNumber *> *modifiers; // array of GTTypeModifier

/// A string as this type would appear in code for a given variable name.
///
/// @param varName The name of the variable this type is for
- (nonnull NSString *)stringForVariableName:(nullable NSString *)varName;

- (nonnull NSString *)modifiersString;

- (nonnull GTSemanticString *)semanticStringForVariableName:(nullable NSString *)varName;

- (nonnull GTSemanticString *)modifiersSemanticString;

/// Classes this type references
///
/// For example, `NSCache<NSFastEnumeration> *` references the "NSCache" class
- (nullable NSSet<NSString *> *)classReferences;
/// Protocols this type references
///
/// For example, `NSCache<NSFastEnumeration> *` references the "NSFastEnumeration" protocol
- (nullable NSSet<NSString *> *)protocolReferences;


@end

NS_ASSUME_NONNULL_END
