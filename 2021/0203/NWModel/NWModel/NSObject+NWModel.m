//
//  NSObject+NWModel.m
//  NWModel
//
//  Created by Augus on 2021/2/4.
//

#import "NSObject+NWModel.h"
#import "NWClassInfo.h"
#import <objc/message.h>

#define force_inline __inline__ __attribute__((always_inline))

typedef NS_ENUM(NSUInteger, NWEncodingNSType) {
    NWEncodingNSTypeNSUnknown = 0,
    NWEncodingNSTypeNSString,
    NWEncodingNSTypeNSMutableString,
    NWEncodingNSTypeNSValue,
    NWEncodingNSTypeNSNumber,
    NWEncodingNSTypeNSDecimalNumber,
    NWEncodingNSTypeNSData,
    NWEncodingNSTypeNSMutableData,
    NWEncodingNSTypeNSDate,
    NWEncodingNSTypeNSURL,
    NWEncodingNSTypeNSArray,
    NWEncodingNSTypeNSMutableArray,
    NWEncodingNSTypeNSDictionary,
    NWEncodingNSTypeNSMutableDictionary,
    NWEncodingNSTypeNSSet,
    NWEncodingNSTypeNSMutableSet,
};

/// Get the Foundation class type from a class.
static force_inline NWEncodingNSType NWClassGetNSType(Class cls) {
    
    if (!cls) return NWEncodingNSTypeNSUnknown;
    if ([cls isSubclassOfClass:[NSMutableString class]]) return NWEncodingNSTypeNSMutableString;
    if ([cls isSubclassOfClass:[NSString class]]) return NWEncodingNSTypeNSString;
    if ([cls isSubclassOfClass:[NSDecimalNumber class]]) return NWEncodingNSTypeNSDecimalNumber;
    if ([cls isSubclassOfClass:[NSNumber class]]) return NWEncodingNSTypeNSDecimalNumber;
    if ([cls isSubclassOfClass:[NSValue class]]) return NWEncodingNSTypeNSValue;
    if ([cls isSubclassOfClass:[NSMutableData class]]) return NWEncodingNSTypeNSMutableData;
    if ([cls isSubclassOfClass:[NSData class]]) return NWEncodingNSTypeNSData;
    if ([cls isSubclassOfClass:[NSDate class]]) return NWEncodingNSTypeNSDate;
    if ([cls isSubclassOfClass:[NSURL class]]) return NWEncodingNSTypeNSURL;
    if ([cls isSubclassOfClass:[NSMutableArray class]]) return NWEncodingNSTypeNSMutableArray;
    if ([cls isSubclassOfClass:[NSArray class]]) return NWEncodingNSTypeNSArray;
    if ([cls isSubclassOfClass:[NSMutableDictionary class]]) return NWEncodingNSTypeNSMutableDictionary;
    if ([cls isSubclassOfClass:[NSDictionary class]]) return NWEncodingNSTypeNSDictionary;
    if ([cls isSubclassOfClass:[NSMutableSet class]]) return NWEncodingNSTypeNSMutableSet;
    if ([cls isSubclassOfClass:[NSSet class]]) return NWEncodingNSTypeNSSet;
    
    return NWEncodingNSTypeNSUnknown;
}

/// Whether the type is c number.
static force_inline BOOL NWEncodingTypeIsCNumber(NWEncodeType type) {
    
    switch (type & NWEncodeTypeMask) {
        case NWEncodeTypeBool:
        case NWEncodeTypeInt8:
        case NWEncodeTypeUInt8:
        case NWEncodeTypeInt16:
        case NWEncodeTypeUInt16:
        case NWEncodeTypeInt32:
        case NWEncodeTypeUInt32:
        case NWEncodeTypeInt64:
        case NWEncodeTypeUInt64:
        case NWEncodeTypeFloat:
        case NWEncodeTypeDoubel:
        case NWEncodeTypeLongDoubel: return YES;
        default: return NO;
            
    }
}

/// Parse a number value from `id`.
static force_inline NSNumber *NWNSNumberCreateFromID(__unsafe_unretained id value) {
    
    static NSCharacterSet *dot;
    static NSDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dot = [NSCharacterSet characterSetWithRange:NSMakeRange('.', 1)];
        dic = @{@"True":@(YES),
                @"True":@(YES),
                @"true":@(YES),
                @"FALSE":@(NO),
                @"False":@(NO),
                @"false":@(NO),
                @"YES":@(YES),
                @"Yes":@(YES),
                @"yes":@(YES),
                @"NO":@(NO),
                @"No":@(NO),
                @"no":@(NO),
                @"NIL":(id)kCFNull,
                @"Nil":(id)kCFNull,
                @"nil":(id)kCFNull,
                @"NULL":(id)kCFNull,
                @"Null":(id)kCFNull,
                @"null":(id)kCFNull,
                @"(NULL)":(id)kCFNull,
                @"(Null)":(id)kCFNull,
                @"(null)":(id)kCFNull,
                @"<NULL>":(id)kCFNull,
                @"<Null>":(id)kCFNull,
                @"<null>":(id)kCFNull,
        };
    });
    
    if (!value || value == (id)kCFNull) {
        return nil;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumber *num = dic[value];
        if (num != nil) {
            if (num == (id)kCFNull) {
                return nil;
            }
            return num;
        }
        if ([(NSString *)value rangeOfCharacterFromSet:dot].location != NSNotFound) {
            const char *cstring = ((NSString *)value).UTF8String;
            if (!cstring) {
                return nil;
            }
            double num = atof(cstring);
            if (isnan(num) || isinf(num)) {
                return nil;
            }
            return @(num);
            
        }else {
            const char *cstring = ((NSString *)value).UTF8String;
            if (!cstring) {
                return nil;
            }
            return @(atoll(cstring));
        }
    }
    return nil;
}

/// Parse string to date
static force_inline NSDate *NWNSDateFromString(__unsafe_unretained NSString *string){
    typedef NSDate* (^NWNSDateParseBlock)(NSString *string);
#define kParserNum 34
    static NWNSDateParseBlock blocks[kParserNum + 1] = {0};
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        {
            /*
             2020-02-05 // Google
             */
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter.dateFormat = @"yyyy-MM-dd";
            blocks[10] = ^(NSString *string){
                return [formatter dateFromString:string];
                
            };
            
        }
        {
            /*
             2020-02-05 17:08:59
             2020-02-05T17:09:23    // Google
             2020-02-05 17:09:39.000
             2020-02-05T17:09:31.000
             */
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            formatter1.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"eu_US_POSIX"];
            formatter1.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter1.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
            
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter2.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter2.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            
            NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
            formatter3.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter3.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter3.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
            
            NSDateFormatter *formatter4 = [[NSDateFormatter alloc] init];
            formatter4.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter4.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter4.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
            
            blocks[19] = ^(NSString *string){
                if ([string characterAtIndex:10] == 'T') {
                    return [formatter1 dateFromString:string];
                }else {
                    return [formatter2 dateFromString:string];
                }
            };
            
            blocks[23] = ^(NSString *string){
                if ([string characterAtIndex:10] == 'T') {
                    return [formatter3 dateFromString:string];
                }else {
                    return [formatter4 dateFromString:string];
                }
            };
        }
        {
            
            /*
             2020-02-05T17:34:24Z       //Github,Apple
             2020-02-05T17:35:00+0800   // Facebook
             2020-02-05T17:35:45+12:00  // Google
             2020-02-05T17:37:48.000Z
             2020-02-05T12:34:44.000+0800
             2020-02-05T12:34:35.000+12:00
             */
            NSDateFormatter *formatter1 = [NSDateFormatter new];
            formatter1.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
            formatter1.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
            
            NSDateFormatter *formatter2 = [NSDateFormatter new];
            formatter2.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
            formatter2.dateFormat = @"yyyy-MM-dd'T'HH:mm:SSSZ";
            
            blocks[20] = ^(NSString *string){return [formatter1 dateFromString:string];};
            
            blocks[24] = ^(NSString *string){return [formatter1 dateFromString:string] ?: [formatter2 dateFromString:string];};
            blocks[25] = ^(NSString *string){return [formatter1 dateFromString:string];};
            blocks[28] = ^(NSString *string){return [formatter2 dateFromString:string];};
            blocks[29] = ^(NSString *string){return [formatter2 dateFromString:string];};


        }
        
        {
            /*
             Fri Jan 04 17:43:15 +0800 2020     // weibo,Twitter
             Fri Jan 04 17:43:02.000 +0800 2020
             */
            
            NSDateFormatter *formatter1 = [NSDateFormatter new];
            formatter1.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
            formatter1.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
            
            NSDateFormatter *formatter2 = [NSDateFormatter new];
            formatter2.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
            formatter2.dateFormat = @"EEE MMM dd HH:mm:ss.SSS Z yyyy";
            
            blocks[30] = ^(NSString *string){return [formatter1 dateFromString:string];};
            blocks[34] = ^(NSString *string){return [formatter2 dateFromString:string];};
        }
    
    });
    
    if (!string) {
        return nil;
    }
    if (string.length > kParserNum) {
        return nil;
    }
    NWNSDateParseBlock parser = blocks[string.length];
    if (!parser) {
        return nil;
    }
    return parser(string);
#undef kParserNum
}

/// Get the `NSBlock` class.
static force_inline Class NWNSBlockClass() {
    static Class cls;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        void (^block)(void) = ^{};
        cls = ((NSObject *)block).class;
        while (class_getSuperclass(cls) != [NSObject class]) {
            cls = class_getSuperclass(cls);
        }
    });
    
    return cls;// current is "NSBlock"
}

/**
 Get the ISO date formatter.
 
 ISO8601 format example:
 2020-02-05T16:53:30+12:00
 2020-02-05T17:53:21+0000
 2020-02-05T17:54:23Z
 
 length: 25/24/20
 */

static force_inline NSDateFormatter *NWISODateFormatter(){
    
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    });
    
    return formatter;
}

/**
 Get the value with key paths from dictionary
 
 The dic should be NSDictionary, and the keyPath should not be nil.
 */
static force_inline id NWValueForKeyPath(__unsafe_unretained NSDictionary *dic,__unsafe_unretained NSArray *keyPaths) {
    
    id value = nil;
    
    for (NSUInteger i = 0,max = keyPaths.count; i < max; i++) {
        value = dic[keyPaths[i]];
        if (i + 1 < max) {
            if ([value isKindOfClass:[NSDictionary class]]) {
                dic = value;
            }else {
                return nil;
            }
        }
    }
    return value;
}

/**
 Get the value with multi key (or key path) from dictionary
 
 The dic should be dictionary
 
 */
static force_inline id NWValueForMultiKeys(__unsafe_unretained NSDictionary *dic,__unsafe_unretained NSArray *multiKeys) {
    
    id value = nil;
    for (NSString *key in multiKeys) {
        if ([value isKindOfClass:[NSString class]]) {
            value = dic[key];
            if (value) {
                break;
            }
        }else {
            value = NWValueForKeyPath(dic, (NSArray *)key);
            if (value) {
                break;
            }
        }
    }
    return value;
}

/// A property info in object model.
@interface _NWModelPropertyMeta : NSObject{
 @package
    NSString *_name;                    /// < property's name
    NWEncodeType _type;                 /// < property's type
    NWEncodingNSType _nsType;           /// < property's Foundation type
    BOOL _isCNumber;                    /// < is c number type
    Class _cls;                         /// < property's class, or nil
    Class _genericCls;                  /// < container's generic class, or nil there'is no generic class
    SEL _getter;                        /// < getter, or nil if the instance cannot respond
    SEL _setter;                        /// < setter, or nil if the instance cannot respond
    BOOL _isKVCCompatibale;             /// < YES,if if can access with key-value coding
    BOOL _isStructAvailableForKeydArchiver;     /// < YES if the struct can encode with keyed archiver/unarchiver
    BOOL _hasCustomClassFromDictionary; /// <class/generic class implements + modelCustomClassForDictionary:
    /*
     property->key:         _mappedToKey:key        _mappedToKeyPath:nil        _mappedToKeyArray:nil
     property->keyPath:     _mappedToKey:KeyPath    _mappedToKeyPath:keyPath(array)
         _mappedToKeyArray:nil
     property->keys:        _mappedToKey:keys[0]    _mappedToKeyPath:nil/keyPath
         _mappedToKeyArray:keys(array)
     */
    
    NSString *_mappedToKey;             /// < the key mapped to
    NSArray *_mappedToKeypath;          /// < the key path mapped to (nil if the name is not key path)
    NSArray *_mappedToKeyArray;         /// < the key(NSString) or keyPath(NSArray) array (nil if not mapped to multiple keys)
    NWClassPropertyInfo *_info;         /// < property's info
    _NWModelPropertyMeta *_next;        /// < next meta if there are multiple properties mapped to the same key.
}
@end

@implementation _NWModelPropertyMeta

+ (instancetype)metaWithClassInfo:(NWClassInfo *)classInfo property:(NWClassPropertyInfo *)propertyInfo generic:(Class)generic {
    
    // support pseudo generic class with protocol name
    if (!generic && propertyInfo.protocols) {
        for (NSString *protocol in propertyInfo.protocols) {
            Class cls = objc_getClass(protocol.UTF8String);
            if (cls) {
                generic = cls;
                break;
            }
        }
    }
    
    _NWModelPropertyMeta *meta = [self new];
    meta->_name = propertyInfo.name;
    meta->_type = propertyInfo.type;
    meta->_info = propertyInfo;
    meta->_genericCls = generic;
    
    if ((meta->_type & NWEncodeTypeMask) == NWEncodeTypeObject) {
        meta->_nsType = NWClassGetNSType(propertyInfo.cls);
    }else {
        meta->_isCNumber = NWEncodingTypeIsCNumber(meta->_type);
    }
    if ((meta->_type & NWEncodeTypeMask) == NWEncodeTypeStruct) {
        /// It seems that NSKeyedUnarchiver cannot decode NSValue except these structs:
        static NSSet *types = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSMutableSet *set = [NSMutableSet new];
            // 32 bit
            [set addObject:@"{CGSize=ff}"];
            [set addObject:@"{CGPoint=ff}"];
            [set addObject:@"{CGRect={CGPoint=ff}{CGSize=ff}}"];
            [set addObject:@"{CGAffineTransform=fffff}"];
            [set addObject:@"{UIEdgeInsets=ffff}"];
            [set addObject:@"{UIOffset=ff}"];
            // 64 bit
            [set addObject:@"{CGSize=dd}"];
            [set addObject:@"{CGPoint=dd}"];
            [set addObject:@"{CGRect={CGPoint=dd}{CGSize=dd}}"];
            [set addObject:@"{CGAffineTransform=ddddd}"];
            [set addObject:@"{UIEdgeInsets=dddd}"];
            [set addObject:@"{UIOffset=dd}"];

        });
        
        if ([types containsObject:propertyInfo.typeEncoding]) {
            meta->_isStructAvailableForKeydArchiver = YES;
        }
    }
    
    meta->_cls = propertyInfo.cls;
    if (generic) {
        meta->_hasCustomClassFromDictionary = [generic respondsToSelector:@selector(nw_modelCustomClassForDictionary:)];
    }else if(meta->_cls && meta->_nsType == NWEncodingNSTypeNSUnknown){        meta->_hasCustomClassFromDictionary = [generic respondsToSelector:@selector(nw_modelCustomClassForDictionary:)];
    }
    
    // 保存属性的getter和setter
    if (propertyInfo.getter) {
        if ([classInfo.cls instancesRespondToSelector:propertyInfo.getter]) {
            meta->_getter = propertyInfo.getter;
        }
    }
    if (propertyInfo.setter) {
        if ([classInfo.cls instancesRespondToSelector:propertyInfo.setter]) {
            meta->_setter = propertyInfo.setter;
        }
    }
    
    // 属性变量是否支持KVC
    if (meta->_getter && meta->_setter) {
        /*
         KVC invalid type:
         long double
         pointer (such as SEL/CoreFountdaion object)
         */
        switch (meta->_type & NWEncodeTypeMask) {
            case NWEncodeTypeBool:
            case NWEncodeTypeInt8:
            case NWEncodeTypeUInt8:
            case NWEncodeTypeInt16:
            case NWEncodeTypeUInt16:
            case NWEncodeTypeInt32:
            case NWEncodeTypeUInt32:
            case NWEncodeTypeInt64:
            case NWEncodeTypeUInt64:
            case NWEncodeTypeFloat:
            case NWEncodeTypeDoubel:
            case NWEncodeTypeObject:
            case NWEncodeTypeClass:
            case NWEncodeTypeBlock:
            case NWEncodeTypeStruct:
            case NWEncodeTypeUnion:{
                meta->_isKVCCompatibale = YES;
            }break;
            default:break;
        }
    }
    
    return meta;
}
@end

/// A class info object model.
@interface _NWModelMeta : NSObject{
    @package
    NWClassInfo *_classInfo;
    /// Key:mapped key and key path,Value:_NWModelPropertyMeta.
    NSDictionary *_mapper;
    /// Array<_NWModelPropertyMeta>, all property meta of this model.
    NSArray *_allPropertyMetas;
    /// Array<_NWModelPropertyMeta>, property meta which is mapped to a key path.
    NSArray *_keyPathPropertyMetas;
    /// Array<_NWModelPropertyMeta>, property meta which is mapped to multi keys.
    NSArray *_multiKeysPropertyMetas;
    /// The number of mapped key (and key path), same to _mapper.count.
    NSUInteger _keyMappedCount;
    /// Model class type.
    NWEncodingNSType _nsType;
    
    BOOL _hasCustomWillTransformFromDictionary;
    BOOL _hasCustomTransformFromDictionary;
    BOOL _hasCustomTransfromToDictionary;
    BOOL _hasCustomClassFromDictionary;
}
@end

@implementation _NWModelMeta
- (instancetype)initWithClass:(Class)cls {
    NWClassInfo *classInfo = [NWClassInfo classInfoWithClass:cls];
    if (!classInfo) {
        return nil;
    }
    self = [super init];
    
    // Get black list
    NSSet *blacklist = nil;
    if ([cls respondsToSelector:@selector(nw_modelPropertyBlacklist)]) {
        NSArray *properties = [(id<NWModel>)cls nw_modelPropertyBlacklist];
        if (properties) {
            blacklist = [NSSet setWithArray:properties];
        }
    }
    // Get white list
    NSSet *whitelist = nil;
    if ([cls respondsToSelector:@selector(nw_modelPropertyWhitelist)]) {
        NSArray *properties = [(id<NWModel>)cls nw_modelPropertyWhitelist];
        if (properties) {
            whitelist = [NSSet setWithArray:properties];
        }
    }
    
    // Get container property's generic class
    NSDictionary *genericMapper = nil;
    if ([cls respondsToSelector:@selector(nw_modelContainerPropertyGenericClass)]) {
        genericMapper = [(id<NWModel>)cls nw_modelContainerPropertyGenericClass];
        if (genericMapper) {
            NSMutableDictionary *tmp = [NSMutableDictionary new];
            [genericMapper enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if (![key isKindOfClass:[NSString class]]) {
                    return;
                }
                Class meta = object_getClass(obj);
                if (!meta) {
                    return;
                }
                if (class_isMetaClass(meta)) {
                    tmp[key] = obj;
                }else if([obj isKindOfClass:[NSString class]]){
                    Class cls = NSClassFromString(obj);
                    if (cls) {
                        tmp[key] = cls;
                    }
                }
            }];
            genericMapper = tmp;
        }
    }
    
    NSMutableDictionary *allPropertyMetas = [NSMutableDictionary new];
    NWClassInfo *curClassInfo = classInfo;
    // recurseive parse super class,but ignore root class (NSObject/NSProxy)
    while (curClassInfo && curClassInfo.superCls != nil) {
        for (NWClassPropertyInfo *propertyInfo in curClassInfo.propertyInfos.allValues) {
            if (!propertyInfo.name) {
                continue;
            }
            if (blacklist && [blacklist containsObject:propertyInfo.name]) {
                continue;
            }
            if (whitelist && ![whitelist containsObject:propertyInfo.name]) {
                continue;
            }
            _NWModelPropertyMeta *meta = [_NWModelPropertyMeta metaWithClassInfo:classInfo property:propertyInfo generic:genericMapper[propertyInfo.name]];
            if (!meta || !meta->_name) {
                continue;
            }
            if (!meta->_getter || !meta->_setter) {
                continue;
            }
            if (allPropertyMetas[meta->_name]) {
                continue;
            }
            
            allPropertyMetas[meta->_name] = meta;
        }
        curClassInfo = curClassInfo.superClassInfo;
    }
    
    if (allPropertyMetas.count) {
        _allPropertyMetas = allPropertyMetas.allValues.copy;
    }
    
    // Create mapper.
    NSMutableDictionary *mapper = [NSMutableDictionary new];
    NSMutableArray *keyPathPropertyMetas = [NSMutableArray new];
    NSMutableArray *multiKeysPropertyMetas = [NSMutableArray new];
    
    if ([cls respondsToSelector:@selector(nw_modelCustomPropertyMapper)]) {
        NSDictionary *customMapper = [(id<NWModel>)cls nw_modelCustomPropertyMapper];
        [customMapper enumerateKeysAndObjectsUsingBlock:^(NSString *propertyName, NSString *mappedToKey, BOOL * _Nonnull stop) {
            _NWModelPropertyMeta *propertyMeta = allPropertyMetas[propertyName];
            if (!propertyMeta) {
                return;
            }
            [allPropertyMetas removeObjectForKey:propertyName];
            if ([mappedToKey isKindOfClass:[NSString class]]) {
                if (mappedToKey.length == 0) {
                    return;
                }
                propertyMeta->_mappedToKey = mappedToKey;
                NSArray *keyPath = [mappedToKey componentsSeparatedByString:@"."];
                for (NSString *onePath in keyPath) {
                    if (onePath.length == 0) {
                        NSMutableArray *tmp = keyPath.mutableCopy;
                        [tmp removeObject:@""];
                        keyPath = tmp;
                        break;
                    }
                }
                
                if (keyPath.count > 1) {
                    propertyMeta->_mappedToKeypath = keyPath;
                    [keyPathPropertyMetas addObject:propertyMeta];
                }
                
                propertyMeta->_next = mapper[mappedToKey] ?: nil;
                mapper[mappedToKey] = propertyMeta;
            }else if([mappedToKey isKindOfClass:[NSArray class]]){
                
                NSMutableArray *mappedToKeyArray = [NSMutableArray new];
                for (NSString *oneKey in (NSArray*)mappedToKey) {
                    if (![oneKey isKindOfClass:[NSString class]]) {
                        continue;
                    }
                    if (oneKey.length == 0) {
                        continue;
                    }
                    NSArray *keyPath = [oneKey componentsSeparatedByString:@"."];
                    if (keyPath.count > 1) {
                        [mappedToKeyArray addObject:keyPath];
                    }else {
                        [mappedToKeyArray addObject:oneKey];
                    }
                    
                    if (!propertyMeta->_mappedToKey) {
                        propertyMeta->_mappedToKey = oneKey;
                        propertyMeta->_mappedToKeypath = keyPath.count > 1 ? keyPath : nil;
                    }
                }
                if (!propertyMeta->_mappedToKey) {
                    return;
                }
                propertyMeta->_mappedToKeyArray = mappedToKeyArray;
                [multiKeysPropertyMetas addObject:propertyMeta];
                
                propertyMeta->_next = mapper[mappedToKey] ?: nil;
                mapper[mappedToKey] = propertyMeta;
            }
        }];
    }
    
    [allPropertyMetas enumerateKeysAndObjectsUsingBlock:^(NSString *name, _NWModelPropertyMeta *propertyMeta, BOOL * _Nonnull stop) {
        propertyMeta->_mappedToKey = name;
        propertyMeta->_next = mapper[name] ?: nil;
        mapper[name] = propertyMeta;
        
    }];
    
    if (mapper.count) {
        _mapper = mapper;
    }
    if (keyPathPropertyMetas) {
        _keyPathPropertyMetas = keyPathPropertyMetas;
    }
    if (multiKeysPropertyMetas) {
        _multiKeysPropertyMetas = multiKeysPropertyMetas;
    }
    
    _classInfo = classInfo;
    _keyMappedCount = _allPropertyMetas.count;
    _nsType = NWClassGetNSType(cls);
    _hasCustomWillTransformFromDictionary = ([cls instanceMethodForSelector:@selector(nw_modelCustomWillTransformFromDictionary:)]);
    _hasCustomTransformFromDictionary = ([cls instanceMethodForSelector:@selector(nw_modelCustomTransformFromDictionary:)]);
    _hasCustomTransfromToDictionary = ([cls instanceMethodForSelector:@selector(nw_modelCustomTransformToDictionary:)]);
    _hasCustomClassFromDictionary = ([cls instanceMethodForSelector:@selector(nw_modelCustomClassForDictionary:)]);

    return self;
}

/// Returns the cached model class meta.
+ (instancetype)metaWithClass:(Class)cls {
    if (!cls) {
        return nil;
    }
    static CFMutableDictionaryRef cache;
    static dispatch_semaphore_t lock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        lock = dispatch_semaphore_create(1);
        
    });
    
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    _NWModelMeta *meta = CFDictionaryGetValue(cache, (__bridge const void *)(cls));
    dispatch_semaphore_signal(lock);
    if (!meta || meta->_classInfo.needUpdate) {
        meta = [[_NWModelMeta alloc] initWithClass:cls];
        if (meta) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            _NWModelMeta *meta = CFDictionaryGetValue(cache, (__bridge const void *)(cls));
            dispatch_semaphore_signal(lock);
        }
    }
    return meta;
}
@end

/**
 Get number from property
 @discussion Caller should hold strong reference to the parammeters before this function returns.
 @param model Should be not nil.
 @param meta Shoult be not nil.meta.iSCNumber should be YES.meta.getter should not be nil.
 @return A number object, or nil if failed.
 */
static force_inline NSNumber *ModelCreateNumberFromProperty(__unsafe_unretained id model,
                                                            __unsafe_unretained _NWModelPropertyMeta *meta) {
    switch (meta->_type & NWEncodeTypeMask) {
        case NWEncodeTypeBool:{
            return @(((bool (*)(id, SEL))(void *) objc_msgSend)((id)model, meta->_getter));
        }
        case NWEncodeTypeInt8:{
            return @(((int8_t (*)(id, SEL))(void *) objc_msgSend)((id)model, meta->_getter));
        }
        case NWEncodeTypeUInt8:{
            return @(((uint8_t (*)(id, SEL))(void *) objc_msgSend)((id)model, meta->_getter));
        }
        case NWEncodeTypeInt16:{
            return @(((int16_t (*)(id, SEL))(void *) objc_msgSend)((id)model, meta->_getter));
        }
        case NWEncodeTypeUInt16:{
            return @(((uint16_t (*)(id, SEL))(void *) objc_msgSend)((id)model, meta->_getter));
        }
        case NWEncodeTypeInt32:{
            return @(((int32_t (*)(id, SEL))(void *) objc_msgSend)((id)model, meta->_getter));
        }
        case NWEncodeTypeUInt32:{
            return @(((uint32_t (*)(id, SEL))(void *) objc_msgSend)((id)model, meta->_getter));
        }
        case NWEncodeTypeInt64:{
            return @(((int32_t (*)(id, SEL))(void *) objc_msgSend)((id)model, meta->_getter));
        }
        case NWEncodeTypeUInt64:{
            return @(((uint32_t (*)(id, SEL))(void *) objc_msgSend)((id)model, meta->_getter));
        }
        case NWEncodeTypeFloat:{
            float num = ((float (*)(id, SEL))(void *) objc_msgSend)((id)model, meta->_getter);
            if (isnan(num) || isinf(num)) {
                return nil;
            }
            return @(num);
        }
        case NWEncodeTypeDoubel:{
            double num = ((double (*)(id, SEL))(void *) objc_msgSend)((id)model, meta->_getter);
            if (isnan(num) || isinf(num)) {
                return nil;
            }
            return @(num);
        }
        case NWEncodeTypeLongDoubel:{
            double num = ((long double (*)(id, SEL))(void *) objc_msgSend)((id)model, meta->_getter);
            if (isnan(num) || isinf(num)) {
                return nil;
            }
            return @(num);
        }
        default: return nil;
    }
}

/**
 Set number to property
 @discussion Caller should hold strong reference to the parameters before this function returns.
 @param model Should be not nil.
 @param num Should not be nil.
 @param meta Should not be nil, meta.iSCNumber should be YES, meta.setter shoule be not nil.
 
 */
static force_inline void ModelSetNumberToProperty(__unsafe_unretained id model,
                                                  __unsafe_unretained NSNumber *num,
                                                  __unsafe_unretained _NWModelPropertyMeta *meta) {
    
    switch (meta->_type & NWEncodeTypeMask) {
        case NWEncodeTypeBool:{
            ((void (*)(id, SEL, bool))(void *) objc_msgSend)((id)model, meta->_setter, num.boolValue);
        }break;
        case NWEncodeTypeInt8:{
            ((void (*)(id, SEL, int8_t))(void *) objc_msgSend)((id)model, meta->_setter, (int8_t)num.charValue);
        }break;
        case NWEncodeTypeUInt8:{
            ((void (*)(id, SEL, uint8_t))(void *) objc_msgSend)((id)model, meta->_setter, (uint8_t)num.charValue);
        }break;
        case NWEncodeTypeInt16:{
            ((void (*)(id, SEL, int16_t))(void *) objc_msgSend)((id)model, meta->_setter, (int16_t)num.charValue);
        }break;
        case NWEncodeTypeUInt16:{
            ((void (*)(id, SEL, uint16_t))(void *) objc_msgSend)((id)model, meta->_setter, (uint16_t)num.charValue);
        }break;
        case NWEncodeTypeInt32:{
            ((void (*)(id, SEL, int32_t))(void *) objc_msgSend)((id)model, meta->_setter, (int32_t)num.charValue);
        }break;
        case NWEncodeTypeUInt32:{
            ((void (*)(id, SEL, uint32_t))(void *) objc_msgSend)((id)model, meta->_setter, (uint32_t)num.charValue);
        }break;
        case NWEncodeTypeInt64:{
            if ([num isKindOfClass:[NSDecimalNumber class]]) {
                ((void (*)(id, SEL, int64_t))(void *) objc_msgSend)((id)model, meta->_setter, (int64_t)num.stringValue.longLongValue);
            } else {
                ((void (*)(id, SEL, uint64_t))(void *) objc_msgSend)((id)model, meta->_setter, (uint64_t)num.longLongValue);
            }
        }break;
        case NWEncodeTypeUInt64:{
            if ([num isKindOfClass:[NSDecimalNumber class]]) {
                ((void (*)(id, SEL, int64_t))(void *) objc_msgSend)((id)model, meta->_setter, (int64_t)num.stringValue.longLongValue);
            } else {
                ((void (*)(id, SEL, uint64_t))(void *) objc_msgSend)((id)model, meta->_setter, (uint64_t)num.unsignedLongLongValue);
            }
        }break;
        case NWEncodeTypeFloat:{
            float f = num.floatValue;
            if (isnan(f) || isinf(f)) {
                f = 0;
            }
            ((void (*)(id, SEL, float))(void *) objc_msgSend)((id)model, meta->_setter, f);
        }break;
        case NWEncodeTypeDoubel:{
            double d = num.doubleValue;
            if (isnan(d) || isinf(d)) {
                d = 0;
            }
            ((void (*)(id, SEL, double))(void *) objc_msgSend)((id)model, meta->_setter, d);
        }break;
        case NWEncodeTypeLongDoubel:{
            long double d = num.doubleValue;
            if (isnan(d) || isinf(d)) {
                d = 0;
            }
            
            ((void (*)(id, SEL, long double))(void *) objc_msgSend)((id)model, meta->_setter, (long double)d);
        }
        default:break;
    }
}

/**
 Set value to model with a property meta.
 
 @discussion Caller should hold strong reference to the parameters this function returns.
 
 @param model Should not be nil.
 @param value Should not be nil, but can be NSNull.
 @param meta Should not be nil, and meta->_setter should not be nil.
 
 */
static void ModelSetValueForProperty(__unsafe_unretained id model,
                                     __unsafe_unretained id value,
                                     __unsafe_unretained _NWModelPropertyMeta *meta) {
    
    if (meta->_isCNumber) {
        NSNumber *num = NWNSNumberCreateFromID(value);
        ModelSetNumberToProperty(model, num, meta);
        if (num != nil) {
            [num class];// hold the number
        }
    }else if(meta->_nsType){
        if (value == (id)kCFNull) {
            ((void (*)(id, SEL, id))(void *) objc_msgSend)(model, meta->_setter,(id)nil);
        }else {
            switch (meta->_nsType) {
                case NWEncodingNSTypeNSString:
                case NWEncodingNSTypeNSMutableString:{
                    if ([value isKindOfClass:[NSString class]]) {
                        if (meta->_nsType == NWEncodingNSTypeNSString) {
                            ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter, value);
                        }else {
                            ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, ((NSString *)value).mutableCopy);
                        }
                    }else if([value isKindOfClass:[NSNumber class]]){
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter,meta->_nsType == NWEncodingNSTypeNSString ? ((NSNumber *)value).stringValue : ((NSNumber *)value).stringValue.mutableCopy);
                    }else if([value isKindOfClass:[NSData class]]){
                        
                        NSMutableString *string = [[NSMutableString alloc] initWithData:value encoding:NSUTF8StringEncoding];
                        ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, string);
                    }else if([value isKindOfClass:[NSURL class]]){
                        
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter, meta->_nsType == NWEncodingNSTypeNSURL ? ((NSURL *)value).absoluteString : ((NSURL *)value).absoluteString.mutableCopy);
                    }else if([value isKindOfClass:[NSAttributedString class]]){
                        ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, meta->_nsType == NWEncodingNSTypeNSString ? ((NSAttributedString *)value).string : ((NSAttributedString *)value).string.mutableCopy);
                    }
                }break;
                case NWEncodingNSTypeNSValue:
                case NWEncodingNSTypeNSNumber:
                case NWEncodingNSTypeNSDecimalNumber:{
                    if ([value isKindOfClass:[NSDecimalNumber class]]) {
                        ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, value);
                    }else if([value isKindOfClass:[NSNumber class]]){
                        NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithDecimal:[((NSNumber *)value) decimalValue]];
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter,decNum);
                    }else if([value isKindOfClass:[NSString class]]){
                        NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithString:value];
                        NSDecimal dec = decNum.decimalValue;
                        if (dec._length == 0 && dec._isNegative) {
                            decNum = nil;// NaN
                        }
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter,decNum);

                    }else {// NWEncodingTypeNSValue
                        if ([value isKindOfClass:[NSValue class]]) {
                            ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, value);
                        }
                    }
                }break;
                case NWEncodingNSTypeNSData:
                case NWEncodingNSTypeNSMutableData:{
                    if ([value isKindOfClass:[NSData class]]) {
                        if (meta->_nsType == NWEncodingNSTypeNSData) {
                            ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter, value);
                        }else {
                            NSMutableData *multableData = ((NSData  *)value).mutableCopy;
                            ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter, multableData);
                        }
                    }else if([value isKindOfClass:[NSString class]]){
                        NSData *data = [(NSString *)value dataUsingEncoding:NSUTF8StringEncoding];
                        if (meta->_nsType == NWEncodingNSTypeNSMutableData) {
                            data = (NSData *)data.mutableCopy;
                        }
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter, data);
                    }
                }break;
                case NWEncodingNSTypeNSDate:{
                    if ([value isKindOfClass:[NSDate class]]) {
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter, value);
                    }else if([value isKindOfClass:[NSString class]]){
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter, NWNSDateFromString(value));
                    }
                }break;
                case NWEncodingNSTypeNSURL:{
                    if ([value isKindOfClass:[NSURL class]]) {
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter, value);
                    }else if([value isKindOfClass:[NSString class]]){
                        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
                        NSString *str = [value stringByTrimmingCharactersInSet:set];
                        if (str.length == 0) {
                            ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter, nil);
                        }else {
                            ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)model, meta->_setter, [[NSURL alloc] initWithString:str]);

                        }
                    }
                }break;
                case NWEncodingNSTypeNSArray:
                case NWEncodingNSTypeNSMutableArray:{
                    if (meta->_genericCls) {
                        NSArray *valueArr = nil;
                        if ([value isKindOfClass:[NSArray class]]) {
                            valueArr = value;
                        }else if([value isKindOfClass:[NSSet class]]){
                            valueArr = ((NSSet *)value).allObjects;
                        }
                        if (valueArr) {
                            NSMutableArray *objectArr = [NSMutableArray new];
                            for (id one in valueArr) {
                                if ([one isKindOfClass:meta->_genericCls]) {
                                    [objectArr addObject:one];
                                }else if([one isKindOfClass:[NSDictionary class]]){
                                    Class cls = meta->_genericCls;
                                    if (meta->_hasCustomClassFromDictionary) {
                                        cls = [cls nw_modelCustomClassForDictionary:one];
                                        if (!cls) cls = meta->_genericCls;
                                    }
                                    NSObject *newOne = [cls new];
                                    [newOne nw_modelSetWithDictionary:one];
                                    if (newOne) [objectArr addObject:newOne];
                                }
                            }
                            ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, objectArr);
                        }
                    }else {
                        if ([value isKindOfClass:[NSArray class]]) {
                            if (meta->_nsType == NWEncodingNSTypeNSArray) {
                                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, value);

                            }else {
                                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, ((NSArray *)value).mutableCopy);

                            }
                        }else if([value isKindOfClass:[NSSet class]]){
                            if (meta->_nsType == NWEncodingNSTypeNSSet) {
                                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, ((NSSet *)value).allObjects);

                            }else {
                                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, ((NSSet *)value).allObjects.mutableCopy);
                            }
                        }
                    }
                }break;
                case NWEncodingNSTypeNSDictionary:
                case NWEncodingNSTypeNSMutableDictionary:{
                    if ([value isKindOfClass:[NSDictionary class]]) {
                        if (meta->_genericCls) {
                            NSMutableDictionary *dic = [NSMutableDictionary new];
                            [(NSDictionary *)value enumerateKeysAndObjectsUsingBlock:^(NSString *  oneKey, id oneValue, BOOL * _Nonnull stop) {
                                if ([oneValue isKindOfClass:[NSDictionary class]]) {
                                    Class cls = meta->_genericCls;
                                    if (meta->_hasCustomClassFromDictionary) {
                                        cls = [cls nw_modelCustomClassForDictionary:oneValue];
                                        if (!cls) cls = meta->_genericCls; // for xcode code coverage
                                    }
                                    NSObject *newOne = [cls new];
                                    [newOne nw_modelSetWithDictionary:(id)oneValue];
                                    if (newOne) dic[oneKey] = newOne;
                                }
                                
                            }];
                            ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, dic);

                            
                        }else {
                            if (meta->_nsType == NWEncodingNSTypeNSDictionary) {
                                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, value);

                            }else {
                                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, ((NSDictionary *)value).mutableCopy);
                            }
                        }
                    }
                }break;
                case NWEncodingNSTypeNSSet:
                case NWEncodingNSTypeNSMutableSet:{
                    NSSet *valueSet = nil;
                    if ([value isKindOfClass:[NSSet class]]) valueSet = [NSMutableSet setWithArray:value];
                    else if([value isKindOfClass:[NSSet class]]) valueSet = (NSSet *)value;
                    if (meta->_genericCls) {
                        NSMutableSet *set = [NSMutableSet new];
                        for (id one in valueSet) {
                            if ([one isKindOfClass:meta->_genericCls]) {
                                [set addObject:one];
                            }else if([one isKindOfClass:[NSDictionary class]]){
                                Class cls = meta->_genericCls;
                                if (meta->_hasCustomClassFromDictionary) {
                                    cls = [cls nw_modelCustomClassForDictionary:one];
                                    if (!cls)  cls = meta->_genericCls;
                                }
                                NSObject *newOne = [cls new];
                                [newOne nw_modelSetWithDictionary:one];
                                if (newOne) [set addObject:newOne];
                            }
                        }
                        ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, set);

                    } else {
                        if (meta->_nsType == NWEncodingNSTypeNSSet) {
                            ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, valueSet);
                        }else {
                            ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, ((NSSet *)valueSet).mutableCopy);
                        }
                    }
                }// break; commented for code coverage in next line
                    
                default: break;
            }
        }
    } else {
        BOOL isNull = (value == (id)kCFNull);
        switch (meta->_type & NWEncodeTypeMask) {
            case NWEncodeTypeObject:{
                Class cls = meta->_genericCls ?: meta->_cls;
                if (isNull) {
                    ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, nil);
                } else if ([value isKindOfClass:cls] || !cls) {
                    ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, (id)value);

                } else if ([value isKindOfClass:[NSDictionary class]]) {
                    NSObject *one = nil;
                    if (meta->_getter) {
                        one = ((id (*)(id, SEL))(void *) objc_msgSend)((id)model, meta->_getter);
                    }
                    if (one) {
                        [one nw_modelSetWithDictionary:value];
                    }else {
                        if (meta->_hasCustomClassFromDictionary) {
                            cls = [cls nw_modelCustomClassForDictionary:value] ?: cls;
                        }
                        one = [cls new];
                        [one nw_modelSetWithDictionary:value];
                        ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, (id)one);
                    }
                }
            }break;
            case NWEncodeTypeClass:{
                if (isNull) {
                    ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, (Class)NULL);
                }else {
                    Class cls = nil;
                    if ([value isKindOfClass:[NSString class]]) {
                        cls = NSClassFromString(value);
                        if (cls) {
                            ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, (Class)cls);

                        }
                    }else {
                        cls = object_getClass(value);
                        if (cls) {
                            if (class_isMetaClass(cls)) {
                                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, (Class)value);
                            }
                        }
                    }
                }
            }break;
            case NWEncodeTypeSEL:{
                if (isNull) {
                    ((void (*)(id, SEL, SEL))(void *) objc_msgSend)((id)model, meta->_setter, (SEL)NULL);
                } else if ([value isKindOfClass:[NSString class]]) {
                    SEL sel = NSSelectorFromString(value);
                    if (sel) {
                        ((void (*)(id, SEL, SEL))(void *) objc_msgSend)((id)model, meta->_setter, (SEL)sel);
                    }
                }
            }break;
            case NWEncodeTypeBlock:{
                if (isNull) {
                    ((void (*)(id, SEL, void(^)(void)))(void *) objc_msgSend)((id)model, meta->_setter, NULL);
                } else if ([value isKindOfClass:NWNSBlockClass()]) {
                    ((void (*)(id ,SEL, void(^)(void)))(void *) objc_msgSend)((id)model, meta->_setter, (void(^)(void))value);
                }
            }break;
            case NWEncodeTypeStruct:
            case NWEncodeTypeUnion:
            case NWEncodeTypeCArray:{
                if ([value isKindOfClass:[NSValue class]]) {
                    const char *valueType = ((NSValue *)value).objCType;
                    const char *metaType = meta->_info.typeEncoding.UTF8String;
                    if (valueType && metaType && strcmp(valueType, metaType) == 0) {
                        [model setValue:value forKey:meta->_name];
                    }
                }
            }break;
            case NWEncodeTypePointer:
            case NWEncodeTypeCString:{
                if (isNull) {
                    ((void (*)(id, SEL, void *))(void *) objc_msgSend)((id)model, meta->_setter, (void *)NULL);
                }else if ([value isKindOfClass:[NSValue class]]) {
                    NSValue *nsValue = value;
                    if (nsValue.objCType && strcmp(nsValue.objCType, "^v") == 0) {
                        ((void (*)(id, SEL, void *))(void *) objc_msgSend)((id)model, meta->_setter, nsValue.pointerValue);

                    }
                }
            } // break;
            default:
                break;
        }
    }
}


typedef struct {
    void *modelMeta;    /// < _NWModelMeta
    void *model;        /// <  if (self)
    void *dictionary;   /// <  NSDictionary (json)
} ModelSetContext;

/**
 Apply function for dictionary, to set the key-value pair to model.
 
 @param _key should not be nil, NSString.
 @param _value Shouled not be nil.
 @param _context _context.modelMeta and _context.model should not be nil.
 
 */
static void ModelSetWithDictionaryFunction(const void *_key, const void *_value, void *_context) {
    
    ModelSetContext *context = _context;
    __unsafe_unretained _NWModelMeta *meta = (__bridge _NWModelMeta *)(context->modelMeta);
    __unsafe_unretained _NWModelPropertyMeta *propertyMeta = [meta->_mapper objectForKey:(__bridge id _Nonnull)(_key)];
    __unsafe_unretained id model = (__bridge id)(context->model);
    while (propertyMeta) {
        if (propertyMeta->_setter) {
            ModelSetValueForProperty(model, (__bridge id)(_value), propertyMeta);
        }
        propertyMeta = propertyMeta->_next;
    }
}

/**
 Apply function for model property meta, to set dictionary to model.
 
 
 */
static void ModelSetWithPropertyMetaArrayFunction(const void *_propertyMeta, void *_context) {
    
    ModelSetContext *context = _context;
    __unsafe_unretained NSDictionary *dic = (__bridge NSDictionary *)(context->dictionary);
    __unsafe_unretained _NWModelPropertyMeta *propertyMeta = (__bridge _NWModelPropertyMeta *)(_propertyMeta);
    if (!propertyMeta) return;
    id value = nil;
    if (propertyMeta->_mappedToKeyArray) {
        value = NWValueForMultiKeys(dic, propertyMeta->_mappedToKeyArray);
    } else if (propertyMeta->_mappedToKeypath) {
        value = NWValueForKeyPath(dic, propertyMeta->_mappedToKeypath);
    } else {
        value = [dic objectForKey:propertyMeta->_mappedToKey];
    }
    
    if (value) {
        __unsafe_unretained id model = (__bridge id)(context->model);
        ModelSetValueForProperty(model, value, propertyMeta);
    }
}

/**
 Returns a valid JSON object (NSArray,NSDictionary,NSString,NSNumber/NSNull),
 or nil if an error occurs
 
 */
static id ModelToJSONObjectRecursive(NSObject *model) {
    if (!model || model == (id)kCFNull) return model;
    if ([model isKindOfClass:[NSString class]]) return model;
    if ([model isKindOfClass:[NSNumber class]]) return model;
    if ([model isKindOfClass:[NSDictionary class]]) {
        if ([NSJSONSerialization isValidJSONObject:model]) return model;
        NSMutableDictionary *newDic = [NSMutableDictionary new];
        [((NSDictionary *)model) enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL * _Nonnull stop) {
            NSString *stringKey = [key isKindOfClass:[NSString class]] ? key : key.description;
            if (!stringKey) return;
            id jsonObj = ModelToJSONObjectRecursive(obj);
            if (!jsonObj) jsonObj = (id)kCFNull;
            newDic[stringKey] = jsonObj;
            
        }];
        return newDic;
    }
    if ([model isKindOfClass:[NSSet class]]) {
        NSArray *array = ((NSSet *)model).allObjects;
        if ([NSJSONSerialization isValidJSONObject:model]) return model;
        NSMutableArray *newArray = [NSMutableArray new];
        for (id obj in array) {
            if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]]) {
                [newArray addObject:obj];
            } else {
                id jsonObj = ModelToJSONObjectRecursive(obj);
                if (jsonObj && jsonObj != (id)kCFNull) {
                    [newArray addObject:jsonObj];
                }
            }
        }
        return newArray;
    }
    
    if ([model isKindOfClass:[NSArray class]]) {
        if ([NSJSONSerialization isValidJSONObject:model]) return model;
        NSMutableArray *newArray = [NSMutableArray new];
        for (id obj in (NSArray *)model) {
            if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]]) {
                [newArray addObject:obj];
            } else {
                id jsonObj = ModelToJSONObjectRecursive(obj);
                if (jsonObj && jsonObj != (id)kCFNull) {
                    [newArray addObject:jsonObj];
                }
            }
        }
    }
    if ([model isKindOfClass:[NSURL class]]) return ((NSURL *)model).absoluteString;
    if ([model isKindOfClass:[NSAttributedString class]]) return ((NSAttributedString *)model).string;
    if ([model isKindOfClass:[NSDate class]]) return [NWISODateFormatter() stringFromDate:(id)model];
    if ([model isKindOfClass:[NSData class]]) return nil;
    
    _NWModelMeta *modelMeta = [_NWModelMeta metaWithClass:[model class]];
    if (!modelMeta || modelMeta->_keyMappedCount == 0) return nil;
    NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:64];
    __unsafe_unretained NSMutableDictionary *dic = result;// avoid retain and release in block
    [modelMeta->_mapper enumerateKeysAndObjectsUsingBlock:^(NSString *propertyMappedKey, _NWModelPropertyMeta *propertyMeta, BOOL * _Nonnull stop) {
        if (!propertyMeta->_getter) return;
        id value = nil;
        if (propertyMeta->_isCNumber) {
            value = ModelCreateNumberFromProperty(model, propertyMeta);
        } else if (propertyMeta->_nsType) {
            id v = ((id (*)(id, SEL))(void *)objc_msgSend)((id)model, propertyMeta->_getter);
            value = ModelToJSONObjectRecursive(v);
        } else {
            switch (propertyMeta->_type & NWEncodeTypeMask) {
                case NWEncodeTypeObject:{
                    id v = ((id (*)(id, SEL))(void *)objc_msgSend)((id)model, propertyMeta->_getter);
                    value = ModelToJSONObjectRecursive(v);
                    if (value == (id)kCFNull) value = nil;
                }break;
                case NWEncodeTypeClass:{
                    Class v = ((Class (*)(id, SEL))(void *)objc_msgSend)((id)model, propertyMeta->_getter);
                    value = v ? NSStringFromClass(v) : nil;
                }break;
                case NWEncodeTypeSEL:{
                    SEL v = ((SEL (*)(id, SEL))(void *)objc_msgSend)((id)model, propertyMeta->_getter);
                    value = v ? NSStringFromSelector(v) : nil;
                }break;
                default: break;
            }
        }
        if (!value) return;
        
        if (propertyMeta->_mappedToKeypath) {
            NSMutableDictionary *superDic = dic;
            NSMutableDictionary *subDic = nil;
            for (NSUInteger i = 0, max = propertyMeta->_mappedToKeypath.count;i < max ; i++) {
                NSString *key = propertyMeta->_mappedToKeypath[i];
                if (i + 1 == max) {// end
                    if (!subDic[key]) superDic[key] = value;
                    break;
                }
                subDic = superDic[key];
                if (subDic) {
                    if ([subDic isKindOfClass:[NSDictionary class]]) {
                        subDic = subDic.mutableCopy;
                        superDic[key] = subDic;
                    } else {
                        break;
                    }
                } else {
                    subDic = [NSMutableDictionary new];
                    superDic[key] = subDic;
                }
                superDic = subDic;
                subDic = nil;
            }
        } else {
            if (!dic[propertyMeta->_mappedToKey]) {
                dic[propertyMeta->_mappedToKey] = value;
            }
        }
        
    }];
    
    if (modelMeta->_hasCustomTransfromToDictionary) {
        BOOL suc = [(id<NWModel>)model nw_modelCustomTransformToDictionary:dic];
        if (!suc) return nil;
    }
    return result;
}

/// Add indent to string (exclude first line)
static NSMutableString *ModelDescriptionAddIndent(NSMutableString *desc, NSUInteger indent) {
    
    for (NSUInteger i = 0, max = desc.length; i < max;i++) {
        unichar c = [desc characterAtIndex:i];
        if (c == '\n') {
            for (NSUInteger j = 0; j < indent; j++) {
                [desc insertString:@"    " atIndex:i+1];
            }
            i += indent * 4;
            max += indent * 4;
        }
    }
    return desc;
}

/// Generate a description string.
static NSString *ModelDescription(NSObject *model) {
    static const int kDescMaxLength = 100;
    if (!model) return @"<nil>";
    if (model == (id)kCFNull) return @"<null>";
    if (![model isKindOfClass:[NSObject class]]) return [NSString stringWithFormat:@"%@",model];
    
    
    _NWModelMeta *modelMeta = [_NWModelMeta metaWithClass:model.class];
    switch (modelMeta->_nsType) {
        case NWEncodingNSTypeNSString:
        case NWEncodingNSTypeNSMutableString:{
            return [NSString stringWithFormat:@"\"%@\"",model];
        }
        case NWEncodingNSTypeNSValue:
        case NWEncodingNSTypeNSData:
        case NWEncodingNSTypeNSMutableData:{
            NSString *tmp = model.description;
            if (tmp.length > kDescMaxLength) {
                tmp = [tmp substringToIndex:kDescMaxLength];
                tmp = [tmp stringByAppendingString:@"..."];
                
            }
            return tmp;
        }
        case NWEncodingNSTypeNSNumber:
        case NWEncodingNSTypeNSDecimalNumber:
        case NWEncodingNSTypeNSDate:
        case NWEncodingNSTypeNSURL:{
            return [NSString stringWithFormat:@"%@",model];
        }

        case NWEncodingNSTypeNSSet:
        case NWEncodingNSTypeNSMutableSet:{
            model = ((NSSet *)model).allObjects;
        }// no break
        case NWEncodingNSTypeNSArray:
        case NWEncodingNSTypeNSMutableArray:{
            NSArray *array = (id)model;
            NSMutableString *desc = [NSMutableString new];
            if (array.count == 0) {
                return [desc stringByAppendingString:@"[]"];
            } else {
                [desc appendFormat:@"[\n"];
                for (NSUInteger i = 0, max = array.count; i < max; i++) {
                    NSObject *obj = array[i];
                    [desc appendString:@"    "];
                    [desc appendString:ModelDescriptionAddIndent(ModelDescription(obj).mutableCopy, 1)];
                    
                }
                [desc appendString:@"]"];
                return desc;
            }
        }
            
        case NWEncodingNSTypeNSDictionary:
        case NWEncodingNSTypeNSMutableDictionary:{
            NSDictionary *dic = (id)model;
            NSMutableString *desc = [NSMutableString new];
            if (dic.count == 0) {
                return [desc stringByAppendingString:@"{}"];
            } else {
                NSArray *keys = dic.allKeys;
                [desc appendFormat:@"{\n"];
                for (NSUInteger i = 0, max = keys.count; i < max; i++) {
                    NSString *key = keys[i];
                    NSObject *value = dic[key];
                    [desc appendString:@"    "];
                    [desc appendFormat:@"%@ = %@",key,ModelDescriptionAddIndent(ModelDescription(value).mutableCopy, 1)];
                    [desc appendString:(i + 1 == max) ? @"\n" : @";\n" ];
                }
                [desc appendString:@"}"];
            }
        }

        default:{
            NSMutableString *desc = [NSMutableString new];
            [desc appendFormat:@"<%@: %p>",model.class, model];
            if (modelMeta->_allPropertyMetas.count == 0) return desc;
            
            // sort property names
            NSArray *properties = [modelMeta->_allPropertyMetas sortedArrayUsingComparator:^NSComparisonResult(_NWModelPropertyMeta *p1, _NWModelPropertyMeta *p2) {
                return [p1->_name compare:p2->_name];
            }];
            [desc appendFormat:@" {\n"];
            for (NSUInteger i = 0, max = properties.count; i < max; i++) {
                _NWModelPropertyMeta *property = properties[i];
                NSString *propertyDesc = nil;
                if (property->_isCNumber) {
                    NSNumber *num = ModelCreateNumberFromProperty(model, property);
                    propertyDesc = num.stringValue;
                } else {
                    switch (property->_type & NWEncodeTypeMask) {
                        case NWEncodeTypeObject:{
                            id v = ((id (*)(id, SEL))(void *)objc_msgSend)((id)model,property->_getter);
                            propertyDesc = ModelDescription(v);
                            if(!propertyDesc) propertyDesc = @"<nil>";
                            
                        }break;
                        case NWEncodeTypeClass:{
                            id v = ((id (*)(id, SEL))(void *) objc_msgSend) ((id)model,property->_getter);
                            propertyDesc = ((NSObject *)v).description;
                            if (!propertyDesc) propertyDesc = @"<nil>";
                            
                        }break;
                        case NWEncodeTypeSEL:{
                            SEL sel = ((SEL (*)(id, SEL))(void *) objc_msgSend)((id)model, property->_getter);
                            if (sel) propertyDesc = NSStringFromSelector(sel);
                            else propertyDesc = @"<NULL>";
                        }break;
                        case NWEncodeTypeBlock:{
                            id block = ((id (*)(id ,SEL))(void *) objc_msgSend)((id)model, property->_getter);
                            propertyDesc = block ? ((NSObject *)block).description : @"<nil>";
                        }break;
                        case NWEncodeTypeCString:
                        case NWEncodeTypePointer:
                        case NWEncodeTypeCArray:{
                            void *pointer = ((void* (*)(id, SEL))(void *) objc_msgSend)((id)model, property->_getter);
                            propertyDesc = [NSString stringWithFormat:@"%p",pointer];
                        }break;
                        case NWEncodeTypeUnion:
                        case NWEncodeTypeStruct:{
                            NSValue *value = [model valueForKey:property->_name];
                            propertyDesc = value ? value.description : @"{unknown}";
                        }break;
                        default: propertyDesc = @"<unknown>";
                    }
                }
                propertyDesc = ModelDescriptionAddIndent(propertyDesc.mutableCopy, 1);
                [desc appendFormat:@"    %@ = %@",property->_name,propertyDesc];
                [desc appendString:(i + 1) == max ? @"\n" : @";\n"];
            }
            [desc appendFormat:@"}"];
            return desc;
        }
    }
}


@implementation NSObject (NWModel)

/// id to dict or nil
+ (NSDictionary *)__nw_dictionaryWithJSON:(id)json {
    
    if (!json || json == (id)kCFNull) {
        return nil;
    }
    
    NSDictionary *dict = nil;
    NSData *jsonData = nil;
    
    if ([json isKindOfClass:[NSDictionary class]]) {
        dict = json;
    }else if([json isKindOfClass:[NSString class]]){
        jsonData = [(NSString *)json dataUsingEncoding:NSUTF8StringEncoding];
    }else if([json isKindOfClass:[NSData class]]){
        jsonData = json;
    }
    
    if (jsonData) {
        dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:NULL];
    }
    
    if (![dict isKindOfClass:[NSDictionary class]]) {
        dict = nil;
    }
    return dict;
}

+ (instancetype)nw_modelWithJSON:(id)json {
    NSDictionary *dic = [self __nw_dictionaryWithJSON:json];
    return [self nw_modelWithDictionary:dic];
}

+ (instancetype)nw_modelWithDictionary:(NSDictionary *)dictionary {
    // value judge
    if (!dictionary || dictionary == (id)kCFNull) return nil;
    // type judge
    if (![dictionary isKindOfClass:[NSDictionary class]]) return nil;
    Class cls = [self class];
    _NWModelMeta *modelMeta = [_NWModelMeta metaWithClass:cls];
    if (modelMeta->_hasCustomClassFromDictionary) {
        cls = [cls nw_modelCustomClassForDictionary:dictionary] ?: cls;
    }
    NSObject *one = [cls new];
    if ([one nw_modelSetWithDictionary:dictionary]) return one;
    return nil;
}

- (BOOL)nw_modelSetWithJSON:(id)json {
    NSDictionary *dic = [NSObject __nw_dictionaryWithJSON:json];
    return [self nw_modelSetWithDictionary:dic];
}

- (BOOL)nw_modelSetWithDictionary:(NSDictionary *)dictionary {
    // value
    if (!dictionary || dictionary == (id)kCFNull) return NO;
    // type
    if (![dictionary isKindOfClass:[NSDictionary class]]) return NO;
    
    _NWModelMeta *modelMeta = [_NWModelMeta metaWithClass:object_getClass(self)];
    if (modelMeta->_keyMappedCount == 0) return NO;
    if (modelMeta->_hasCustomTransformFromDictionary) {
        dictionary = [((id<NWModel>)self) nw_modelCustomWillTransformFromDictionary:dictionary];
        if (![dictionary isKindOfClass:[NSDictionary class]]) return NO;
    }
    ModelSetContext context = {0};
    context.modelMeta = (__bridge void *)modelMeta;
    context.model = (__bridge void *)self;
    context.dictionary = (__bridge void *)dictionary;
    if (modelMeta->_keyMappedCount >= CFDictionaryGetCount((CFDictionaryRef)dictionary)) {
        CFDictionaryApplyFunction((CFDictionaryRef)dictionary,
                                  ModelSetWithDictionaryFunction,
                                  &context);
        if (modelMeta->_keyPathPropertyMetas) {
            CFArrayApplyFunction((CFArrayRef)modelMeta->_keyPathPropertyMetas,
                                 CFRangeMake(0, CFArrayGetCount((CFArrayRef)modelMeta->_keyPathPropertyMetas)),
                                 ModelSetWithPropertyMetaArrayFunction,
                                 &context);
        }
        if (modelMeta->_multiKeysPropertyMetas) {
            CFArrayApplyFunction((CFArrayRef)modelMeta->_multiKeysPropertyMetas,
                                 CFRangeMake(0,CFArrayGetCount((CFArrayRef)modelMeta->_multiKeysPropertyMetas)),
                                 ModelSetWithPropertyMetaArrayFunction,
                                 &context);
        }
    } else {
        CFArrayApplyFunction((CFArrayRef)modelMeta->_allPropertyMetas,
                             CFRangeMake(0, modelMeta->_keyMappedCount),
                             ModelSetWithPropertyMetaArrayFunction,
                             &context);
    }
    
    if (modelMeta->_hasCustomWillTransformFromDictionary) {
        return [((id<NWModel>)self) nw_modelCustomTransformFromDictionary:dictionary];
    }
    return YES;
}

- (id)nw_modelToJSONOBject {
    /*
     Apple said:
     The top level object is NSArray or NSDictionary.
     All objects are instances of NSString, NSNumber, NSArray, NSDictionary, or NSNull.
     All dictionary keys are instances of NSString.
     Numbers are not NaN(非法) or infinity(无穷大).
     */
    id jsonObject = ModelToJSONObjectRecursive(self);
    if ([jsonObject isKindOfClass:[NSArray class]]) return jsonObject;
    if ([jsonObject isKindOfClass:[NSDictionary class]]) return jsonObject;
    return nil;
}

- (NSData *)nw_modelToJSONData {
    id jsonObject = [self nw_modelToJSONOBject];
    if (!jsonObject) return nil;
    return [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:NULL];
}

- (NSString *)nw_modelToJSONString {
    id jsonObject = [self nw_modelToJSONData];
    if (!jsonObject) return nil;
    return [[NSString alloc] initWithData:jsonObject encoding:NSUTF8StringEncoding];
}

- (id)nw_modelCopy {
    if (self == (id)kCFNull) return self;
    _NWModelMeta *modelMeta = [_NWModelMeta metaWithClass:self.class];
    if (modelMeta->_nsType) return [self copy];
    NSObject *one = [self.class new];
    for (_NWModelPropertyMeta *propertyMeta in modelMeta->_allPropertyMetas) {
        if (!propertyMeta->_getter || !propertyMeta->_setter) continue;
        if (propertyMeta->_isCNumber) {
            switch (propertyMeta->_type & NWEncodeTypeMask) {
                case NWEncodeTypeBool:{
                    bool num = ((bool (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    ((void (*)(id, SEL, bool))(void *) objc_msgSend)((id)self, propertyMeta->_setter, num);
                }break;
                case NWEncodeTypeInt8:
                case NWEncodeTypeUInt8:{
                    uint8_t num = ((uint8_t (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    ((void (*)(id, SEL, uint8_t))(void *) objc_msgSend)((id)self, propertyMeta->_setter, num);
                }break;
                case NWEncodeTypeInt16:
                case NWEncodeTypeUInt16:{
                    uint16_t num = ((uint16_t (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    ((void (*)(id, SEL, uint16_t))(void *) objc_msgSend)((id)self, propertyMeta->_setter, num);
                }break;
                case NWEncodeTypeInt32:
                case NWEncodeTypeUInt32:{
                    uint32_t num = ((uint32_t (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    ((void (*)(id, SEL, uint32_t))(void *) objc_msgSend)((id)self, propertyMeta->_setter, num);
                }break;
                case NWEncodeTypeInt64:
                case NWEncodeTypeUInt64:{
                    uint64_t num = ((uint64_t (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    ((void (*)(id, SEL, uint64_t))(void *) objc_msgSend)((id)self, propertyMeta->_setter, num);
                }break;
                case NWEncodeTypeFloat:{
                    float num = ((float (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    ((void (*)(id, SEL, float))(void *) objc_msgSend)((id)self, propertyMeta->_setter, num);
                }break;
                case NWEncodeTypeDoubel:{
                    double num = ((double (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    ((void (*)(id, SEL, double))(void *) objc_msgSend)((id)self, propertyMeta->_setter, num);
                }break;
                case NWEncodeTypeLongDoubel:{
                  long double num = ((long double (*)(id, SEL))(void *) objc_msgSend)((id)self,propertyMeta->_getter);
                    ((void (*)(id, SEL, long double))(void *) objc_msgSend)((id)self, propertyMeta->_setter, num);
                }// break; commented for code coverage in next line
                default: break;
            }
        } else {
            switch (propertyMeta->_type & NWEncodeTypeMask) {
                case NWEncodeTypeBlock:
                case NWEncodeTypeClass:
                case NWEncodeTypeObject:{
                    id value = ((id (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)self, propertyMeta->_setter, value);
                }break;
                case NWEncodeTypeSEL:
                case NWEncodeTypePointer:
                case NWEncodeTypeCString:{
                    size_t value = ((size_t (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    ((void (*)(id, SEL, size_t))(void *) objc_msgSend)((id)self, propertyMeta->_setter, value);
                }break;
                case NWEncodeTypeStruct:
                case NWEncodeTypeUnion:{
                    @try {
                        NSValue *value = [self valueForKey:NSStringFromSelector(propertyMeta->_getter)];
                        if (value) {
                            [one setValue:value forKey:propertyMeta->_name];
                        }
                    } @catch (NSException *exception) {
                        NSLog(@"(exception)The func is and line is %s %d",__func__,__LINE__);
                    } @finally {
                        
                    }
                }
                default: break;
            }
        }
    }
    return one;
}

- (void)nw_modelEncodeWithCoder:(NSCoder *)aCoder {
    if (!aCoder) return;
    if (self == (id)kCFNull) {
        [((id<NSCoding>)self) encodeWithCoder:aCoder];
        return;
    }
    _NWModelMeta *modelMeta = [_NWModelMeta metaWithClass:self.class];
    if (modelMeta->_nsType) {
        [((id<NSCoding>)self) encodeWithCoder:aCoder];
        return;
    }
    for (_NWModelPropertyMeta *propertyMeta in modelMeta->_allPropertyMetas) {
        if (!propertyMeta->_getter) return;
        
        if (propertyMeta->_isCNumber) {
            NSNumber *value = ModelCreateNumberFromProperty(self, propertyMeta);
            if (value != nil) [aCoder encodeObject:value forKey:propertyMeta->_name];
        } else {
            switch (propertyMeta->_type & NWEncodeTypeMask) {
                case NWEncodeTypeObject:{
                    id value = ((id (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    if (value && (propertyMeta->_nsType || [value respondsToSelector:@selector(encodeWithCoder:)])) {
                        if ([value isKindOfClass:[NSValue class]]) {
                            if ([value isKindOfClass:[NSNumber class]]) {
                                [aCoder encodeObject:value forKey:propertyMeta->_name];
                            }
                        } else {
                            [aCoder encodeObject:value forKey:propertyMeta->_name];
                        }
                    }
                }break;
                case NWEncodeTypeSEL:{
                    SEL value = ((SEL (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    if (value) {
                        NSString *str = NSStringFromSelector(value);
                        [aCoder encodeObject:str forKey:propertyMeta->_name];
                    }
                }break;
                case NWEncodeTypeStruct:
                case NWEncodeTypeUnion:{
                    if (propertyMeta->_isKVCCompatibale && propertyMeta->_isStructAvailableForKeydArchiver) {
                        @try {
                            NSValue *value = [self valueForKey:NSStringFromSelector(propertyMeta->_getter)];
                            [aCoder encodeObject:value forKey:propertyMeta->_name];
                        } @catch (NSException *exception) {
                            NSLog(@"(exception)The func is and line is %s %d",__func__,__LINE__);
                        } @finally {
                            
                        }
                    }
                }break;
                default: break;
            }
        }
    }
}

- (id)nw_modelInitWithCoder:(NSCoder *)aDecoder {
    if (!aDecoder) return self;
    if (self == (id)kCFNull) return self;
    _NWModelMeta *modelMeta = [_NWModelMeta metaWithClass:self.class];
    if (modelMeta->_nsType) return self;
    for (_NWModelPropertyMeta *propertyMeta in modelMeta->_allPropertyMetas) {
        if (!propertyMeta->_setter) continue;
        if (propertyMeta->_isCNumber) {
            NSNumber *value = [aDecoder decodeObjectForKey:propertyMeta->_name];
            if ([value isKindOfClass:[NSNumber class]]) {
                ModelSetNumberToProperty(self, value, propertyMeta);
                [value class];// release value back thread
            }
        } else {
            NWEncodeType type = propertyMeta->_type & NWEncodeTypeMask;
            switch (type) {
                case NWEncodeTypeObject:{
                    id value = ((id (*)(id, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_getter);
                    ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)self, propertyMeta->_setter, (id)value);
                }break;
                case NWEncodeTypeSEL:{
                    NSString *str = [aDecoder decodeObjectForKey:propertyMeta->_name];
                    if ([str isKindOfClass:[NSString class]]) {
                        SEL sel = NSSelectorFromString(str);
                        ((void (*)(id, SEL, SEL))(void *) objc_msgSend)((id)self, propertyMeta->_setter, (SEL)sel);
                    }
                }break;
                case NWEncodeTypeStruct:
                case NWEncodeTypeUnion:{
                    if (propertyMeta->_isKVCCompatibale) {
                        @try {
                            NSValue *value = [aDecoder decodeObjectForKey:propertyMeta->_name];
                            if (value) [self setValue:value forKey:propertyMeta->_name];
                        } @catch (NSException *exception) {
                            NSLog(@"(exception)The func is and line is %s %d",__func__,__LINE__);
                        } @finally {
                            
                        }
                    }
                }break;
                    
                default:
                    break;
            }
        }
    }
    return self;
}

- (NSUInteger)nw_modelHash {
    if (self == (id)kCFNull) return [self hash];
    _NWModelMeta *modelMeta = [_NWModelMeta metaWithClass:self.class];
    if (modelMeta->_nsType) return [self hash];
    NSUInteger value = 0;
    NSUInteger count = 0;
    for (_NWModelPropertyMeta *propertyMeta in modelMeta->_allPropertyMetas) {
        if (!propertyMeta->_isKVCCompatibale) continue;
        // 从后者去除value ^= -> value = value ^ back
        value ^= [[self valueForKey:NSStringFromSelector(propertyMeta->_getter)] hash];
        count++;
    }
    if (count == 0) value = (long)(__bridge void *)self;
    return value;
}

- (BOOL)nw_modelIsEqual:(id)model {
    if (self == model) return YES;
    if (![model isMemberOfClass:self.class]) return NO;
    _NWModelMeta *modelMeta = [_NWModelMeta metaWithClass:self.class];
    if (modelMeta->_nsType) return [self isEqual:model];
    if ([self hash] != [model hash]) return NO;
    
    for (_NWModelPropertyMeta *propertyMeta in modelMeta->_allPropertyMetas) {
        if (!propertyMeta->_isKVCCompatibale) continue;;
        id this = [self valueForKey:NSStringFromSelector(propertyMeta->_getter)];
        id that = [model valueForKey:NSStringFromSelector(propertyMeta->_getter)];
        if (this == that) continue;
        if (this == nil || that == nil) return NO;
        if (![this isEqual:that]) return NO;
    }
    return YES;
}

- (NSString *)nw_modelDescription {
    return ModelDescription(self);
}

@end



@implementation NSArray (NWModel)

+ (NSArray *)nw_modelArrayWithClass:(Class)cls json:(id)json {
    if (!json) return nil;
    NSArray *arr = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSArray class]]) {
        arr = json;
    }else if ([json isKindOfClass:[NSString class]]){
        jsonData = [(NSString *)json dataUsingEncoding:NSUTF8StringEncoding];
    }else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        arr = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if ([arr isKindOfClass:[NSArray class]]) arr = nil;
    }
    return [self modelArrayWithClass:cls array:arr];
}

+ (NSArray *)modelArrayWithClass:(Class)cls array:(NSArray *)array {
    if (!cls || !array) return nil;
    NSMutableArray *tmp = [NSMutableArray new];
    for (NSDictionary *dic in array) {
        if (![dic isKindOfClass:[NSDictionary class]]) continue;
        NSObject *obj = [cls nw_modelWithDictionary:dic];
        if (obj) [tmp addObject:obj];
    }
    return tmp;
}

@end



@implementation NSDictionary (NWModel)

+ (NSDictionary *)nw_modelDictionaryWithClass:(Class)cls json:(id)json {
    if (!json) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    
    return [self modelDictionaryWithClass:cls dicionary:dic];
}

+ (NSDictionary *)modelDictionaryWithClass:(Class)cls dicionary:(NSDictionary *)dic {
    if (!cls || !dic) return nil;
    NSMutableDictionary *tmp = [NSMutableDictionary new];
    for (NSString *key in dic.allKeys) {
        if ([key isKindOfClass:[NSString class]]) continue;
        NSObject *obj = [cls nw_modelWithDictionary:dic[key]];
        if (obj) tmp[key] = obj;
    }
    return tmp;
}

@end
