//
//  XHTool.m
//  TestHookEncryption
//
//  Created by Augus on 2023/11/15.
//

#import "XHTool.h"
#include <dlfcn.h> // dlopen RTLD_NOW

@implementation XHTool

+ (void *)meng_imageHandleForName:(NSString *)name {

    NSString *frameworkPath =[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Frameworks"];
    NSString *frameworkComponent = [NSString stringWithFormat:@"%@.framework/%@",name, name];
    NSString *easyCorePath = [frameworkPath stringByAppendingPathComponent:frameworkComponent];

    NSLog(@"Image:%@ path:%@", name, easyCorePath);
    const char *scbEasyCoreCString = [easyCorePath cStringUsingEncoding:NSASCIIStringEncoding];
    void *easyCoreHandle = dlopen(scbEasyCoreCString, RTLD_NOW);
    return easyCoreHandle;
}

+ (void *)meng_symbolHandleForImageName:(NSString *)name symbol:(const char *)symbol {

    void *handle = [self meng_imageHandleForName:name];
    if (handle == NULL) {
        NSLog(@"Image %@ handle is nil",name);
        return NULL;
    }

    void *symHandle = dlsym(handle, symbol);
    return symHandle;
}

@end
