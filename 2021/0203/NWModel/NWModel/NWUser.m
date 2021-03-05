//
//  NWUser.m
//  NWModel
//
//  Created by Augus on 2021/2/9.
//

#import "NWUser.h"
#import <objc/runtime.h>


@implementation NWUser


+ (void)load {
    
//    NSLog(@"%@---%s",[self class],__FUNCTION__);
    
//    objc_setAssociatedObject(<#id  _Nonnull object#>, <#const void * _Nonnull key#>, <#id  _Nullable value#>, <#objc_AssociationPolicy policy#>)
    
}


/**
 // uint  pointer _type
 struct Block_description_1 {
 uintptr_t reserved;// 保留字段
 uintptr_t size;// 大小
 }
 // volatile关键字是用来阻止（伪）编译器因误认某段代码无法被代码本身所改变，而造成的过度优化
 struct Block_layout {
    void *isa;// 在oc中凡事有isa，都会被认为是对象，所以block其实是对象
    volatile int32_t flags;
    void (*invoke)(void *,...);
    struct Block_description_1 *description;
    // import variables 导入的变量
 }
 
 
 // 测试样例
void foo_ {
 
    int i = 2;
    NSNubmber *num = @3;
    long (^myBlock)(void) = ^long(void){
        return i *num.intValue;
 };
    long r = myBlock();
 }
 
 // clang 翻译成c++之后，进行了简化和调整
 struct __block_impl {
    void *isa;// 无符号指针
    int flags;// 标识符
    int Reserved;// 保留字段
    void *FuncPtr; // 方法指针
 }
 
 // 在foo函数中的myBlock的描述
 struct __foo_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(struct __foo_block_impl_0 *,struct __foo_block_impl_0 *);
    void (*dispose)(struct __foo_block_impl_0 *);
 };
 
 // myblock的数据结构定义
 struct __foo_block_impl_0 {
    struct __block_impl impl;
    struct __foo_block_desc_0* desc;
    int i;
    NSNumber *num;
 }
 
 // block数据的描述
 static struct __foo_block_desc_0 __foo_block_desc_0_DATA = {
 0,
 sizeof(struct __foo_block_impl_0),
 __foo_block_copy_0,
 __foo_block_dispose_0
 };
 
 // block中的方法
 static long __foo_block_func_0(struct __foo_block_impl_0 *__cself) {
    int i = __cself->i; // bound by copy 复制边界
    NSNumber *num = __cself->num; bound by copy
    return i * num.intValue;
 }
 
 void foo(){
    int i = 2;
    NSNumber *num = @3;
    
    struct __foo_block_impl_0 myBlockT;
    struct __foo_block_impl_0 *myBlock = &myBlockT;
    myBlock->impl.isa = &_NSConcreteStackBlock;
    myBlock->impl.Flags = 570425344;
    myBlock->impl.FuncPtr = __foo_block_func_0;
    myBlock->Desc = &__foo_block_desc_0_DATA;
    myBlock->i = i;
    myBlock->num = num;
 
    long r = myBlock->impl.FuncPtr(myBlock);
 }
 编译器会根据block捕获的变量，生成具体的结构体定义，block内部的代码会提取出来，
 成为一个单独的C函数，创建block时，实际就是在方法中声明一个struct，并初始化该struct成员
 而执行block时，就是调用那个单独的C函数，并把该struct的指针传递过去
 
 block中包含了被引用的自由变量（被struct持有），也包含了控制成分的代码块（由函数指针持有）
 符合闭包的概念
 
 2.block and copy
 block中的isa指向的是该block的Class.在block runtime中，定义了6种类
 
 _NSConcreteStackBlock 栈上创建的block
 _NSConcreteMallocBlock 堆上创建的block
 _NSConcreteGlobalBlock 作为全局变量的block
 _NSConcreteWeakBlockVariable
 _NSConcreteAutoBlock
 _NSConcreteFinalizingBlock
 
 上面的代码可以看到，当struct第一次被创建的时候，它是存在于函数的栈帧上的，
 其class是固定的_NSConcreteStackBlock，其捕获的变量会赋值到结构体的成员上，所以当block初始化完成后
 捕获到的变量不能修改
 
 当函数返回时，函数的栈帧被销毁，这个block的内存也会被清除。所以在函数结束后仍然需要这个block时
 就必须用到Block_copy()方法将它拷贝到堆上，这个方法的核心动作很简单：
 申请内存，将栈数据复制过去，将Class改一下，最后向捕获到的对象发送retain，增加block的引用计数
 
 struct Block_layout *result = malloc(aBlock->descriptor->size);
 memmove(result,aBlock,aBlock->descriptor->size);
 result->isa = _NSConcreteMallocBlock;
 _Block_call_copy_helper(result,aBlock);
 return result;
 
 
 3 __block类型的变量
 默认block捕获到的变量，都是赋值给block结构体的，相当于const不可更改
 为了让block能访问并修改外部变量，需要加上__block
 
 void foo() {
 __block int i = 3;
 void (^myBlock)(void) = ^{
    i  *= 2;
 };
 myBlock();
 }
 struct Block_byref { // Block_private.h中的定义
    void  *isa;
    struct Block_byref *forwarding;
    volatile int32_t flags;
    uint32_t size;
 };
 
 // __block count 实现
 struct __Block_byref_count_0 {
    void *__isa;
    __Block_byref_count_0 *__forwarding;
    int __flags;
    int __size;
    int count;
 };
 
 void foo_() {
 __attribute__ ((__blocks__(byref))) __Block_byref_count_0 count = {
    (void *)0,(__Block_byref_count_0 *)&count,0,sizeof(__Block_byref_count_0),1};
 
 void(*myBlock)(void) = (void (*)())&__foo_block_impl_0((void *)__foo_block_func_0,&__foo_block_desc_0_DATA,(__Block_byref_count_0 *)&count,570425344);
 
 ((void (*)(__block_impl *))((__block_impl *)myBlock)->FunCPtr)((__block_impl *)myBlock);

 }
 只因为加了一个__block,原本的int值的位置变成了一个struct (struct __Block_byref),这个struct的首地址同样为*isa
 正是如此，这个值才能被block共享，并且不受栈帧声明周期的限制，在block被copy之后，能够随着block赋值到堆上
 
 避免循环引用：block是一个对象，它捕获的值就是这个对象的@property（strong）
 这样在遇到问题的时候，就能迅速确定是否有循环引用了
 */



- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[NWUser class]]) {
        return NO;
    }
    
    
    return [self isEqualToNWUser:(NWUser *)object];
}

- (BOOL)isEqualToNWUser:(NWUser *)user {
    
    if (!user) {
        return NO;
    }
    
    // 名字匹配
    
    BOOL nameMatch = (!self.name && !user.name) || [self.name isEqualToString:user.name];
    // 性别匹配
    
    
    return nameMatch;
}

- (NSUInteger)hash {
    // 对关键属性的hash 异或返回重载hash实践
    return [self.sex hash] ^ [self.name hash];
}

#pragma mark - KVO

- (void)willChangeValueForKey:(NSString *)key {
    NSLog(@"000--%@",NSStringFromSelector(_cmd));
    [super willChangeValueForKey:key];
}

- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"111--%@",NSStringFromSelector(_cmd));
    [super didChangeValueForKey:key];
}

@end
