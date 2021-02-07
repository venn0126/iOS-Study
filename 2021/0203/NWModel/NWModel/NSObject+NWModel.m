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
                case NWEncodingNSTypeNSMutableArray:{
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
                    
                    
                default:
                    break;
            }
        }
    }
}

@implementation NSObject (NWModel)

#pragma mark - Privacy Action

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






@end
