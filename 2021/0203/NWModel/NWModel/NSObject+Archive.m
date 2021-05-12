//
//  NSObject+Archive.m
//  NWModel
//
//  Created by Augus on 2021/4/2.
//

#import "NSObject+Archive.h"
#import <objc/runtime.h>

@implementation NSObject (Archive)

- (void)encoder:(NSCoder *)aCoder {
    
    Class cls = self.class;
    while (cls && cls != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList(cls, &count);
        if (count <= 0) {
            return;
        }
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [self valueForKey:key];
            if (key && value) {
                [aCoder encodeObject:value forKey:key];
            }
        }
        
        free(ivars);
        ivars = NULL;
    }
}

- (void)decode:(NSCoder *)aDecoder {
    
    Class cls = self.class;
    while (cls && cls != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList(cls, &count);
        if (count <= 0) {
            return;
        }
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            if (key) {
                id value = [aDecoder decodeObjectForKey:key];
                if (value) {
                    [self setValue:value forKey:key];
                }
            }
        }
        free(ivars);
        ivars = NULL;
    }
}


@end
