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

//
//void (^augusBlock)(void);
//
//void test(void) {
//
//    int a = 10; // 值传递
//    static int b = 5; // 指针传递
//
//    augusBlock = ^{
//
//        NSLog(@"age is %d height is %d",a, b);
//    };
//
//    a = 20;
//    b = 10;
//
//}

typedef void (^GTBlock)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        NSLog(@"Hello, World!");
//
//        test();
//        augusBlock();
        
        GTPerosn *person = [[GTPerosn alloc] init];
        person.thin = NO;
        person.rich = NO;
        person.handsome = NO;
        NSLog(@"thin is %d rich is %d handsome is %d",person.isThin,person.isRich,person.isHandsome);
        
        

        

        
    }
    return 0;
}


void testBlock(void) {
    
    GTPerosn *person = [[GTPerosn alloc] init];
    person.weight = 10;
    
    
    // __weak:不会产生强引用，指向的对象销毁时，会自动让指针设置为nil
    // __unsafe__unretained:不安全的，不会产生强引用，不安全，指向对象销毁时，指针内存地址不变，被引用的弱对象内存地址回收以后不会置为nil，如果再去访问回收的内存会变为野指针
    
    // 推荐这种写法， 因为不用在意对象类型
    __weak typeof(person)weakPerson = person;
    //
//    __weak GTPerosn *weak1Person = person;
    person.block = ^{
        NSLog(@"person age is %d",weakPerson.weight);
    };
    
    NSLog(@"1111");

    
    
//        // block修改外部变量
////        int a = 2;
//        static int a = 2;
//        GTBlock block = ^{
//            // 报错Variable is not assignable (missing __block type specifier)
//            // 为什么？
//            // 首先是两个不同的栈空间，无法修改
//            // 修改:将int a = 2;修改为static int a = 2;这样修改为就变为指针传递
//            // 执行这个打印的时候会把block传递进来，拿到这个block就可以获取到该变量的指针，拿到指针就可以修改
//            // 这样修改完成之后就一直存在内存中
//            // 如果还是希望是临时变量如何处理？__block
//            a = 5;
//
//            NSLog(@"age is %d", a);
//        };
//
//        block();
    
    
    
    
//        int a = 2;
//        NSLog(@"数据 全局%p",&age);
//        NSLog(@"局部变量 %p",&a);
//        NSLog(@"堆 %p",[[NSObject alloc] init]);
//        NSLog(@"unknown %p", [GTPerosn class]);
    
    
    
    
    // stack block
    
//        int age = 10;
//        void (^block)(void) = ^{
//
//            NSLog(@"age is %d",age);
//        };
//
//        NSLog(@"block class is %@",[block class]);
//
//        NSLog(@"block copy class is %@ %lu",[[block copy] class],(unsigned long)[[block copy] retainCount]);
//
//
//
//        NSLog(@"%lu %@",[^{
//            NSLog(@"it is block2 %d", age);
//        } retainCount],[^{
//                        NSLog(@"it is block2 %d", age);
//                    } class]);
//
//        NSLog(@"%lu %@",[[^{
//            NSLog(@"it is block2 %d", age);
//        } copy] retainCount], [[^{
//            NSLog(@"it is block2 %d", age);
//        } copy] class]);
    

    
    
//
//        void (^block0)(void) = ^{
//            NSLog(@"it is block0");
//        };
//
//        int age = 10;
//        void (^block1)(void) = ^{
//            NSLog(@"it is age %d",age);
//
//        };
//
//        NSLog(@"%@ %@ %@",[block0 class],[block1 class],[^{
//            NSLog(@"it is block2 %d", age);
//        } class]);
//
//
//        NSLog(@"%@",[block0 class]);
//
//        NSLog(@"%@",[[block0 class] superclass]);
//
//        NSLog(@"%@",[[[block0 class] superclass] superclass]);



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
    
//        GTPerosn *person1 = [[GTPerosn alloc] init];
//
//        GTObserver *observer = [[GTObserver alloc] init];
//
//        [person1 addObserver:observer forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
//
//
//        [person1 setValue:@10 forKey:@"age"];
//
//        NSLog(@"is end");
    
//
//        void(^block)(void) = ^{
//
//            NSLog(@"tian is my wife");
//        };
//
//        block();
//
}
