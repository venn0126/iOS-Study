//
//  NSBundle+GTInfo.m
//  TestHookEncryption
//
//  Created by Augus on 2023/7/18.
//

#import "NSBundle+GTInfo.h"
#import <objc/runtime.h>
#import <dlfcn.h>
#import <mach-o/ldsyms.h>

@implementation NSBundle (GTInfo)

+ (NSArray<Class> *)gt_bundleOwnClassInfo {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    unsigned int classCount;
    const char **classes;
    Dl_info info;
    dladdr(&_mh_execute_header, &info);
    classes = objc_copyClassNamesForImage(info.dli_fname, &classCount);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_apply(classCount, dispatch_get_global_queue(0, 0), ^(size_t iteration) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSString *className = [NSString stringWithCString:classes[iteration] encoding:NSUTF8StringEncoding];
        Class class = NSClassFromString(className);
        [resultArray addObject:class];
        dispatch_semaphore_signal(semaphore);
    });
    return  [resultArray copy];
}


+ (NSArray<Class> *)gt_bundleOwnClassString {
    NSMutableArray *resultArray = [NSMutableArray array];
    unsigned int classCount;
    const char **classes;
    Dl_info info;
    dladdr(&_mh_execute_header, &info);
    classes = objc_copyClassNamesForImage(info.dli_fname, &classCount);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_apply(classCount, dispatch_get_global_queue(0, 0), ^(size_t iteration) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSString *className = [NSString stringWithCString:classes[iteration] encoding:NSUTF8StringEncoding];
        [resultArray addObject:className];
        dispatch_semaphore_signal(semaphore);
    });
   
    return  [resultArray copy];;
}


+ (NSArray<Class> *)gt_bundleAllClassInfo {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    int classCount = objc_getClassList(NULL, 0);
    Class *classes = NULL;
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) *classCount);
    classCount = objc_getClassList(classes, classCount);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_apply(classCount, dispatch_get_global_queue(0, 0), ^(size_t iteration) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        Class class = classes[iteration];
        [resultArray addObject:class];
        dispatch_semaphore_signal(semaphore);
    });
    
    free(classes);
    classes = NULL;
    
    return [resultArray copy];
}


+ (NSArray<NSString *> *)gt_bundleAllClassString {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    int classCount = objc_getClassList(NULL, 0);
    Class *classes = NULL;
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) *classCount);
    classCount = objc_getClassList(classes, classCount);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_apply(classCount, dispatch_get_global_queue(0, 0), ^(size_t iteration) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        Class class = classes[iteration];
        NSString *className = [[NSString alloc] initWithUTF8String:class_getName(class)];
        [resultArray addObject:className];
        dispatch_semaphore_signal(semaphore);
    });
    
    free(classes);
    classes = NULL;
    
    return  [resultArray copy];
}


+ (NSArray <NSString *> *)gt_bundleExceptSystemClassString {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    int classCount = objc_getClassList(NULL, 0);
    Class *classes = NULL;
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) *classCount);
    classCount = objc_getClassList(classes, classCount);
        
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_apply(classCount, dispatch_get_global_queue(0, 0), ^(size_t iteration) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        Class class = classes[iteration];
        NSString *className = [[NSString alloc] initWithUTF8String:class_getName(class)];
        [resultArray addObject:className];
        dispatch_semaphore_signal(semaphore);
    });
    
    free(classes);
    classes = NULL;
    
    return  [resultArray copy];
}

@end
