//
//  NWClassInfo.m
//  NWModel
//
//  Created by Augus on 2021/2/5.
//

#import "NWClassInfo.h"
#import <objc/runtime.h>

NWEncodeType NWEncodingGetType(const char * typeEncoding) {
    char *type = (char *)typeEncoding;
    if (!type) return NWEncodeTypeUnknown;
    size_t len = strlen(type);
    if (len == 0) {
        return NWEncodeTypeUnknown;
    }
    
    NWEncodeType qualifier = 0;
    bool prefix = true;
    while (prefix) {
        switch (*type) {
            case 'r':
                qualifier |= NWEncodeTypeQualifierConst;
                type++;
                break;
            case 'n':
                qualifier |= NWEncodeTypeQualifierIn;
                type++;
                break;
            case 'N':
                qualifier |= NWEncodeTypeQualifierInout;
                type++;
                break;
            case 'o':
                qualifier |= NWEncodeTypeQualifierOut;
                type++;
                break;
            case 'O':
                qualifier |= NWEncodeTypeQualifierBycopy;
                type++;
                break;
            case 'R':
                qualifier |= NWEncodeTypeQualifierByref;
                type++;
                break;
            case 'V':
                qualifier |= NWEncodeTypeQualifierOneway;
                type++;
                break;
            default:
                prefix = false;
                break;
        }
    }
    
    len = strlen(type);
    if (len == 0) {
        return NWEncodeTypeUnknown | qualifier;
    }
    
    switch (*type) {
        case 'v': return NWEncodeTypeVoid | qualifier;
        case 'B': return NWEncodeTypeBool | qualifier;
        case 'c': return NWEncodeTypeInt8 | qualifier;
        case 'C': return NWEncodeTypeUInt8 | qualifier;
        case 's': return NWEncodeTypeInt16 | qualifier;
        case 'S': return NWEncodeTypeUInt16 | qualifier;
        case 'i': return NWEncodeTypeInt32 | qualifier;
        case 'I': return NWEncodeTypeUInt32 | qualifier;
        case 'q': return NWEncodeTypeInt64 | qualifier;
        case 'Q': return NWEncodeTypeUInt64 | qualifier;
        case 'f': return NWEncodeTypeFloat | qualifier;
        case 'd': return NWEncodeTypeDoubel | qualifier;
        case 'D': return NWEncodeTypeLongDoubel | qualifier;
        case '#': return NWEncodeTypeClass | qualifier;
        case ':': return NWEncodeTypeSEL | qualifier;
        case '*': return NWEncodeTypeCString | qualifier;
        case '^': return NWEncodeTypePointer | qualifier;
        case '[': return NWEncodeTypeCArray | qualifier;
        case '(': return NWEncodeTypeUnion | qualifier;
        case '{': return NWEncodeTypeStruct | qualifier;
        case '@': {
            if (len == 2 && *(type + 1) == '?') {
                return NWEncodeTypeBlock | qualifier;
            }else {
                return NWEncodeTypeObject | qualifier;
            }
        }
        default: return  NWEncodeTypeUnknown | qualifier;
    }
}

@implementation NWClassIvarInfo

- (instancetype)initWithIvar:(Ivar)ivar {
    if (!ivar) {
        return nil;
    }
    self = [super init];
    _ivar = ivar;
    const char *name = ivar_getName(ivar);
    if (name) {
        _name = [NSString stringWithUTF8String:name];
    }
    _offset = ivar_getOffset(ivar);
    const char *typeEncoding = ivar_getTypeEncoding(ivar);
    if (typeEncoding) {
        _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
        _type = NWEncodingGetType(typeEncoding);
    }
    return self;
}

@end

@implementation NWClassMethodInfo

- (instancetype)initWithMethod:(Method)method {
    if (!method) {
        return nil;
    }
    self = [super init];
    _method = method;
    _sel = method_getName(method);
    _imp = method_getImplementation(method);
    const char *name = sel_getName(_sel);
    if (name) {
        _name = [NSString stringWithUTF8String:name];
    }
    const char *typeEncoding = method_getTypeEncoding(method);
    if (typeEncoding) {
        _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
    }
    char *returnType = method_copyReturnType(method);
    if (returnType) {
        _returnTypeEncoding = [NSString stringWithUTF8String:returnType];
        free(returnType);
    }
    
    unsigned int argumentCount = method_getNumberOfArguments(method);
    if (argumentCount > 0) {
        NSMutableArray *argumentTypes = [NSMutableArray new];
        for (unsigned int i = 0; i < argumentCount; i++) {
            char * argumentType = method_copyArgumentType(method, i);
            NSString *type = argumentType ? [NSString stringWithUTF8String:argumentType] : nil;
            [argumentTypes addObject:type ? type : @""];
            if (argumentType) {
                free(argumentType);
            }
        }
        _argumentTypeEncodings = argumentTypes;
    }
    return self;
}

@end

@implementation NWClassPropertyInfo

- (instancetype)initWithProperty:(objc_property_t)property {
    if (!property) {
        return nil;
    }
    self = [super init];
    _property = property;
    const char *name = property_getName(property);
    if (name) {
        _name = [NSString stringWithUTF8String:name];
    }
    NWEncodeType type = 0;
    unsigned int attrCount;
    objc_property_attribute_t *attrs = property_copyAttributeList(property, &attrCount);
    for (unsigned int i = 0; i < attrCount; i++) {
        switch (attrs[i].name[0]) {
            case 'T':// type
                
                if (attrs[i].value) {
                    _typeEncoding = [NSString stringWithUTF8String:attrs[i].value];
                    type = NWEncodingGetType(attrs[i].value);
                    
                    if ((type & NWEncodeTypeMask) == NWEncodeTypeObject && _typeEncoding.length ) {
                        NSScanner *scanner = [NSScanner scannerWithString:_typeEncoding];
                        if (![scanner scanString:@"@\"" intoString:NULL]) {
                            continue;
                        }
                        NSString *clsName = nil;
                        if ([scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"<"] intoString:&clsName]) {
                            if (clsName.length) {
                                _cls = objc_getClass(clsName.UTF8String);
                            }
                        }
                        NSMutableArray *protocols = nil;
                        while ([scanner scanString:@"<" intoString:NULL]) {
                            NSString *protocol = nil;
                            if ([scanner scanUpToString:@">" intoString:&protocol]) {
                                if (protocol.length) {
                                    if (!protocols) {
                                        protocols = [NSMutableArray new];
                                    }
                                    [protocols addObject:protocol];
                                }
                            }
                            [scanner scanString:@">" intoString:NULL];
                        }
                        _protocols = protocols;
                    }
                }
            
                break;
            case 'V':{
                if (attrs[i].value) {
                    _ivarName = [NSString stringWithUTF8String:attrs[i].value];
                }
            }break;
            case 'R':{
                type |= NWEncodeTypePropertyReadonly;
            } break;
            case 'C':{
                type |= NWEncodeTypePropertyCopy;
            } break;
            case '&':{
                type |= NWEncodeTypePropertyRetain;
            } break;
            case 'N':{
                type |= NWEncodeTypePropertyNonatomic;
            } break;
            case 'D':{
                type |= NWEncodeTypePropertyDynamic;
            } break;
            case 'W':{
                type |= NWEncodeTypePropertyWeak;
            } break;
            case 'G':{
                type |= NWEncodeTypePropertyCustomGetter;
                if (attrs[i].value) {
                    _getter = NSSelectorFromString([NSString stringWithUTF8String:attrs[i].value]);
                }
            } break;
            case 'S':{
                type |= NWEncodeTypePropertyCustomSetter;
                if (attrs[i].value) {
                    _setter = NSSelectorFromString([NSString stringWithUTF8String:attrs[i].value]);
                }
            } break;
            default:
                break;
        }
    }
    
    if (attrs) {
        free(attrs);
        attrs = NULL;
    }
    _type = type;
    if (_name.length) {
        if (!_getter) {
            _getter = NSSelectorFromString(_name);
        }
        if (!_setter) {
            _setter = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",[_name substringToIndex:1].uppercaseString,[_name substringFromIndex:1]]);
        }
    }
    
    return self;
}

@end

@implementation NWClassInfo{
    
    BOOL _needUpdate;
}

- (instancetype)initWithClass:(Class)cls {
    if (!cls) {
        return nil;
    }
    self = [super init];
    _cls = cls;
    _superCls = class_getSuperclass(cls);
    _isMeta = class_isMetaClass(cls);
    if (!_isMeta) {
        _metaCls = objc_getMetaClass(class_getName(cls));
    }
    _name = NSStringFromClass(cls);
    [self _update];
    
    _superClassInfo = [self.class classInfoWithClass:_superCls];
    return self;
}

- (void)_update {
    _ivarInfos = nil;
    _methodInfos = nil;
    _propertyInfos = nil;
    
    Class cls = self.cls;
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(cls, &methodCount);
    if (methods) {
        NSMutableDictionary *methodInfos = [NSMutableDictionary new];
        _methodInfos = methodInfos;
        for (unsigned int i = 0; i < methodCount; i++) {
            NWClassMethodInfo *info = [[NWClassMethodInfo alloc] initWithMethod:methods[i]];
            if (info.name) {
                methodInfos[info.name] = info;
            }
        }
        free(methods);
    }
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &propertyCount);
    if (properties) {
        NSMutableDictionary *propertyInfos = [NSMutableDictionary new];
        _propertyInfos = propertyInfos;
        for (unsigned int i = 0; i < propertyCount; i++) {
            NWClassPropertyInfo *info = [[NWClassPropertyInfo alloc] initWithProperty:properties[i]];
            if (info.name) {
                propertyInfos[info.name] = info;
            }
        }
        free(properties);
    }
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList(cls, &ivarCount);
    if (ivars) {
        NSMutableDictionary *ivarInfos = [NSMutableDictionary new];
        _ivarInfos = ivarInfos;
        for (unsigned int i = 0; i < ivarCount; i++) {
            NWClassIvarInfo *info = [[NWClassIvarInfo alloc] initWithIvar:ivars[i]];
            if (info.name) {
                ivarInfos[info.name] = info;
            }
        }
        free(ivars);
    }
    
    if (!_ivarInfos) {
        _ivarInfos = @{};
    }
    if (!_propertyInfos) {
        _propertyInfos = @{};
    }
    if (!_methodInfos) {
        _methodInfos = @{};
    }
    _needUpdate = NO;
}

- (void)setNeedUpdate {
    _needUpdate = YES;
}

- (BOOL)needUpdate {
    return _needUpdate;
}

+ (instancetype)classInfoWithClass:(Class)cls {
    if (!cls) {
        return nil;
    }
    static CFMutableDictionaryRef classCache;
    static CFMutableDictionaryRef metaCache;
    static dispatch_semaphore_t lock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        classCache = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        metaCache = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        lock = dispatch_semaphore_create(1);
    });
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);/// -1
    NWClassInfo *info = CFDictionaryGetValue(class_isMetaClass(cls) ? metaCache : classCache, (__bridge const void *)(cls));
    if (info && info->_needUpdate) {
        [info _update];
    }
    dispatch_semaphore_signal(lock);/// +1
    if (!info) {
        info = [[NWClassInfo alloc] initWithClass:cls];
        if (info) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);/// -1
            CFDictionarySetValue(info.isMeta ? metaCache : classCache, (__bridge const void *)(cls), (__bridge const void *)(info));
            dispatch_semaphore_signal(lock);/// +1
        }
    }
    return info;
}

+ (instancetype)classInfoWithClassName:(NSString *)className {
    Class cls = NSClassFromString(className);
    return [self classInfoWithClass:cls];
}

@end
