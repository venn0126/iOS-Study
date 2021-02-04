//
//  NWClass.m
//  NWModel
//
//  Created by Augus on 2021/2/3.
//

#import "NWClass.h"

@interface NWClass ()

@property (nonatomic, copy) NSString *name;


@end

@implementation NWClass



- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _name = name;
    return self;
}

- (void)logName {
    [self printName];
}

- (void)printName {
    
    NSLog(@"print name %@",self.name);
}

- (void)dealloc {
    
    NSLog(@"nw class dealloc");
}
 
 /**
  * Returns the offset of an instance variable.
  *
  * @param v The instance variable you want to enquire about.
  *
  * @return The offset of \e v.
  *
  * @note For instance variables of type \c id or other object types, call \c object_getIvar
  *  and \c object_setIvar instead of using this offset to access the instance variable data directly.
  *   ivar_getOffset函数，对于类型id或其它对象类型的实例变量，可以调用object_getIvar和object_setIvar来直接访问成员变量，而不使用偏移量。
  */
// OBJC_EXPORT ptrdiff_t
// ivar_getOffset(Ivar _Nonnull v)
//     OBJC_AVAILABLE(10.5, 2.0, 9.0, 1.0, 2.0);

/*
 
 

struct objc_method
{
  SEL method_name; <方法名：方法名为此方法的方法签名，相同函数名和参数的方法名是一样的
  char * method_types;<方法类型： 描述方法的参数类型
  IMP method_imp;<方法真实实现代码块的地址指针，可像C 一样直接调用
};
 
 
 objc_property_t property = class_getProperty([YYWeiboStatus class], "user");
2
3     unsigned int num;
4     objc_property_attribute_t *attr = property_copyAttributeList(property, &num);
5     for (unsigned int i = 0; i < num; i++) {
6
7         objc_property_attribute_t att = attr[i];
8         fprintf(stdout, "name = %s , value = %s \n",att.name , att.value);
9     }
10
11     const char *chars = property_getAttributes(property);
12     fprintf(stdout, "%s \n",chars);
 
 printf:
 
 1 name = T , value = @"YYWeiboUser"
 2 name = & , value =
 3 name = N , value =
 4 name = V , value = _user
 5 T@"YYWeiboUser",&,N,V_user
 
 
 struct objc_class {
     Class _Nonnull isa  OBJC_ISA_AVAILABILITY;
 #if !__OBJC2__
     Class _Nullable super_class                              OBJC2_UNAVAILABLE;
     const char * _Nonnull name                               OBJC2_UNAVAILABLE;
     long version                                             OBJC2_UNAVAILABLE;
     long info                                                OBJC2_UNAVAILABLE;
     long instance_size                                       OBJC2_UNAVAILABLE;
     struct objc_ivar_list * _Nullable ivars                  OBJC2_UNAVAILABLE;
     struct objc_method_list * _Nullable * _Nullable methodLists                    OBJC2_UNAVAILABLE;
     struct objc_cache * _Nonnull cache                       OBJC2_UNAVAILABLE;
     struct objc_protocol_list * _Nullable protocols          OBJC2_UNAVAILABLE;
 #endif

 } OBJC2_UNAVAILABLE;
 // Use `Class` instead of `struct objc_class *`
 
 
 
 1.YYModel 阅读

 YYClassInfo的阅读

 0xFF 16进制



 ivar，就是Instance VARiable的缩写，意思是：
 实例变量
 
 
 2 不同锁的机制
 
 OSSpinLock：自旋锁，iOS之后被apple禁止，因为优先级反转，忙等待
 
 dispatch_semaphore_t :信号量，sem_wait,调用的是glibc底层，
 实现原理：
 初始化一个值，然后进行wait操作，-1，如果大于0，在立刻返回，
 
 pthread 表示POSIX thread，定义了一组跨平台线程相关的api，pthread_mutex表示互斥锁，
 原理：阻塞线程，睡眠，进行上下文切换
 
 pthread_mutexattr_t attr;
 pthread_mutexattr_init(&attr);
 
 
  * Mutex type attributes
 #define PTHREAD_MUTEX_NORMAL        0
 #define PTHREAD_MUTEX_ERRORCHECK    1
 #define PTHREAD_MUTEX_RECURSIVE        2
 #define PTHREAD_MUTEX_DEFAULT        PTHREAD_MUTEX_NORMAL
 pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL);  // 定义锁的属性

 pthread_mutex_t mutex;
 pthread_mutex_init(&mutex, &attr) // 初始化锁

 pthread_mutex_lock(&mutex); // 申请锁
     // 临界区
 pthread_mutex_unlock(&mutex); // 释放锁
 
 
 NSLock 它的实现非常简单，通过宏，定义了 lock 方法:实际调用的是pthread_mutex
 #define    MLOCK \
 - (void) lock\
 {\
   int err = pthread_mutex_lock(&_mutex);\
   // 错误处理 ……
 }
 
 NSLock 只是在内部封装了一个 pthread_mutex，属性为 PTHREAD_MUTEX_ERRORCHECK，它会损失一定性能换来错误提示

 
 NSCondition
 
 NSCondition 的底层是通过条件变量(condition variable) pthread_cond_t 来实现的。条件变量有点像信号量，提供了线程阻塞与信号机制，因此可以用来阻塞某个线程，并等待某个数据就绪，随后唤醒线程，比如常见的生产者-消费者模式。
 
 eg:(需要与互斥锁搭配使用，常见的消费者生产者模式)
 
 void consumer(){
 
    pthread_mutex_lock(&lock);
    while(data == NULL){
        // 阻塞线程 等待数据(wait)
        pthread_cond_wait(&condition_variable_signal,&mutex);
    }
 
    // 有新的数据需要处理
    tmp = data
    // 有新的数据需要处理
 
    pthread_mutex_unlock(&lock);
 }
 
 void producer(){
    pthread_mutex_lock(&lock);
    // 生产数据(signal)
    pthread_cond_singal(&condition_variable_signal,&mutex);// 发出信号
    pthread_mutex_unlock(&lock);

 }
 
 
 NSConditionLock
 NSConditionLock 借助 NSCondition 来实现，它的本质就是一个生产者-消费者模型。“条件被满足”可以理解为生产者提供了新的内容。NSConditionLock 的内部持有一个 NSCondition 对象，以及 _condition_value 属性，在初始化时就会对这个属性进行赋值:
 
 - (id)initWithCondition:(NSInteger)value{
    self = [super init];
    if !self return nil;
    _condition = [NSCondition new];
    _condition_value = value;
    return self;
 }
 
 - (void)lockWhenCondition:(NSInteger)value {
    [_condition lock];
    while(value != _condition_value){
        [_condition wait];
    }
 }
 
 - (void)unlockWhenCondition:(NSInteger)value {
 
    _condition_value = value;
    // 广播
    [_condition broadcast];
    [_condition unlock];
    
 }
 
 
 NSRecursiveLock
 递归锁也是通过 pthread_mutex_lock,类型是PTHREAD_MUTEX_RECURSIVE 函数来实现，在函数内部会判断锁的类型，如果显示是递归锁，就允许递归调用，仅仅将一个计数器加一，锁的释放过程也是同理。
 
 @synchronized:Objective-C runtime 都会为其分配一个递归锁并存储在哈希表中。
 这其实是一个 OC 层面的锁， 主要是通过牺牲性能换来语法上的简洁与可读。
 我们知道 @synchronized 后面需要紧跟一个 OC 对象，它实际上是把这个对象当做锁来使用。这是通过一个哈希表来实现的，OC 在底层使用了一个互斥锁的数组(你可以理解为锁池)，通过对对象去哈希值来得到对应的互斥锁。
 
 
 
*/
 

@end
