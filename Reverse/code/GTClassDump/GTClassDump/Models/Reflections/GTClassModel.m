//
//  GTClassModel.m
//  GTClassDump
//
//  Created by Augus on 2023/7/16.
//

#import "GTClassModel.h"
#import "GTTypeParser.h"
#import "GTIvarModel.h"
#import "GTPropertyModel.h"
#import "GTMethodModel.h"
#import "GTProtocolModel.h"
#import "GTSemanticString.h"

#import <dlfcn.h>

@implementation GTClassModel{
    NSArray<NSString *> *_classPropertySynthesizedMethods;
    NSArray<NSString *> *_instancePropertySynthesizedMethods;
    NSArray<NSString *> *_instancePropertySynthesizedVars;
}

+ (instancetype)modelWithClass:(Class)cls {
    return [[self alloc] initWithClass:cls];
}

- (instancetype)initWithClass:(Class)cls {
    if (self = [self init]) {
        _backing = cls;
        _name = NSStringFromClass(cls);
        
        Class const metaClass = object_getClass(cls);
        
        unsigned int count, index;
        
        Protocol *__unsafe_unretained *protocolList = class_copyProtocolList(cls, &count);
        if (protocolList) {
            NSMutableArray<GTProtocolModel *> *protocols = [NSMutableArray arrayWithCapacity:count];
            for (index = 0; index < count; index++) {
                Protocol *objc_protocol = protocolList[index];
                [protocols addObject:[GTProtocolModel modelWithProtocol:objc_protocol]];
            }
            free(protocolList);
            _protocols = [protocols copy];
        }
        
        objc_property_t *classPropertyList = class_copyPropertyList(metaClass, &count);
        if (classPropertyList) {
            NSMutableArray<NSString *> *synthMeths = [NSMutableArray array];
            NSMutableArray<GTPropertyModel *> *properties = [NSMutableArray arrayWithCapacity:count];
            for (index = 0; index < count; index++) {
                objc_property_t objc_property = classPropertyList[index];
                GTPropertyModel *propertyRep = [GTPropertyModel modelWithProperty:objc_property isClass:YES];
                [properties addObject:propertyRep];
                NSString *synthMethodName;
                if ((synthMethodName = propertyRep.getter)) {
                    [synthMeths addObject:synthMethodName];
                }
                if ((synthMethodName = propertyRep.setter)) {
                    [synthMeths addObject:synthMethodName];
                }
            }
            free(classPropertyList);
            _classPropertySynthesizedMethods = [synthMeths copy];
            _classProperties = [properties copy];
        }
        
        objc_property_t *propertyList = class_copyPropertyList(cls, &count);
        if (propertyList) {
            NSMutableArray<NSString *> *synthMeths = [NSMutableArray array];
            NSMutableArray<NSString *> *syntVars = [NSMutableArray array];
            NSMutableArray<GTPropertyModel *> *properties = [NSMutableArray arrayWithCapacity:count];
            for (index = 0; index < count; index++) {
                objc_property_t objc_property = propertyList[index];
                GTPropertyModel *propertyRep = [GTPropertyModel modelWithProperty:objc_property isClass:NO];
                [properties addObject:propertyRep];
                NSString *synthCompName;
                if ((synthCompName = propertyRep.getter)) {
                    [synthMeths addObject:synthCompName];
                }
                if ((synthCompName = propertyRep.setter)) {
                    [synthMeths addObject:synthCompName];
                }
                if ((synthCompName = propertyRep.iVar)) {
                    [syntVars addObject:synthCompName];
                }
            }
            free(propertyList);
            _instancePropertySynthesizedMethods = [synthMeths copy];
            _instancePropertySynthesizedVars = [syntVars copy];
            _instanceProperties = [properties copy];
        }
        
        Ivar *ivarList = class_copyIvarList(cls, &count);
        if (ivarList) {
            NSMutableArray<GTIvarModel *> *ivars = [NSMutableArray arrayWithCapacity:count];
            
            NSMutableArray<GTPropertyModel *> *eligibleProperties = [NSMutableArray arrayWithArray:self.instanceProperties];
            NSUInteger eligiblePropertiesCount = eligibleProperties.count;
            
            for (index = 0; index < count; index++) {
                GTIvarModel *model = [GTIvarModel modelWithIvar:ivarList[index]];
                
                for (NSUInteger eligibleIndex = 0; eligibleIndex < eligiblePropertiesCount; eligibleIndex++) {
                    GTPropertyModel *propModel = eligibleProperties[eligibleIndex];
                    if ([propModel.iVar isEqualToString:model.name]) {
                        [propModel overrideType:model.type];
                        
                        eligiblePropertiesCount--;
                        // constant time operation
                        // since we decremented eligiblePropertiesCount, this object is now unreachable
                        [eligibleProperties exchangeObjectAtIndex:eligibleIndex withObjectAtIndex:eligiblePropertiesCount];
                        
                        break;
                    }
                }
                [ivars addObject:model];
            }
            free(ivarList);
            _ivars = [ivars copy];
        }
        
        Method *classMethodList = class_copyMethodList(metaClass, &count);
        if (classMethodList) {
            NSMutableArray<GTMethodModel *> *methods = [NSMutableArray arrayWithCapacity:count];
            for (index = 0; index < count; index++) {
                [methods addObject:[GTMethodModel modelWithMethod:*method_getDescription(classMethodList[index]) isClass:YES]];
            }
            _classMethods = [methods copy];
            free(classMethodList);
        }
        
        Method *methodList = class_copyMethodList(cls, &count);
        if (methodList) {
            NSMutableArray<GTMethodModel *> *methods = [NSMutableArray arrayWithCapacity:count];
            for (index = 0; index < count; index++) {
                [methods addObject:[GTMethodModel modelWithMethod:*method_getDescription(methodList[index]) isClass:NO]];
            }
            _instanceMethods = [methods copy];
            free(methodList);
        }
        
    }
    return self;
}

- (NSString *)linesWithComments:(BOOL)comments synthesizeStrip:(BOOL)synthesizeStrip {
    return [[self semanticLinesWithComments:comments synthesizeStrip:synthesizeStrip] string];
}

- (GTSemanticString *)semanticLinesWithComments:(BOOL)comments synthesizeStrip:(BOOL)synthesizeStrip {
    Dl_info info;
    
    GTSemanticString *build = [GTSemanticString new];
    
    NSSet<NSString *> *forwardClasses = [self _forwardDeclarableClassReferences];
    NSUInteger const forwardClassCount = forwardClasses.count;
    if (forwardClassCount > 0) {
        [build appendString:@"@class" semanticType:GTSemanticTypeKeyword];
        [build appendString:@" " semanticType:GTSemanticTypeStandard];
        
        NSUInteger classNamesRemaining = forwardClassCount;
        for (NSString *className in forwardClasses) {
            [build appendString:className semanticType:GTSemanticTypeClass];
            classNamesRemaining--;
            if (classNamesRemaining > 0) {
                [build appendString:@", " semanticType:GTSemanticTypeStandard];
            }
        }
        [build appendString:@";\n" semanticType:GTSemanticTypeStandard];
    }
    
    NSSet<NSString *> *forwardProtocols = [self _forwardDeclarableProtocolReferences];
    NSUInteger const forwardProtocolCount = forwardProtocols.count;
    if (forwardProtocolCount > 0) {
        [build appendString:@"@protocol" semanticType:GTSemanticTypeKeyword];
        [build appendString:@" " semanticType:GTSemanticTypeStandard];
        
        NSUInteger protocolNamesRemaining = forwardProtocolCount;
        for (NSString *protocolNames in forwardProtocols) {
            [build appendString:protocolNames semanticType:GTSemanticTypeProtocol];
            protocolNamesRemaining--;
            if (protocolNamesRemaining > 0) {
                [build appendString:@", " semanticType:GTSemanticTypeStandard];
            }
        }
        [build appendString:@";\n" semanticType:GTSemanticTypeStandard];
    }
    
    if (forwardClassCount > 0 || forwardProtocolCount > 0) {
        [build appendString:@"\n" semanticType:GTSemanticTypeStandard];
    }
    
    if (comments) {
        NSString *comment = nil;
        if (dladdr((__bridge const void *)self.backing, &info)) {
            comment = [NSString stringWithFormat:@"/* %s in %s */", info.dli_sname ?: "(anonymous)", info.dli_fname];
        } else {
            comment = @"/* no symbol found */";
        }
        [build appendString:comment semanticType:GTSemanticTypeComment];
        [build appendString:@"\n" semanticType:GTSemanticTypeStandard];
    }
    [build appendString:@"@interface" semanticType:GTSemanticTypeKeyword];
    [build appendString:@" " semanticType:GTSemanticTypeStandard];
    [build appendString:self.name semanticType:GTSemanticTypeClass];
    
    Class superclass = class_getSuperclass(self.backing);
    if (superclass) {
        [build appendString:@" : " semanticType:GTSemanticTypeStandard];
        [build appendString:NSStringFromClass(superclass) semanticType:GTSemanticTypeClass];
    }
    
    NSArray<GTProtocolModel *> *protocols = self.protocols;
    NSUInteger const protocolCount = protocols.count;
    if (protocolCount > 0) {
        [build appendString:@" " semanticType:GTSemanticTypeStandard];
        [build appendString:@"<" semanticType:GTSemanticTypeStandard];
        [protocols enumerateObjectsUsingBlock:^(GTProtocolModel *protocol, NSUInteger idx, BOOL *stop) {
            [build appendString:protocol.name semanticType:GTSemanticTypeProtocol];
            if ((idx + 1) < protocolCount) {
                [build appendString:@", " semanticType:GTSemanticTypeStandard];
            }
        }];
        [build appendString:@">" semanticType:GTSemanticTypeStandard];
    }
    
    NSArray<NSString *> *synthedClassMethds = nil, *synthedInstcMethds = nil, *synthedVars = nil;
    if (synthesizeStrip) {
        synthedClassMethds = _classPropertySynthesizedMethods;
        synthedInstcMethds = _instancePropertySynthesizedMethods;
        synthedVars = _instancePropertySynthesizedVars;
    }
    
    if (self.ivars.count - synthedVars.count) {
        [build appendString:@" {\n" semanticType:GTSemanticTypeStandard];
        for (GTIvarModel *ivar in self.ivars) {
            if ([synthedVars containsObject:ivar.name]) {
                continue;
            }
            if (comments) {
                NSString *comment = nil;
                if (dladdr(ivar.backing, &info)) {
                    comment = [NSString stringWithFormat:@"/* in %s */", info.dli_fname];
                } else {
                    comment = @"/* no symbol found */";
                }
                [build appendString:@"\n    " semanticType:GTSemanticTypeStandard];
                [build appendString:comment semanticType:GTSemanticTypeComment];
                [build appendString:@"\n" semanticType:GTSemanticTypeStandard];
            }
            [build appendString:@"    " semanticType:GTSemanticTypeStandard];
            [build appendSemanticString:[ivar semanticString]];
            [build appendString:@";\n" semanticType:GTSemanticTypeStandard];
        }
        [build appendString:@"}" semanticType:GTSemanticTypeStandard];
    }
    
    [build appendString:@"\n" semanticType:GTSemanticTypeStandard];
    
    // todo: add stripping of protocol conformance
    
    [self _appendLines:build properties:self.classProperties comments:comments];
    [self _appendLines:build properties:self.instanceProperties comments:comments];
    
    [self _appendLines:build methods:self.classMethods synthesized:synthedClassMethds comments:comments];
    [self _appendLines:build methods:self.instanceMethods synthesized:synthedInstcMethds comments:comments];
    
    [build appendString:@"\n" semanticType:GTSemanticTypeStandard];
    [build appendString:@"@end" semanticType:GTSemanticTypeKeyword];
    [build appendString:@"\n" semanticType:GTSemanticTypeStandard];
    
    return build;
}

- (void)_appendLines:(GTSemanticString *)build properties:(NSArray<GTPropertyModel *> *)properties comments:(BOOL)comments {
    if (properties.count) {
        [build appendString:@"\n" semanticType:GTSemanticTypeStandard];
        
        Dl_info info;
        for (GTPropertyModel *prop in properties) {
            if (comments) {
                NSString *comment = nil;
                if (dladdr(prop.backing, &info)) {
                    comment = [NSString stringWithFormat:@"/* in %s */", info.dli_fname];
                } else {
                    comment = @"/* no symbol found */";
                }
                [build appendString:@"\n" semanticType:GTSemanticTypeStandard];
                [build appendString:comment semanticType:GTSemanticTypeComment];
                [build appendString:@"\n" semanticType:GTSemanticTypeStandard];
            }
            [build appendSemanticString:[prop semanticString]];
            [build appendString:@";\n" semanticType:GTSemanticTypeStandard];
        }
    }
}

- (void)_appendLines:(GTSemanticString *)build methods:(NSArray<GTMethodModel *> *)methods synthesized:(NSArray<NSString *> *)synthesized comments:(BOOL)comments {
    if (methods.count - synthesized.count) {
        [build appendString:@"\n" semanticType:GTSemanticTypeStandard];
        
        Dl_info info;
        NSMutableArray<NSString *> *synthed = [NSMutableArray arrayWithArray:synthesized];
        NSUInteger synthedCount = synthed.count;
        for (GTMethodModel *methd in methods) {
            // find and remove instead of just find so we don't have to search the entire
            // array everytime, when we know the objects that we've already filtered out won't come up again
            NSUInteger const searchResult = [synthed indexOfObject:methd.name inRange:NSMakeRange(0, synthedCount)];
            if (searchResult != NSNotFound) {
                synthedCount--;
                // optimized version of remove since the
                // order of synthed doesn't matter to us.
                // exchange is O(1) instead of remove is O(n)
                [synthed exchangeObjectAtIndex:searchResult withObjectAtIndex:synthedCount];
                continue;
            }
            
            if (comments) {
                Method objcMethod = NULL;
                if (methd.isClass) {
                    objcMethod = class_getClassMethod(self.backing, methd.backing.name);
                } else {
                    objcMethod = class_getInstanceMethod(self.backing, methd.backing.name);
                }
                IMP const methdImp = method_getImplementation(objcMethod);
                
                NSString *comment = nil;
                if (dladdr(methdImp, &info)) {
                    comment = [NSString stringWithFormat:@"/* %s in %s */", info.dli_sname ?: "(anonymous)", info.dli_fname];
                } else {
                    comment = @"/* no symbol found */";
                }
                [build appendString:@"\n" semanticType:GTSemanticTypeStandard];
                [build appendString:comment semanticType:GTSemanticTypeComment];
                [build appendString:@"\n" semanticType:GTSemanticTypeStandard];
            }
            [build appendSemanticString:[methd semanticString]];
            [build appendString:@";\n" semanticType:GTSemanticTypeStandard];
        }
    }
}

- (NSSet<NSString *> *)_forwardDeclarableClassReferences {
    NSMutableSet<NSString *> *build = [NSMutableSet set];
    
    [self _unionReferences:build sources:self.classProperties resolve:^NSSet<NSString *> *(GTPropertyModel *model) {
        return [model.type classReferences];
    }];
    [self _unionReferences:build sources:self.instanceProperties resolve:^NSSet<NSString *> *(GTPropertyModel *model) {
        return [model.type classReferences];
    }];
    
    [self _unionReferences:build sources:self.classMethods resolve:^NSSet<NSString *> *(GTMethodModel *model) {
        return [model classReferences];
    }];
    [self _unionReferences:build sources:self.instanceMethods resolve:^NSSet<NSString *> *(GTMethodModel *model) {
        return [model classReferences];
    }];
    
    [self _unionReferences:build sources:self.ivars resolve:^NSSet<NSString *> *(GTIvarModel *model) {
        return [model.type classReferences];
    }];
    
    [build removeObject:self.name];
    return build;
}

- (NSSet<NSString *> *)_forwardDeclarableProtocolReferences {
    NSMutableSet<NSString *> *build = [NSMutableSet set];
    
    [self _unionReferences:build sources:self.classProperties resolve:^NSSet<NSString *> *(GTPropertyModel *model) {
        return [model.type protocolReferences];
    }];
    [self _unionReferences:build sources:self.instanceProperties resolve:^NSSet<NSString *> *(GTPropertyModel *model) {
        return [model.type protocolReferences];
    }];
    
    [self _unionReferences:build sources:self.classMethods resolve:^NSSet<NSString *> *(GTMethodModel *model) {
        return [model protocolReferences];
    }];
    [self _unionReferences:build sources:self.instanceMethods resolve:^NSSet<NSString *> *(GTMethodModel *model) {
        return [model protocolReferences];
    }];
    
    [self _unionReferences:build sources:self.ivars resolve:^NSSet<NSString *> *(GTIvarModel *model) {
        return [model.type protocolReferences];
    }];
    
    return build;
}

- (NSSet<NSString *> *)classReferences {
    NSMutableSet<NSString *> *build = [NSMutableSet set];
    
    NSSet<NSString *> *forwardDeclarable = [self _forwardDeclarableClassReferences];
    if (forwardDeclarable != nil) {
        [build unionSet:forwardDeclarable];
    }
    
    Class const superclass = class_getSuperclass(self.backing);
    if (superclass != NULL) {
        [build addObject:NSStringFromClass(superclass)];
    }
    
    return build;
}

- (NSSet<NSString *> *)protocolReferences {
    NSMutableSet<NSString *> *build = [NSMutableSet set];
    
    NSSet<NSString *> *forwardDeclarable = [self _forwardDeclarableProtocolReferences];
    if (forwardDeclarable != nil) {
        [build unionSet:forwardDeclarable];
    }
    
    for (GTProtocolModel *protocol in self.protocols) {
        [build addObject:protocol.name];
    }
    
    return build;
}

- (void)_unionReferences:(NSMutableSet<NSString *> *)build sources:(NSArray *)sources resolve:(NSSet<NSString *> *(NS_NOESCAPE ^)(id))resolver {
    for (id source in sources) {
        NSSet<NSString *> *refs = resolver(source);
        if (refs != nil) {
            [build unionSet:refs];
        }
    }
}

- (NSString *)description {
    return self.name;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p> {name: '%@', protocols: %@, "
            "classProperties: %@, instanceProperties: %@, classMethods: %@, instanceMethods: %@, ivars: %@}",
            [self class], self, self.name, self.protocols,
            self.classProperties, self.instanceProperties, self.classMethods, self.instanceMethods, self.ivars];
}


@end
