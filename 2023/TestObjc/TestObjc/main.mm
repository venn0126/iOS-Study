//
//  main.m
//  TestObjc
//
//  Created by Augus on 2023/1/10.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "NSObject+Test.h"
#import "GTClassInfo.h"
#import "GTObserver.h"
#import "GTPerosn.h"



@interface GTStudent : NSObject<NSCopying> {
@public
    int _age;
    double _height;
}

@property(nonatomic, assign) int no;

- (void)studentInstanceMethods;

+ (void)studentClassMethods;

@end

@implementation GTStudent

- (void)test {
    NSLog(@"this is test");
}

- (id)copyWithZone:(NSZone *)zone {
    
    return self;
}

- (void)studentInstanceMethods {
    
    
}

+ (void)studentClassMethods {
    
    
}

@end


//@interface Student : NSObject {
//
//    @public
//    int _no;
//    int _age;
//}
//
//struct Student_IMPL {
//    struct NSObject_IMPL NSObject_IVARS;
//    int _no;
//    int _age;
//}
//@end


//struct gt_objc_class {
//    Class isa;
//    Class superclass;
//};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        NSLog(@"Hello, World!");
        
    
    
//        NSObject *obj = [[NSObject alloc] init];
//        NSLog(@"it is a obj %@",obj);
        
//        NSLog(@"GTStudent class is %p",[GTStudent class]);
//        NSLog(@"NSObject class is %p",[NSObject class]);
//
//
//        [GTStudent test];
//        [NSObject test];
        
        
        // instance->isa:0x0100000100008119
        
        // class:0x0000000100008118
        
        // class = instance->isa & ISA_MASK &
        
        /*
         
            if __x86_64__
                ISA_MASK = 0x007ffffffffffff8ULL
            elif __arm64__
                ISA_MASK = 0x0000000ffffffff8ULL
            }
         
         */
        
        
//        struct gt_objc_class *stuClass = (__bridge struct gt_objc_class *)([GTStudent class]);
//        struct gt_objc_class *objClass = (__bridge struct gt_objc_class *)([NSObject class]);
//
//        NSLog(@"111");
//
//
//        GTStudent *stu = [[GTStudent alloc] init];
//
//
//        // 0x0000000100008118
//        // stuCls-isa=
//        Class stuCls = [GTStudent class];
//        struct gt_objc_class *stuCls1 = (__bridge struct gt_objc_class *)(stuCls);
//        // 0x00000001000080f0
//        Class stuMetaCls = object_getClass(stuCls);
//
//
//        NSLog(@"%p---%p---%p",stu,stuCls,stuMetaCls);
        
        
//        gt_objc_class *stuClass = (__bridge gt_objc_class *)[GTStudent class];
//        class_rw_t *stuClassData = stuClass->data();
//
//        class_rw_t *stuMetaClassData = stuClass->metaClass()->data();
//
//        NSLog(@"this is a end");
        
        
        // KVC
        
        GTPerosn *person1 = [[GTPerosn alloc] init];
        
        GTObserver *observer = [[GTObserver alloc] init];
        
        [person1 addObserver:observer forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
        
        
        [person1 setValue:@10 forKey:@"age"];
        
        NSLog(@"is end");
        
        

        
    }
    return 0;
}
