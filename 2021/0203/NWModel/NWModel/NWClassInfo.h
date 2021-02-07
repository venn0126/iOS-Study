//
//  NWClassInfo.h
//  NWModel
//
//  Created by Augus on 2021/2/5.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_OPTIONS(NSUInteger, NWEncodeType){
    
    NWEncodeTypeMask            = 0xFF,/// <mask of type value
    NWEncodeTypeUnknown         = 0,/// < unknown
    NWEncodeTypeVoid            = 1,/// < void
    NWEncodeTypeBool            = 2,/// < bool
    NWEncodeTypeInt8            = 3,/// < char / BOOL
    NWEncodeTypeUInt8           = 4,/// < unsigned char
    NWEncodeTypeInt16           = 5,/// < unsigned short
    NWEncodeTypeUInt16          = 6,/// < unsigned short
    NWEncodeTypeInt32           = 7,/// < int
    NWEncodeTypeUInt32          = 8,/// < unsigned int
    NWEncodeTypeInt64           = 9,/// < long long
    NWEncodeTypeUInt64          = 10,/// < unsigned long long
    NWEncodeTypeFloat           = 11,/// < float
    NWEncodeTypeDoubel          = 12,/// < double
    NWEncodeTypeLongDoubel      = 13, /// < long double
    NWEncodeTypeObject          = 14, /// < id
    NWEncodeTypeClass           = 15, /// < Class
    NWEncodeTypeSEL             = 16, /// < SEL
    NWEncodeTypeBlock           = 17, /// < Block
    NWEncodeTypePointer         = 18, /// < void*
    NWEncodeTypeStruct          = 19, /// < struct
    NWEncodeTypeUnion           = 20, /// < union
    NWEncodeTypeCString         = 21, /// < char*
    NWEncodeTypeCArray      = 22, /// < char[15] (for example)
    
    NWEncodeTypeQualifierMask   = 0xFF00,   /// < mask of qualifier
    NWEncodeTypeQualifierConst  = 1 << 8,   /// < const
    NWEncodeTypeQualifierIn     = 1 << 9,   /// < in
    NWEncodeTypeQualifierInout  = 1 << 10,  /// < inout
    NWEncodeTypeQualifierOut    = 1 << 11,  /// < out
    NWEncodeTypeQualifierBycopy = 1 << 12,  /// < by copy
    NWEncodeTypeQualifierByref  = 1 << 13,  /// < byref
    NWEncodeTypeQualifierOneway = 1 << 14,  /// < oneway
    
    NWEncodeTypePropertyMask             = 0xFF0000, /// < mask of property
    NWEncodeTypePropertyReadonly         = 1 << 16,  /// < readonly
    NWEncodeTypePropertyCopy             = 1 << 17,  /// < copy
    NWEncodeTypePropertyRetain           = 1 << 18,  /// < retain
    NWEncodeTypePropertyNonatomic        = 1 << 19,  /// < nonatomic
    NWEncodeTypePropertyWeak             = 1 << 20,  /// < weak
    NWEncodeTypePropertyCustomGetter     = 1 << 21,  /// < getter=
    NWEncodeTypePropertyCustomSetter     = 1 << 22,  /// < setter=
    NWEncodeTypePropertyDynamic          = 1 << 23,  /// < @dynamic






};

/**
 Get the type from a Type-Encoding string.
 
 @param typeEncoding A type-Encoding string.
 
 @return The encoding type.
 */
NWEncodeType NWEncodingGetType(const char * typeEncoding);


/**
 Instance varibale information.
 */
@interface NWClassIvarInfo : NSObject
@property (nonatomic, assign, readonly) Ivar ivar;                  /// < ivar opauqe struct
@property (nonatomic, copy, readonly) NSString *name;             /// < ivar's name
@property (nonatomic, assign, readonly) ptrdiff_t offset;           /// < ivar's offset
@property (nonatomic, copy, readonly) NSString *typeEncoding;     /// < ivar's type encoding
@property (nonatomic, assign, readonly) NWEncodeType type;          /// < ivar's type

/**
 Creates and returns an ivar info object.
 
 @param ivar ivar opaque struct
 
 @return A new object, or nil if error occurs.
 */
- (instancetype)initWithIvar:(Ivar)ivar;
@end


/**
 Method infomation
 */
@interface NWClassMethodInfo : NSObject
@property (nonatomic, assign, readonly)  Method method;         /// < method opaque struct
@property (nonatomic, copy, readonly) NSString *name;           /// < method's name
@property (nonatomic, assign, readonly) SEL sel;                /// < method's selector
@property (nonatomic, assign, readonly) IMP imp;                /// < method's implementation
@property (nonatomic, copy, readonly) NSString *typeEncoding;   /// < method's parameter and return types
@property (nonatomic, copy, readonly) NSString *returnTypeEncoding;     /// < return values' type encoding
@property (nullable, nonatomic, copy, readonly) NSArray<NSString *> *argumentTypeEncodings;     /// < array of arguments's type

/**
 Creates and returns a method info object.
 
 @param method method opaque struct.
 
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithMethod:(Method)method;
@end


/**
 Property infomation.
 */
@interface NWClassPropertyInfo : NSObject
@property (nonatomic, assign, readonly)  objc_property_t property;          /// < property's opaque struct
@property (nonatomic, copy, readonly) NSString *name;                       /// < property's name
@property (nonatomic, assign, readonly) NWEncodeType type;                  /// < property's type
@property (nonatomic, copy, readonly) NSString *typeEncoding;               /// < property's encoding value
@property (nonatomic, copy, readonly) NSString *ivarName;                   /// < property's ivar name
@property (nullable, nonatomic, assign, readonly) Class cls;                /// < may be nil
@property (nullable, nonatomic, assign, readonly) NSArray<NSString *> *protocols;                   /// < may be nil
@property (nonatomic, assign, readonly)  SEL getter;                         /// < getter(nonnull)
@property (nonatomic, assign, readonly)  SEL setter;                         /// < setter(nonnull)

/**
 Creates and returns a property info object.
 
 @param property property opaque struct.
 
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithProperty:(objc_property_t)property;
@end

/**
 Class infomation for a class
 */
@interface NWClassInfo : NSObject
@property (nonatomic, assign, readonly) Class cls;                /// < class object
@property (nullable, nonatomic, assign, readonly) Class superCls; /// < super class object
@property (nullable, nonatomic, assign, readonly) Class metaCls;  /// < class's meta class object
@property (nonatomic, assign, readonly) BOOL isMeta;              /// < whether this class is meta class
@property (nonatomic, copy, readonly) NSString *name;             /// < class's name
@property (nullable, nonatomic, strong, readonly) NWClassInfo *superClassInfo;  /// < super class's class info
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *,NWClassIvarInfo *> *ivarInfos;            /// < ivars
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *,NWClassMethodInfo *> *methodInfos;        /// < methods
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *,NWClassPropertyInfo *> *propertyInfos;    /// < properties

/**
 If the class is changed (for example: you add a method to this class with
 `class_addMethod()`),you should call this method to refresh the class info cache.
 
 After called this method,`needUpdate` will returns `YES`, and you should call
 `classInfoWithClass` or `classInfoWithClassName` to get the updated class info.
 */
- (void)setNeedUpdate;

/**
 If this method returns `YES`,you should stop using this intance and call
 `classInfoWithClass` or `classInfoWithClassName` to get the updated class info.
 
 @return Whether this class info need update.
 */
- (BOOL)needUpdate;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. The method is thread-safe.
 
 @param cls A class
 
 @return A class info, or nil if an error occurs.
 */
+ (nullable instancetype)classInfoWithClass:(Class)cls;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. The method is thread-safe.
 
 @param className A class's names
 
 @return A class info, or nil if an error occurs.
 */
+ (nullable instancetype)classInfoWithClassName:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
